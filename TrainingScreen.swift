import SwiftUI

struct TrainingScreen: View {
    @ObservedObject var gameState: GameState  // ✅ Removed 'weak'
    @StateObject private var badgeManager = BadgeManager()
    @State private var selectedChoice: String? = nil
    @State private var showResult = false
    @State private var showTimeoutMessage = false
    
    var body: some View {
        NavigationStack {
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
                                    handleChoice(choice)  // ✅ Extracted to method
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
                        
                        if showTimeoutMessage {
                            VStack {
                                Image(systemName: "clock.badge.exclamationmark")
                                    .font(.system(size: 50))
                                    .foregroundColor(.red)
                                Text("Time's Up!")
                                    .font(.title.bold())
                                Text("Moving to next scenario...")
                                    .foregroundColor(.secondary)
                            }
                            .padding()
                            .background(Color.red.opacity(0.1))
                            .cornerRadius(16)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Training")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        withAnimation {
                            gameState.currentScreen = .home
                        }
                    } label: {
                        Image(systemName: "chevron.left")
                    }
                }
            }
        }
        .onAppear {
            startScenario()  // ✅ Extracted to method
        }
    }
    
    // ✅ Proper MainActor method
    private func handleChoice(_ choice: Choice) {
        selectedChoice = choice.id
        showResult = true
        gameState.timerManager.pauseTimer()
        gameState.recordDecision(correct: choice.isCorrect)
        
        Task { @MainActor in
            badgeManager.checkAndAwardBadges(gameState: gameState)
            
            try? await Task.sleep(nanoseconds: 2_000_000_000)
            nextScenario()
        }
    }
    
    // ✅ Proper MainActor method
    private func startScenario() {
        gameState.timerManager.startTimer(duration: 60) { [weak gameState] in
            Task { @MainActor in
                guard let gameState = gameState else { return }
                gameState.mistakes += 1
                showTimeoutMessage = true
                
                try? await Task.sleep(nanoseconds: 2_000_000_000)
                showTimeoutMessage = false
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
        if time > 45 { return .green }
        if time > 30 { return Color(red: 0.7, green: 0.9, blue: 0.3) }
        if time > 20 { return .yellow }
        if time > 10 { return .orange }
        return .red
    }
    
    func nextScenario() {
        selectedChoice = nil
        showResult = false
        gameState.nextScenario()
        
        if gameState.currentScenario != nil {
            gameState.timerManager.reset()
            startScenario()
        }
    }
}
