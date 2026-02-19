import SwiftUI

struct TrainingScreen: View {
    @ObservedObject var gameState: GameState
    @StateObject private var soundManager = SoundManager.shared
    @State private var selectedChoice: String? = nil
    @State private var showResult = false
    @State private var showScenarioSetup = true
    @State private var setupCountdown = 3
    @State private var showParticles = false
    @State private var setupTimer: Timer?
    
    var body: some View {
        ZStack {
            // Background
            LinearGradient(
                colors: [.black.opacity(0.1), .red.opacity(0.05)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            // Particle effects
            if showParticles {
                ParticleSystem(type: .fire)
                    .frame(height: 200)
                    .offset(y: -200)
            }
            
            if showScenarioSetup {
                ScenarioSetupView(
                    scenario: gameState.currentScenario,
                    countdown: $setupCountdown
                ) {
                    withAnimation {
                        showScenarioSetup = false
                        startScenario()
                    }
                }
            } else {
                ScrollView {
                    if let scenario = gameState.currentScenario,
                       let step = gameState.currentStep {
                        VStack(spacing: 24) {
                            // Timer with color changes
                            TimerDisplay(timeRemaining: gameState.timerManager.timeRemaining)
                                .padding(.top)
                            
                            // Progress
                            VStack(spacing: 8) {
                                HStack {
                                    Text("Scenario \(gameState.currentScenarioIndex + 1) of \(gameState.scenarios.count)")
                                        .font(.caption.bold())
                                    
                                    Spacer()
                                    
                                    Text("Step \(gameState.currentStepIndex + 1) of \(scenario.steps.count)")
                                        .font(.caption)
                                }
                                .foregroundStyle(.secondary)
                                
                                ProgressView(value: Double(gameState.currentScenarioIndex + 1), total: Double(gameState.scenarios.count))
                                    .tint(timerColor())
                            }
                            .padding(.horizontal)
                            
                            // Scenario Card
                            VStack(spacing: 16) {
                                // Animated icon
                                ZStack {
                                    Circle()
                                        .fill(.red.opacity(0.1))
                                        .frame(width: 100, height: 100)
                                    
                                    Image(systemName: scenario.imageIcon)
                                        .font(.system(size: 50))
                                        .foregroundStyle(.red.gradient)
                                }
                                
                                Text(scenario.title)
                                    .font(.title2.bold())
                                    .multilineTextAlignment(.center)
                                
                                Text(scenario.description)
                                    .font(.body)
                                    .foregroundStyle(.secondary)
                                    .multilineTextAlignment(.center)
                                
                                // Hazard indicators
                                if !scenario.hazards.isEmpty {
                                    HStack(spacing: 12) {
                                        ForEach(scenario.hazards, id: \.self) { hazard in
                                            HStack(spacing: 4) {
                                                Image(systemName: hazard.icon)
                                                    .font(.caption)
                                                Text(hazard.rawValue)
                                                    .font(.caption2)
                                            }
                                            .padding(.horizontal, 8)
                                            .padding(.vertical, 4)
                                            .background(hazard.color.opacity(0.2))
                                            .cornerRadius(8)
                                        }
                                    }
                                }
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(16)
                            .padding(.horizontal)
                            
                            // Question
                            Text(step.prompt)
                                .font(.headline)
                                .padding(.horizontal)
                            
                            // Choices with enhanced feedback
                            ForEach(step.choices) { choice in
                                ChoiceButton(
                                    choice: choice,
                                    isSelected: selectedChoice == choice.id,
                                    showResult: showResult,
                                    isCorrect: choice.id == step.correctChoiceId
                                ) {
                                    handleChoice(choice, step: step)
                                }
                                .disabled(showResult)
                            }
                            .padding(.horizontal)
                        }
                        .padding(.vertical)
                    }
                }
            }
        }
        .navigationTitle("Training")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            setupScenario()
        }
        .onDisappear {
            setupTimer?.invalidate()
            setupTimer = nil
            gameState.timerManager.stopTimer()
        }
    }
    
    private func setupScenario() {
        showScenarioSetup = true
        setupCountdown = 3
        selectedChoice = nil
        showResult = false
        showParticles = false
        
        setupTimer?.invalidate()
        setupTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if setupCountdown > 0 {
                setupCountdown -= 1
                soundManager.playTick()
            } else {
                timer.invalidate()
                setupTimer = nil
            }
        }
    }
    
    private func startScenario() {
        showParticles = true
        soundManager.playFireCrackle()
        
        gameState.timerManager.startTimer(duration: 60) {
            // Time up
            gameState.mistakes += 1
            soundManager.playAlarm()
            nextStep()
        }
    }
    
    private func handleChoice(_ choice: Choice, step: DecisionStep) {
        guard !showResult else { return }
        
        selectedChoice = choice.id
        showResult = true
        gameState.timerManager.pauseTimer()
        
        let isCorrect = choice.id == step.correctChoiceId
        gameState.recordDecision(correct: isCorrect)
        
        if isCorrect {
            soundManager.playSuccess()
            HapticManager.shared.success()
        } else {
            soundManager.playError()
            HapticManager.shared.error()
            showParticles = false
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            nextStep()
        }
    }
    
    private func nextStep() {
        selectedChoice = nil
        showResult = false
        
        let wasLastStep = gameState.currentStep == gameState.currentScenario?.steps.last
        
        if wasLastStep {
            gameState.nextScenario()
            
            if gameState.currentScenario != nil {
                setupScenario()
            }
        } else {
            gameState.nextStep()
            
            if gameState.currentStep != nil {
                gameState.timerManager.reset()
                gameState.timerManager.startTimer(duration: 60) {
                    gameState.mistakes += 1
                    nextStep()
                }
            }
        }
    }
    
    private func timerColor() -> Color {
        let time = gameState.timerManager.timeRemaining
        if time > 40 { return .green }
        if time > 20 { return .orange }
        return .red
    }
}

struct ScenarioSetupView: View {
    let scenario: Scenario?
    @Binding var countdown: Int
    let onComplete: () -> Void
    
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            
            if let scenario = scenario {
                VStack(spacing: 20) {
                    Image(systemName: scenario.imageIcon)
                        .font(.system(size: 80))
                        .foregroundStyle(.red.gradient)
                    
                    Text("Get Ready!")
                        .font(.title.bold())
                    
                    Text(scenario.title)
                        .font(.title3)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                    
                    // Countdown
                    if countdown > 0 {
                        Text("\(countdown)")
                            .font(.system(size: 100, weight: .bold))
                            .foregroundStyle(.red)
                    }
                }
            }
            
            Spacer()
        }
        .padding()
        .onChange(of: countdown) { oldValue, newValue in
            if newValue == 0 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    onComplete()
                }
            }
        }
    }
}

struct TimerDisplay: View {
    let timeRemaining: Int
    
    private var timerColor: Color {
        if timeRemaining > 40 { return .green }
        if timeRemaining > 20 { return .orange }
        return .red
    }
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "timer")
                .font(.title2)
            
            Text("\(timeRemaining)s")
                .font(.system(size: 36, weight: .bold, design: .rounded))
            
            Text("remaining")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .foregroundStyle(timerColor)
        .padding()
        .background(timerColor.opacity(0.1))
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(timerColor, lineWidth: 2)
        )
    }
}

struct ChoiceButton: View {
    let choice: Choice
    let isSelected: Bool
    let showResult: Bool
    let isCorrect: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                Text(choice.text)
                    .font(.body)
                    .foregroundStyle(.primary)
                    .multilineTextAlignment(.leading)
                
                Spacer()
                
                if showResult && isSelected {
                    ZStack {
                        Circle()
                            .fill(isCorrect ? Color.green : Color.red)
                            .frame(width: 32, height: 32)
                        
                        Image(systemName: isCorrect ? "checkmark" : "xmark")
                            .font(.headline.bold())
                            .foregroundStyle(.white)
                    }
                }
            }
            .padding()
            .background(backgroundColor)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(borderColor, lineWidth: 2)
            )
        }
        .buttonStyle(.plain)
    }
    
    private var backgroundColor: Color {
        if showResult && isSelected {
            return isCorrect ? Color.green.opacity(0.2) : Color.red.opacity(0.2)
        }
        return Color(.systemGray6)
    }
    
    private var borderColor: Color {
        if showResult && isSelected {
            return isCorrect ? Color.green : Color.red
        }
        return Color.clear
    }
}
