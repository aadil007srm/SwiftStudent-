import SwiftUI

enum AppScreen {
    case intro
    case home
    case environmentSelection
    case training
    case completion
}

@MainActor  // ✅ Added MainActor to entire class
class GameState: ObservableObject {
    @Published var currentScreen: AppScreen = .intro
    @Published var selectedEnvironment: EnvironmentType = .lab
    @Published var currentScenarioIndex: Int = 0
    @Published var score: Int = 0
    @Published var mistakes: Int = 0
    @Published var totalDecisions: Int = 0
    @Published var correctDecisions: Int = 0
    @Published var timerManager = TimerManager()
    @Published var badgesEarnedThisSession: Set<String> = []  // Track new badges
    
    var scenarios: [Scenario] = []
    var currentScenario: Scenario? {
        scenarios.indices.contains(currentScenarioIndex) ? scenarios[currentScenarioIndex] : nil
    }
    
    var accuracyPercentage: Int {
        guard totalDecisions > 0 else { return 0 }
        return Int((Double(correctDecisions) / Double(totalDecisions)) * 100)
    }
    
    func loadScenarios(for environment: EnvironmentType) {
        scenarios = ScenarioData.scenarios(for: environment)
        currentScenarioIndex = 0
        badgesEarnedThisSession.removeAll()  // Reset for new session
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
        score = 0
        mistakes = 0
        totalDecisions = 0
        correctDecisions = 0
        timerManager.reset()
        badgesEarnedThisSession.removeAll()
    }
}
