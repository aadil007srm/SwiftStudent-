import SwiftUI

struct TrainingScreen: View {
    @ObservedObject var gameState: GameState
    @State private var selectedChoice: String? = nil
    @State private var showResult = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                if let scenario = gameState.currentScenario {
                    VStack(spacing: 24) {
                        // Timer
                        HStack {
                            Image(systemName: "timer")
                            Text("\(gameState.timerManager.timeRemaining)s")
                                .font(.title.bold())
                        }
                        .foregroundColor(timerColor())
                        .padding()
                        .background(timerColor().opacity(0.1))
                        .cornerRadius(12)
                        
                        // Progress
                        VStack(spacing: 8) {
                            Text("Scenario \(gameState.currentScenarioIndex + 1) of \(gameState.scenarios.count)")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            ProgressView(value: Double(gameState.currentScenarioIndex + 1), total: Double(gameState.scenarios.count))
                                .tint(.red)
                        }
                        
                        // Scenario
                        VStack(spacing: 16) {
                            Image(systemName: scenario.imageIcon)
                                .font(.system(size: 60))
                                .foregroundColor(.red)
                            
                            Text(scenario.title)
                                .font(.title2.bold())
                                .multilineTextAlignment(.center)
                            
                            Text(scenario.description)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(16)
                        
                        // Question
                        Text("What should you do?")
                            .font(.headline)
                        
                        // Choices
                        ForEach(scenario.choices) { choice in
                            Button {
                                if !showResult {
                                    selectedChoice = choice.id
                                    showResult = true
                                    gameState.timerManager.pauseTimer()
                                    gameState.recordDecision(correct: choice.isCorrect)
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                        nextScenario()
                                    }
                                }
                            } label: {
                                HStack {
                                    Text(choice.text)
                                        .foregroundColor(.primary)
                                    Spacer()
                                    if showResult && selectedChoice == choice.id {
                                        Image(systemName: choice.isCorrect ? "checkmark.circle.fill" : "xmark.circle.fill")
                                            .foregroundColor(choice.isCorrect ? .green : .red)
                                    }
                                }
                                .padding()
                                .background(buttonBackground(for: choice))
                                .cornerRadius(12)
                            }
                            .disabled(showResult)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Training")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            gameState.timerManager.startTimer(duration: 60) {
                // Time up
                gameState.mistakes += 1
                nextScenario()
            }
        }
    }
    
    func buttonBackground(for choice: Choice) -> Color {
        if showResult && selectedChoice == choice.id {
            return choice.isCorrect ? Color.green.opacity(0.2) : Color.red.opacity(0.2)
        }
        return Color(.systemGray6)
    }
    
    func timerColor() -> Color {
        let time = gameState.timerManager.timeRemaining
        if time > 40 { return .green }
        if time > 20 { return .orange }
        return .red
    }
    
    func nextScenario() {
        selectedChoice = nil
        showResult = false
        gameState.nextScenario()
        
        if gameState.currentScenario != nil {
            gameState.timerManager.reset()
            gameState.timerManager.startTimer(duration: 60) {
                gameState.mistakes += 1
                nextScenario()
            }
        }
    }
}
