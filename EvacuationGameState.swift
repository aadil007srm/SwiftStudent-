import SwiftUI
import EvacuationEngine

@MainActor
class EvacuationGameState: ObservableObject {
    // MARK: - Timer
    @Published var timeRemaining: Int = 60
    @Published var timerColor: Color = .green
    let initialTime: Int = 60
    static let gameDuration: Int = 60

    // MARK: - Map elements
    @Published var selectedMap: MapLayout = MapDataProvider.labMaps[0]
    @Published var playerPosition: CGPoint = .zero
    @Published var fireLocations: [FireHazard] = []
    @Published var smokeZones: [SmokeZone] = []
    @Published var exitDoors: [ExitDoor] = []
    @Published var trappedPeople: [Person] = []
    @Published var extinguishers: [EvacuationExtinguisher] = []

    // MARK: - Feature 2: Extinguisher state
    @Published var hasExtinguisher: Bool = false
    /// Remaining suppression uses for the held extinguisher.
    @Published var extinguisherCharge: Int = 0
    /// Configurable radius for auto-pickup.
    let extinguisherPickupRadius: CGFloat = 20
    /// Configurable radius for fire suppression.
    let extinguisherSuppressionRadius: CGFloat = 40

    // MARK: - Feature 3: Follower state
    /// Subset of rescuedPeople that are actively following the player along the route.
    @Published var followers: [Person] = []
    /// Player's current index into drawnRoute during execution.
    @Published var playerRouteIndex: Int = 0
    /// Whether the player is currently in heavy smoke (causes movement slowdown).
    @Published var inHeavySmoke: Bool = false

    // MARK: - Game state
    @Published var gamePhase: GamePhase = .planning
    @Published var drawnRoute: [CGPoint] = []
    @Published var routeSafetyScore: Int = 100
    @Published var routeDistance: CGFloat = 0
    @Published var rescuedPeople: [Person] = []
    @Published var score: Int = 0
    @Published var grade: String = ""

    // MARK: - Internal timers
    private var countdownTimer: Timer?
    private var fireSpreadTimer: Timer?
    private var executionTimer: Timer?
    /// Ticks elapsed since execution started; used to implement smoke-based slowdown.
    private var executionTick: Int = 0
    /// Consecutive execution ticks spent in heavy smoke (Feature 4: sustained smoke failure).
    private var smokeExposureTicks: Int = 0

    enum GamePhase {
        case tutorial
        case planning
        case executing
        case completed
    }

    // MARK: - Setup
    func startGame(with map: MapLayout? = nil) {
        let layout = map ?? MapDataProvider.labMaps[0]
        selectedMap = layout
        loadMap()
        startTimer()
        startFireSpread()
    }

    private func loadMap() {
        playerPosition   = selectedMap.startPosition
        fireLocations    = selectedMap.fireStarts.map { FireHazard(position: $0, intensity: .small) }
        smokeZones       = FireSpreadEngine.generateSmoke(from: fireLocations)
        exitDoors        = selectedMap.exitDoors
        trappedPeople    = selectedMap.trappedPeople
        extinguishers    = selectedMap.extinguishers
        drawnRoute       = []
        rescuedPeople    = []
        followers        = []
        routeSafetyScore = 100
        routeDistance    = 0
        score            = 0
        grade            = ""
        timeRemaining    = initialTime
        timerColor       = .green
        hasExtinguisher  = false
        extinguisherCharge = 0
        playerRouteIndex = 0
        inHeavySmoke     = false
        smokeExposureTicks = 0
        gamePhase        = .planning
    }

    // MARK: - Countdown Timer
    private func startTimer() {
        countdownTimer?.invalidate()
        let t = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            Task { @MainActor [weak self] in
                guard let self else { return }
                if self.timeRemaining > 0 {
                    self.timeRemaining -= 1
                    self.updateTimerColor()
                } else {
                    self.countdownTimer?.invalidate()
                    self.countdownTimer = nil
                    self.gameOver(success: false)
                }
            }
        }
        RunLoop.main.add(t, forMode: .common)
        countdownTimer = t
    }

    private func updateTimerColor() {
        timerColor = timeRemaining > 30 ? .green : timeRemaining > 10 ? .orange : .red
    }

    // MARK: - Fire Spread
    private func startFireSpread() {
        fireSpreadTimer?.invalidate()
        let t = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { [weak self] _ in
            Task { @MainActor [weak self] in
                self?.spreadFire()
            }
        }
        RunLoop.main.add(t, forMode: .common)
        fireSpreadTimer = t
    }

    private func spreadFire() {
        let newFires = FireSpreadEngine.calculateSpread(
            from: fireLocations,
            walls: selectedMap.walls,
            timeElapsed: initialTime - timeRemaining
        )
        fireLocations = newFires
        // Feature 4: evolve smoke (expand + persist)
        smokeZones = FireSpreadEngine.evolveSmoke(existing: smokeZones, fires: fireLocations)
        updateExitStatus()
    }

    private func updateExitStatus() {
        for i in exitDoors.indices {
            let exit = exitDoors[i]
            let nearbyFires = fireLocations.filter { fire in
                !fire.isSuppressed && dist(fire.position, exit.position) < 40
            }
            if !nearbyFires.isEmpty {
                exitDoors[i].status = .blocked
            } else {
                let nearbySmoke = smokeZones.filter { dist($0.center, exit.position) < 60 }
                exitDoors[i].status = nearbySmoke.isEmpty ? .safe : .risky
            }
        }
    }

    // MARK: - Route Management
    func validateRoute(_ path: [CGPoint]) {
        guard !path.isEmpty else { return }

        drawnRoute = path

        // Reset rescued state so re-drawing recomputes correctly
        trappedPeople = selectedMap.trappedPeople
        rescuedPeople = []
        followers = []
        // Reset extinguisher pickup state
        extinguishers = selectedMap.extinguishers
        hasExtinguisher = false
        extinguisherCharge = 0

        // Calculate route distance
        routeDistance = 0
        for i in 0..<(path.count - 1) {
            routeDistance += dist(path[i], path[i + 1])
        }

        // Calculate safety score
        var safetyPoints = 100
        for point in path {
            if FireSpreadEngine.isInFire(point, fires: fireLocations) {
                safetyPoints -= 30
            }
            if FireSpreadEngine.isInHeavySmoke(point, smokeZones: smokeZones) {
                safetyPoints -= 10
            }
        }
        routeSafetyScore = max(0, safetyPoints)

        // Feature 3: detect rescuable people along the route
        for i in trappedPeople.indices {
            // Find nearest route point to this person
            if let nearestIdx = path.indices.min(by: {
                dist(path[$0], trappedPeople[i].position) < dist(path[$1], trappedPeople[i].position)
            }), dist(path[nearestIdx], trappedPeople[i].position) < 20 {
                trappedPeople[i].isRescued = true
                trappedPeople[i].isFollower = true
                var follower = trappedPeople[i]
                // Follower starts from the nearest route point to their position
                follower.followerRouteIndex = nearestIdx
                rescuedPeople.append(follower)
                followers.append(follower)
            }
        }

        // Feature 2: detect extinguisher pickup along the route
        for i in extinguishers.indices {
            if path.contains(where: { dist($0, extinguishers[i].position) < extinguisherPickupRadius }) {
                extinguishers[i].isPickedUp = true
                hasExtinguisher = true
                extinguisherCharge = 3
            }
        }

        // Haptic feedback based on safety score
        if routeSafetyScore >= 80 {
            HapticManager.shared.success()
        } else if routeSafetyScore >= 50 {
            HapticManager.shared.warning()
        } else {
            HapticManager.shared.error()
        }
    }

    // MARK: - Feature 2: Apply extinguisher effect at a map point
    func applyExtinguisher(at mapPoint: CGPoint) {
        guard hasExtinguisher, extinguisherCharge > 0 else { return }
        extinguisherCharge -= 1
        if extinguisherCharge == 0 { hasExtinguisher = false }

        // Suppress all fires within suppression radius
        for i in fireLocations.indices {
            if dist(fireLocations[i].position, mapPoint) < extinguisherSuppressionRadius {
                fireLocations[i].isSuppressed = true
            }
        }
        smokeZones = FireSpreadEngine.evolveSmoke(existing: smokeZones, fires: fireLocations)
        updateExitStatus()
    }

    // MARK: - Execution Phase (Feature 3 + 4)

    /// Starts the execution animation: player moves along drawnRoute.
    func startExecution() {
        guard !drawnRoute.isEmpty, gamePhase == .planning else { return }
        gamePhase = .executing
        playerRouteIndex = 0
        executionTick = 0
        smokeExposureTicks = 0

        // Position each follower at the nearest route point to their original map position
        for i in followers.indices {
            let idx = min(max(0, followers[i].followerRouteIndex), drawnRoute.count - 1)
            followers[i].followerRouteIndex = idx
            followers[i].position = drawnRoute[idx]
        }

        executionTimer?.invalidate()
        let timer = Timer.scheduledTimer(withTimeInterval: 0.06, repeats: true) { [weak self] _ in
            Task { @MainActor [weak self] in
                self?.advanceExecution()
            }
        }
        RunLoop.main.add(timer, forMode: .common)
        executionTimer = timer
    }

    private func advanceExecution() {
        executionTick += 1

        // Feature 4: track sustained heavy-smoke exposure; fail if > ~2 seconds (~33 ticks at 0.06s)
        inHeavySmoke = FireSpreadEngine.isInHeavySmoke(playerPosition, smokeZones: smokeZones)
        if inHeavySmoke {
            smokeExposureTicks += 1
            score = max(0, score - 1)   // score penalty for lingering in heavy smoke
            if smokeExposureTicks > 33 {
                gameOver(success: false)
                return
            }
            // Feature 4: smoke slows movement – skip every other tick when in heavy smoke
            if executionTick.isMultiple(of: 2) { return }
        } else {
            smokeExposureTicks = 0
        }

        // Advance player
        let nextPlayerIndex = playerRouteIndex + 1
        guard nextPlayerIndex < drawnRoute.count else {
            finishExecution()
            return
        }
        playerRouteIndex = nextPlayerIndex
        playerPosition = drawnRoute[playerRouteIndex]

        // Feature 2: auto-pickup extinguisher when player is within pickup radius
        for i in extinguishers.indices where !extinguishers[i].isPickedUp {
            if dist(extinguishers[i].position, playerPosition) < extinguisherPickupRadius {
                extinguishers[i].isPickedUp = true
                hasExtinguisher = true
                extinguisherCharge = 3
                HapticManager.shared.success()
            }
        }

        // Feature 2: auto-suppress nearby fire (step down intensity: large→medium→small→out),
        //   consuming one charge per fire touched per pass.
        if hasExtinguisher && extinguisherCharge > 0 {
            for i in fireLocations.indices where !fireLocations[i].isSuppressed {
                if dist(fireLocations[i].position, playerPosition) < extinguisherSuppressionRadius {
                    switch fireLocations[i].intensity {
                    case .large:  fireLocations[i].intensity = .medium
                    case .medium: fireLocations[i].intensity = .small
                    case .small:  fireLocations[i].isSuppressed = true
                    }
                    extinguisherCharge -= 1
                    if extinguisherCharge == 0 {
                        hasExtinguisher = false
                        break
                    }
                }
            }
        }

        // Feature 3: rescue trapped people when player reaches them during execution
        for i in trappedPeople.indices where !trappedPeople[i].isRescued {
            if dist(trappedPeople[i].position, playerPosition) < 25 {
                trappedPeople[i].isRescued = true
                var follower = trappedPeople[i]
                follower.isFollower = true
                // Follower joins at the nearest route point to their position
                let nearestIdx = drawnRoute.indices.min(by: {
                    dist(drawnRoute[$0], trappedPeople[i].position) < dist(drawnRoute[$1], trappedPeople[i].position)
                }) ?? playerRouteIndex
                follower.followerRouteIndex = max(0, nearestIdx)
                follower.position = drawnRoute[follower.followerRouteIndex]
                followers.append(follower)
                rescuedPeople.append(follower)
                // Risk penalty if rescuing in active fire without an extinguisher
                if FireSpreadEngine.isInFire(playerPosition, fires: fireLocations) && !hasExtinguisher {
                    score = max(0, score - 50)
                }
                HapticManager.shared.success()
            }
        }

        // Feature 3: advance followers – each trails behind by a fixed route-point offset
        let followerOffset = 8  // route points behind the player
        for i in followers.indices {
            let targetIndex = max(0, playerRouteIndex - followerOffset * (i + 1))
            followers[i].followerRouteIndex = targetIndex
            followers[i].position = drawnRoute[targetIndex]
        }

        // Check if player reached an exit
        for exit in exitDoors where exit.status != .blocked {
            if dist(playerPosition, exit.position) < 25 {
                finishExecution()
                return
            }
        }
    }

    private func finishExecution() {
        executionTimer?.invalidate()
        executionTimer = nil
        completeEvacuation()
    }

    // MARK: - Completion

    func completeEvacuation() {
        executionTimer?.invalidate()
        countdownTimer?.invalidate()
        fireSpreadTimer?.invalidate()
        calculateFinalScore()
        gamePhase = .completed
    }

    private func calculateFinalScore() {
        score += 1000
        score += timeRemaining * 10
        score += rescuedPeople.count * 100
        score += routeSafetyScore >= 90 ? 200 : 0
        score = max(0, score)

        if score >= 1800 { grade = "S" }
        else if score >= 1500 { grade = "A" }
        else if score >= 1200 { grade = "B" }
        else if score >= 900  { grade = "C" }
        else if score >= 600  { grade = "D" }
        else { grade = "F" }
    }

    private func gameOver(success: Bool) {
        executionTimer?.invalidate()
        countdownTimer?.invalidate()
        fireSpreadTimer?.invalidate()
        if !success {
            score = 0
            grade = "F"
        } else {
            calculateFinalScore()
        }
        gamePhase = .completed
    }

    func resetGame() {
        executionTimer?.invalidate()
        countdownTimer?.invalidate()
        fireSpreadTimer?.invalidate()
        startGame(with: selectedMap)
    }

    // MARK: - Helper Functions
    private func dist(_ p1: CGPoint, _ p2: CGPoint) -> CGFloat {
        let dx = p2.x - p1.x, dy = p2.y - p1.y
        return sqrt(dx * dx + dy * dy)
    }
}
