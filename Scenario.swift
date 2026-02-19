import SwiftUI

// MARK: - Scenario Visual Style
enum ScenarioVisualStyle {
    case electricalFire      // Blue-yellow gradient, spark effects
    case chemicalFire        // Purple-red gradient, smoke effects
    case mechanicalFire      // Orange-red gradient, gear icons
    case gasLeak            // Green-yellow gradient, cloud effects
    case explosion          // Red-orange gradient, burst effect
    case burn               // Orange gradient, flame effects
    case general            // Default style
    
    var backgroundGradient: [Color] {
        switch self {
        case .electricalFire: return [.blue, .yellow]
        case .chemicalFire: return [.purple, .red]
        case .mechanicalFire: return [.orange, .red]
        case .gasLeak: return [.green, .yellow]
        case .explosion: return [.red, .orange]
        case .burn: return [.orange, .red]
        case .general: return [.blue, .purple]
        }
    }
}

// MARK: - Scenario Category
enum ScenarioCategory: String {
    case fire = "Fire"
    case chemical = "Chemical"
    case electrical = "Electrical"
    case mechanical = "Mechanical"
    case firstAid = "First Aid"
    case evacuation = "Evacuation"
}

// MARK: - Scenario Difficulty
enum ScenarioDifficulty: String {
    case beginner = "Beginner"      // Obvious correct answer
    case intermediate = "Intermediate" // Need to think
    case advanced = "Advanced"      // Multiple correct steps, tricky
    case expert = "Expert"          // Complex multi-step scenarios
}

// MARK: - Hazard Level
enum HazardLevel: String {
    case low = "Low Risk"
    case medium = "Medium Risk"
    case high = "High Risk"
    case critical = "CRITICAL - Life Threatening"
    
    var color: Color {
        switch self {
        case .low: return .green
        case .medium: return .yellow
        case .high: return .orange
        case .critical: return .red
        }
    }
    
    var icon: String {
        switch self {
        case .low: return "exclamationmark.circle"
        case .medium: return "exclamationmark.triangle"
        case .high: return "exclamationmark.triangle.fill"
        case .critical: return "exclamationmark.octagon.fill"
        }
    }
}

// MARK: - Scenario Model
struct Scenario: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let imageIcon: String
    let choices: [Choice]
    let environment: EnvironmentType
    let hazards: [HazardType]
    let steps: [DecisionStep]
    let timeLimit: Int
    let consequence: String
    let visualStyle: ScenarioVisualStyle
    let category: ScenarioCategory
    let difficulty: ScenarioDifficulty
    let hazardLevel: HazardLevel
    
    // Backward compatibility initializer
    init(title: String, description: String, imageIcon: String, choices: [Choice], 
         environment: EnvironmentType = .factory, hazards: [HazardType] = [], 
         steps: [DecisionStep] = [], timeLimit: Int = 60, consequence: String = "",
         visualStyle: ScenarioVisualStyle = .general,
         category: ScenarioCategory = .fire,
         difficulty: ScenarioDifficulty = .intermediate,
         hazardLevel: HazardLevel = .medium) {
        self.title = title
        self.description = description
        self.imageIcon = imageIcon
        self.choices = choices
        self.environment = environment
        self.hazards = hazards
        self.timeLimit = timeLimit
        self.consequence = consequence
        self.visualStyle = visualStyle
        self.category = category
        self.difficulty = difficulty
        self.hazardLevel = hazardLevel
        
        // Create default step if no steps provided
        if steps.isEmpty {
            let correctChoiceId = choices.first(where: { $0.isCorrect })?.id ?? ""
            self.steps = [
                DecisionStep(
                    prompt: "What should you do?",
                    choices: choices,
                    correctChoiceId: correctChoiceId,
                    consequence: consequence
                )
            ]
        } else {
            self.steps = steps
        }
    }
}

struct Choice: Identifiable {
    let id: String
    let text: String
    let isCorrect: Bool
    let explanation: String
    
    init(id: String, text: String, isCorrect: Bool, explanation: String = "") {
        self.id = id
        self.text = text
        self.isCorrect = isCorrect
        self.explanation = explanation
    }
}

struct DecisionStep: Identifiable {
    let id = UUID()
    let prompt: String
    let choices: [Choice]
    let correctChoiceId: String
    let consequence: String
    let explanation: String
    
    init(prompt: String, choices: [Choice], correctChoiceId: String, consequence: String, explanation: String = "") {
        self.prompt = prompt
        self.choices = choices
        self.correctChoiceId = correctChoiceId
        self.consequence = consequence
        self.explanation = explanation
    }
}
