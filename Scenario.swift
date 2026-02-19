import SwiftUI

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
    
    // Backward compatibility initializer
    init(title: String, description: String, imageIcon: String, choices: [Choice], 
         environment: EnvironmentType = .factory, hazards: [HazardType] = [], 
         steps: [DecisionStep] = [], timeLimit: Int = 60, consequence: String = "") {
        self.title = title
        self.description = description
        self.imageIcon = imageIcon
        self.choices = choices
        self.environment = environment
        self.hazards = hazards
        self.steps = steps.isEmpty ? [DecisionStep(prompt: "What should you do?", choices: choices, correctChoiceId: choices.first(where: { $0.isCorrect })?.id ?? "", consequence: consequence)] : steps
        self.timeLimit = timeLimit
        self.consequence = consequence
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
