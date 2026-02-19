import SwiftUI

struct Scenario: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let imageIcon: String
    let choices: [Choice]
}

struct Choice: Identifiable {
    let id: String
    let text: String
    let isCorrect: Bool
}
