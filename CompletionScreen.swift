import SwiftUI

struct CompletionScreen: View {
    @ObservedObject var gameState: GameState
    
    var body: some View {
        NavigationStack {
            List {
                // Results Header
                Section {
                    VStack(spacing: 20) {
                        Image(systemName: resultIcon())
                            .font(.system(size: 70))
                            .foregroundStyle(resultColor().gradient)
                        
                        Text("Training Complete!")
                            .font(.title.bold())
                        
                        Text(performanceMessage())
                            .font(.body)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                }
                .listRowBackground(Color.clear)
                
                // Performance Grade
                Section("Performance Grade") {
                    HStack {
                        Text("Grade")
                        Spacer()
                        Text(grade())
                            .font(.title.bold())
                            .foregroundStyle(gradeColor())
                    }
                }
                
                // Detailed Results
                Section("Results") {
                    LabeledContent("Final Score", value: "\(gameState.score)")
                    LabeledContent("Accuracy", value: "\(gameState.accuracyPercentage)%")
                    LabeledContent("Correct Answers", value: "\(gameState.correctDecisions)")
                    LabeledContent("Mistakes", value: "\(gameState.mistakes)")
                    LabeledContent("Total Decisions", value: "\(gameState.totalDecisions)")
                }
                
                // Actions
                Section {
                    Button {
                        withAnimation {
                            gameState.reset()
                        }
                    } label: {
                        HStack {
                            Spacer()
                            Label("Train Again", systemImage: "arrow.clockwise")
                                .font(.headline)
                            Spacer()
                        }
                    }
                    .tint(.red)
                    
                    Button {
                        gameState.currentScreen = .home
                    } label: {
                        HStack {
                            Spacer()
                            Label("Back to Home", systemImage: "house")
                            Spacer()
                        }
                    }
                }
            }
            .navigationTitle("Results")
        }
    }
    
    private func resultIcon() -> String {
        let accuracy = gameState.accuracyPercentage
        if accuracy >= 90 { return "trophy.fill" }
        if accuracy >= 70 { return "star.fill" }
        return "checkmark.circle.fill"
    }
    
    private func resultColor() -> Color {
        let accuracy = gameState.accuracyPercentage
        if accuracy >= 90 { return .yellow }
        if accuracy >= 70 { return .green }
        return .blue
    }
    
    private func performanceMessage() -> String {
        let accuracy = gameState.accuracyPercentage
        if accuracy >= 90 { return "Excellent work! You're an expert responder." }
        if accuracy >= 70 { return "Good job! You have solid emergency skills." }
        return "Keep practicing to improve your response skills."
    }
    
    private func grade() -> String {
        let accuracy = gameState.accuracyPercentage
        if accuracy >= 90 { return "A" }
        if accuracy >= 80 { return "B" }
        if accuracy >= 70 { return "C" }
        if accuracy >= 60 { return "D" }
        return "F"
    }
    
    private func gradeColor() -> Color {
        let accuracy = gameState.accuracyPercentage
        if accuracy >= 90 { return .green }
        if accuracy >= 70 { return .orange }
        return .red
    }
}
