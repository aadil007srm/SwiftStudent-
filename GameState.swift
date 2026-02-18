import SwiftUI

enum AppScreen {
    case intro
    case home
    case environmentSelection
    case learning
    case recognize
    case response
    case mistake
    case storage
    case completion
}

class GameState: ObservableObject {
    @Published var currentScreen: AppScreen = .intro
    @Published var selectedEnvironment: EnvironmentType = .lab
    @Published var currentPhase: TrainingPhase = .recognize
    @Published var currentScenarioIndex: Int = 0
    @Published var score: Int = 0
    @Published var mistakes: Int = 0
    @Published var totalDecisions: Int = 0
    @Published var correctDecisions: Int = 0
    @Published var riskLevel: Double = 0.0
    @Published var achievements: [Achievement] = []
    @Published var reactionTimes: [Double] = []
    @Published var lastMistake: MistakeInfo? = nil
    @Published var completedScenarios: [String] = []
    @Published var weakCategories: [HazardType: Int] = [:]
    @Published var timerManager = TimerManager()
    
    var scenarios: [Scenario] = []
    var currentScenario: Scenario? {
        scenarios.indices.contains(currentScenarioIndex) ? scenarios[currentScenarioIndex] : nil
    }
    
    var accuracyPercentage: Double {
        guard totalDecisions > 0 else { return 0 }
        return (Double(correctDecisions) / Double(totalDecisions)) * 100
    }
    
    func loadScenarios(for environment: EnvironmentType) {
        scenarios = ScenarioData.scenarios(for: environment)
        currentScenarioIndex = 0
    }
    
    func nextScenario() {
        if currentScenarioIndex < scenarios.count - 1 {
            currentScenarioIndex += 1
        } else {
            currentScreen = .completion
        }
    }
    
    func recordDecision(correct: Bool, timeElapsed: Double) {
        totalDecisions += 1
        if correct {
            correctDecisions += 1
            // Bonus points for quick decisions
            let timeBonus = timerManager.timeRemaining > 45 ? 15 : (timerManager.timeRemaining > 30 ? 10 : 5)
            score += 10 + timeBonus
            riskLevel = max(0, riskLevel - 0.1)
        } else {
            mistakes += 1
            riskLevel = min(1.0, riskLevel + 0.2)
        }
        reactionTimes.append(timeElapsed)
    }
    
    func addAchievement(_ achievement: Achievement) {
        if !achievements.contains(where: { $0.id == achievement.id }) {
            achievements.append(achievement)
        }
    }
    
    func reset() {
        currentScreen = .home
        currentPhase = .recognize
        currentScenarioIndex = 0
        score = 0
        mistakes = 0
        totalDecisions = 0
        correctDecisions = 0
        riskLevel = 0.0
        lastMistake = nil
        completedScenarios = []
        reactionTimes = []
        timerManager.reset()
    }
}

enum TrainingPhase {
    case recognize
    case respond
    case performance
}

struct MistakeInfo {
    let scenario: String
    let wrongChoice: String
    let correctChoice: String
    let explanation: String
    let consequence: String
}

struct Achievement: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let icon: String
}
