import SwiftUI

enum AppScreen {
    case intro
    case onboarding
    case home
    case environmentSelection
    case training
    case completion
}

class GameState: ObservableObject {
    @Published var currentScreen: AppScreen = .intro
    @Published var selectedEnvironment: EnvironmentType = .lab
    @Published var currentScenarioIndex: Int = 0
    @Published var score: Int = 0
    @Published var mistakes: Int = 0
    @Published var totalDecisions: Int = 0
    @Published var correctDecisions: Int = 0
    @Published var timerManager = TimerManager()
    @Published var currentStepIndex: Int = 0
    
    var scenarios: [Scenario] = []
    var currentScenario: Scenario? {
        scenarios.indices.contains(currentScenarioIndex) ? scenarios[currentScenarioIndex] : nil
    }
    
    var currentStep: DecisionStep? {
        guard let scenario = currentScenario else { return nil }
        return scenario.steps.indices.contains(currentStepIndex) ? scenario.steps[currentStepIndex] : nil
    }
    
    var accuracyPercentage: Int {
        guard totalDecisions > 0 else { return 0 }
        return Int((Double(correctDecisions) / Double(totalDecisions)) * 100)
    }
    
    func loadScenarios(for environment: EnvironmentType) {
        scenarios = ScenarioData.scenarios(for: environment)
        currentScenarioIndex = 0
        currentStepIndex = 0
    }
    
    func nextScenario() {
        if currentScenarioIndex < scenarios.count - 1 {
            currentScenarioIndex += 1
            currentStepIndex = 0
        } else {
            currentScreen = .completion
        }
    }
    
    func nextStep() {
        guard let scenario = currentScenario else { return }
        if currentStepIndex < scenario.steps.count - 1 {
            currentStepIndex += 1
        } else {
            nextScenario()
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
        currentStepIndex = 0
        score = 0
        mistakes = 0
        totalDecisions = 0
        correctDecisions = 0
        timerManager.reset()
    }
}
