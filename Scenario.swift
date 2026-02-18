import SwiftUI

struct Scenario: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let environment: EnvironmentType
    let hazardType: HazardType
    let imageIcon: String
    let interactionType: InteractionType
    let choices: [Choice]
    let correctChoiceId: String
    let educationalContext: String
    let urgencyLevel: UrgencyLevel
    let responseSteps: [ResponseStep]
}

enum InteractionType {
    case multipleChoice
    case dragAndDrop
    case sequencing
    case tapToIdentify
}

struct Choice: Identifiable {
    let id: String
    let text: String
    let consequence: String
    let isCorrect: Bool
    let explanation: String
}

enum UrgencyLevel {
    case low
    case medium
    case high
    case critical
    
    var color: Color {
        switch self {
        case .low: return .green
        case .medium: return .yellow
        case .high: return .orange
        case .critical: return .red
        }
    }
}

struct ResponseStep: Identifiable {
    let id = UUID()
    let stepNumber: Int
    let instruction: String
    let icon: String
}
