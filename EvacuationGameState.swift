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
                guard let self, self.gamePhase == .planning || self.gamePhase == .executing else { return }
                self.spreadFire()
            }
        }
        RunLoop.main.add(t, forMode: .common)
        fireSpreadTimer = t
    }

    private func spreadFire() {
        fireLocations = FireSpreadEngine.calculateSpread(from: fireLocations, walls: selectedMap.walls)
        smokeZones    = FireSpreadEngine.generateSmoke(from: fireLocations)
        updateExitDoorStatuses()
    }

    private func updateExitDoorStatuses() {
        exitDoors = exitDoors.map { door in
            var d = door
            let blocked = fireLocations.contains {
                FireSpreadEngine.distance($0.position, door.position) < 40
            }
            let smoky = smokeZones.contains {
                $0.density == .medium && FireSpreadEngine.distance($0.center, door.position) < $0.radius
            }
            d.status = blocked ? .blocked : smoky ? .risky : .safe
            return d
        }
    }

    // MARK: - Drawing
    func canDrawAt(_ point: CGPoint) -> Bool {
        guard gamePhase == .planning else { return false }
        return !FireSpreadEngine.isHazardous(point, fires: fireLocations, smokeZones: smokeZones)
    }

    func validateAndScoreRoute(_ path: [CGPoint]) {
        drawnRoute = path
        guard !path.isEmpty else {
            rescuedPeople    = []
            routeSafetyScore = 100
            routeDistance    = 0
            return
        }

        // Check for rescued people
        rescuedPeople = trappedPeople.filter { person in
            path.contains { FireSpreadEngine.distance($0, person.position) < 30 }
        }

        // Safety score: penalise smoke exposure
        var penalty = 0
        for point in path {
            for smoke in smokeZones where smoke.density != .light {
                if FireSpreadEngine.distance(point, smoke.center) < smoke.radius {
                    penalty += 2
                }
            }
        }
        routeSafetyScore = max(0, 100 - penalty)

        // Route distance
        routeDistance = zip(path, path.dropFirst()).reduce(0) { acc, pair in
            acc + FireSpreadEngine.distance(pair.0, pair.1)
        }

        // Mark extinguishers used
        extinguishers = extinguishers.map { ext in
            var e = ext
            if path.contains(where: { FireSpreadEngine.distance($0, ext.position) < 30 }) {
                e.isUsed = true
            }
            return e
        }
    }

    // MARK: - Finish
    func finishEvacuation() {
        guard gamePhase != .completed else { return }
        stopTimers()
        score = calculateScore()
        grade = calculateGrade(score)
        gamePhase = .completed
    }

    private func gameOver(success: Bool) {
        stopTimers()
        if success {
            score = calculateScore()
            grade = calculateGrade(score)
        } else {
            score = max(0, calculateScore() / 2)
            grade = "F"
        }
        gamePhase = .completed
    }

    private func stopTimers() {
        countdownTimer?.invalidate()
        countdownTimer = nil
        fireSpreadTimer?.invalidate()
        fireSpreadTimer = nil
    }

    private func calculateScore() -> Int {
        var total = 1000
        total += timeRemaining * 10
        total += rescuedPeople.count * 100
        if routeSafetyScore >= 90 { total += 200 }
        let usedExtinguishers = extinguishers.filter(\.isUsed).count
        total += usedExtinguishers * 150
        if routeSafetyScore < 50 { total -= 100 }
        return max(0, total)
    }

    private func calculateGrade(_ s: Int) -> String {
        switch s {
        case 1800...: return "S"
        case 1500..<1800: return "A"
        case 1200..<1500: return "B"
        case 900..<1200: return "C"
        case 600..<900: return "D"
        default: return "F"
        }
    }

    // MARK: - Reset
    func resetGame() {
        stopTimers()
        loadMap()
        startTimer()
        startFireSpread()
    }
}
