import SwiftUI

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
        routeSafetyScore = 100
        routeDistance    = 0
        score            = 0
        grade            = ""
        timeRemaining    = initialTime
        timerColor       = .green
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
        smokeZones = FireSpreadEngine.generateSmoke(from: fireLocations)
        updateExitStatus()
    }

    private func updateExitStatus() {
        for i in exitDoors.indices {
            let exit = exitDoors[i]
            let nearbyFires = fireLocations.filter { fire in
                distance(from: fire.position, to: exit.position) < 40
            }
            
            if !nearbyFires.isEmpty {
                exitDoors[i].status = .blocked
            } else {
                let nearbySmoke = smokeZones.filter { smoke in
                    distance(from: smoke.center, to: exit.position) < 60
                }
                exitDoors[i].status = nearbySmoke.isEmpty ? .safe : .risky
            }
        }
    }

    // MARK: - Route Management
    func validateRoute(_ path: [CGPoint]) {
        guard !path.isEmpty else { return }
        
        // Store the drawn route
        drawnRoute = path
        
        // Calculate route distance
        routeDistance = 0
        for i in 0..<(path.count - 1) {
            routeDistance += distance(from: path[i], to: path[i + 1])
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
        
        // Check rescued people
        for person in trappedPeople where !rescuedPeople.contains(where: { $0.id == person.id }) {
            if path.contains(where: { distance(from: $0, to: person.position) < 20 }) {
                var rescuedPerson = person
                rescuedPerson.isRescued = true
                rescuedPeople.append(rescuedPerson)
            }
        }
        
        // Provide haptic feedback based on safety score
        if routeSafetyScore >= 80 {
            HapticManager.shared.success()
        } else if routeSafetyScore >= 50 {
            HapticManager.shared.warning()
        } else {
            HapticManager.shared.error()
        }
    }

    func completeEvacuation() {
        countdownTimer?.invalidate()
        fireSpreadTimer?.invalidate()
        calculateFinalScore()
        gamePhase = .completed
    }

    private func calculateFinalScore() {
        score = 1000
        score += timeRemaining * 10
        score += rescuedPeople.count * 100
        score += routeSafetyScore >= 90 ? 200 : 0
        score = max(0, score)
        
        // Assign grade
        if score >= 1800 { grade = "S" }
        else if score >= 1500 { grade = "A" }
        else if score >= 1200 { grade = "B" }
        else if score >= 900 { grade = "C" }
        else if score >= 600 { grade = "D" }
        else { grade = "F" }
    }

    private func gameOver(success: Bool) {
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
        countdownTimer?.invalidate()
        fireSpreadTimer?.invalidate()
        startGame(with: selectedMap)
    }

    // MARK: - Helper Functions
    private func distance(from p1: CGPoint, to p2: CGPoint) -> CGFloat {
        sqrt(pow(p2.x - p1.x, 2) + pow(p2.y - p1.y, 2))
    }
}
