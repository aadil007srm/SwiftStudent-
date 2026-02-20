import SwiftUI

enum AppScreen {
    case intro
    case home
    case environmentSelection
    case training
    case completion
}

@MainActor
class GameState: ObservableObject {
    @Published var currentScreen: AppScreen = .intro
    @Published var selectedEnvironment: EnvironmentType = .lab
    @Published var currentScenarioIndex: Int = 0

    // Persistent stats with UserDefaults
    @Published var score: Int {
        didSet { UserDefaults.standard.set(score, forKey: "totalScore") }
    }
    @Published var mistakes: Int {
        didSet { UserDefaults.standard.set(mistakes, forKey: "totalMistakes") }
    }
    @Published var totalDecisions: Int {
        didSet { UserDefaults.standard.set(totalDecisions, forKey: "totalDecisions") }
    }
    @Published var correctDecisions: Int {
        didSet { UserDefaults.standard.set(correctDecisions, forKey: "correctDecisions") }
    }

    @Published var timerManager = TimerManager()
    @Published var badgesEarnedThisSession: Set<String> = []

    var scenarios: [Scenario] = []
    var currentScenario: Scenario? {
        scenarios.indices.contains(currentScenarioIndex) ? scenarios[currentScenarioIndex] : nil
    }

    var accuracyPercentage: Int {
        guard totalDecisions > 0 else { return 0 }
        return Int((Double(correctDecisions) / Double(totalDecisions)) * 100)
    }

    // Initialize with saved values
    init() {
        self.score = UserDefaults.standard.integer(forKey: "totalScore")
        self.mistakes = UserDefaults.standard.integer(forKey: "totalMistakes")
        self.totalDecisions = UserDefaults.standard.integer(forKey: "totalDecisions")
        self.correctDecisions = UserDefaults.standard.integer(forKey: "correctDecisions")
    }

    func loadScenarios(for environment: EnvironmentType) {
        let allScenarios = ScenarioData.scenarios(for: environment)
        // Select 10 random scenarios for this session from the full pool
        scenarios = Array(allScenarios.shuffled().prefix(10))
        currentScenarioIndex = 0
        badgesEarnedThisSession.removeAll()
    }

    func nextScenario() {
        if currentScenarioIndex < scenarios.count - 1 {
            currentScenarioIndex += 1
        } else {
            currentScreen = .completion
        }
    }

    func recordDecision(correct: Bool) {
        totalDecisions += 1
        if correct {
            correctDecisions += 1
            score += 10
        } else {
            mistakes += 1
        }
    }

    func reset() {
        currentScreen = .home
        currentScenarioIndex = 0
        timerManager.reset()
        badgesEarnedThisSession.removeAll()
        // NOTE: Don't reset total stats - those persist!
    }
}
