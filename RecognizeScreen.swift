import SwiftUI

struct RecognizeScreen: View {
    @ObservedObject var gameState: GameState
    @State private var selectedChoice: String? = nil
    @State private var showFeedback = false
    @State private var startTime = Date()
    @State private var timeElapsed: Double = 0
    @State private var showTimeUpAlert = false
    
    let emergencyRed = Color(red: 1.0, green: 0.3, blue: 0.2)
    let emergencyOrange = Color(red: 1.0, green: 0.5, blue: 0.0)
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(UIColor.systemGroupedBackground)
                    .ignoresSafeArea()
                
                ScrollView {
                    if let scenario = gameState.currentScenario {
                        VStack(spacing: 20) {
                            // Timer Display
                            TimerDisplayView(timerManager: gameState.timerManager)
                                .padding(.horizontal)
                            
                            // Critical Indicators
                            HStack(spacing: 12) {
                                // Urgency
                                IndicatorBadge(
                                    icon: "exclamationmark.triangle.fill",
                                    label: "URGENCY",
                                    value: urgencyText(scenario.urgencyLevel),
                                    color: emergencyRed
                                )
                                
                                // Risk Level
                                IndicatorBadge(
                                    icon: "gauge.high",
                                    label: "RISK",
                                    value: "\(Int(gameState.riskLevel * 100))%",
                                    color: riskColor()
                                )
                            }
                            .padding(.horizontal)
                            
                            // Progress Section
                            VStack(spacing: 8) {
                                HStack {
                                    Text("Scenario \(gameState.currentScenarioIndex + 1) of \(gameState.scenarios.count)")
                                        .font(.subheadline.weight(.medium))
                                        .foregroundColor(.primary)
                                    
                                    Spacer()
                                }
                                
                                ProgressView(value: Double(gameState.currentScenarioIndex + 1), total: Double(gameState.scenarios.count))
                                    .tint(emergencyRed)
                            }
                            .padding()
                            .background(Color(UIColor.secondarySystemGroupedBackground))
                            .cornerRadius(12)
                            .padding(.horizontal)
                            
                            // Hazard Type
                            HStack {
                                Image(systemName: scenario.hazardType.icon)
                                Text(scenario.hazardType.rawValue.uppercased())
                            }
                            .font(.caption.weight(.bold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 14)
                            .padding(.vertical, 7)
                            .background(scenario.hazardType.color)
                            .cornerRadius(20)
                            
                            // Scenario Card
                            VStack(spacing: 16) {
                                ZStack {
                                    Circle()
                                        .fill(scenario.urgencyLevel.color.opacity(0.15))
                                        .frame(width: 80, height: 80)
                                    
                                    Image(systemName: scenario.imageIcon)
                                        .font(.system(size: 40))
                                        .foregroundColor(scenario.urgencyLevel.color)
                                }
                                
                                Text(scenario.title)
                                    .font(.title3.bold())
                                    .foregroundColor(.primary)
                                    .multilineTextAlignment(.center)
                                
                                Text(scenario.description)
                                    .font(.body)
                                    .foregroundColor(.secondary)
                                    .multilineTextAlignment(.center)
                                    .lineSpacing(4)
                            }
                            .padding()
                            .background(Color(UIColor.secondarySystemGroupedBackground))
                            .cornerRadius(16)
                            .padding(.horizontal)
                            
                            // Question
                            HStack {
                                Image(systemName: "questionmark.circle.fill")
                                    .foregroundColor(emergencyOrange)
                                Text("What is your emergency response?")
                                    .font(.headline)
                                    .foregroundColor(.primary)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                            .padding(.top, 8)
                            
                            // Choices
                            VStack(spacing: 12) {
                                ForEach(scenario.choices) { choice in
                                    ChoiceButton(
                                        choice: choice,
                                        isSelected: selectedChoice == choice.id,
                                        showFeedback: showFeedback
                                    ) {
                                        if !showFeedback {
                                            selectedChoice = choice.id
                                            timeElapsed = Date().timeIntervalSince(startTime)
                                            
                                            gameState.timerManager.pauseTimer()
                                            
                                            withAnimation {
                                                showFeedback = true
                                            }
                                            
                                            if choice.isCorrect {
                                                HapticManager.shared.success()
                                            } else {
                                                HapticManager.shared.error()
                                            }
                                            
                                            gameState.recordDecision(correct: choice.isCorrect, timeElapsed: timeElapsed)
                                            
                                            if !choice.isCorrect {
                                                gameState.lastMistake = MistakeInfo(
                                                    scenario: scenario.title,
                                                    wrongChoice: choice.text,
                                                    correctChoice: scenario.choices.first(where: { $0.id == scenario.correctChoiceId })?.text ?? "",
                                                    explanation: choice.explanation,
                                                    consequence: choice.consequence
                                                )
                                                
                                                gameState.weakCategories[scenario.hazardType, default: 0] += 1
                                            }
                                            
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                                if choice.isCorrect {
                                                    proceedToNext()
                                                } else {
                                                    withAnimation {
                                                        gameState.currentScreen = .mistake
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal)
                            
                            // Control & Stability Indicators
                            HStack(spacing: 12) {
                                // Control
                                IndicatorBadge(
                                    icon: "hand.raised.fill",
                                    label: "CONTROL",
                                    value: showFeedback ? (selectedChoice != nil ? "Active" : "Pending") : "Ready",
                                    color: .blue
                                )
                                
                                // Stability
                                IndicatorBadge(
                                    icon: "checkmark.shield.fill",
                                    label: "STABILITY",
                                    value: stabilityLevel(),
                                    color: .green
                                )
                            }
                            .padding(.horizontal)
                            
                            // Stats
                            HStack(spacing: 12) {
                                StatDisplay(icon: "star.fill", value: "\(gameState.score)", label: "Score", color: .orange)
                                StatDisplay(icon: "xmark.circle.fill", value: "\(gameState.mistakes)", label: "Errors", color: .red)
                                StatDisplay(icon: "checkmark.circle.fill", value: "\(Int(gameState.accuracyPercentage))%", label: "Accuracy", color: .green)
                            }
                            .padding(.horizontal)
                        }
                        .padding(.vertical)
                    }
                }
                
                if showTimeUpAlert {
                    TimeUpOverlay {
                        handleTimeUp()
                    }
                }
            }
            .navigationTitle("Emergency Response")
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationViewStyle(.stack)
        .onAppear {
            startTime = Date()
            selectedChoice = nil
            showFeedback = false
            showTimeUpAlert = false
            
            gameState.timerManager.startTimer(duration: 60) {
                if !showFeedback {
                    withAnimation {
                        showTimeUpAlert = true
                    }
                }
            }
        }
        .onDisappear {
            gameState.timerManager.stopTimer()
        }
    }
    
    func urgencyText(_ level: UrgencyLevel) -> String {
        switch level {
        case .low: return "Low"
        case .medium: return "Medium"
        case .high: return "High"
        case .critical: return "CRITICAL"
        }
    }
    
    func riskColor() -> Color {
        if gameState.riskLevel < 0.3 {
            return .green
        } else if gameState.riskLevel < 0.6 {
            return emergencyOrange
        } else {
            return emergencyRed
        }
    }
    
    func stabilityLevel() -> String {
        if gameState.riskLevel < 0.3 {
            return "Stable"
        } else if gameState.riskLevel < 0.6 {
            return "Moderate"
        } else {
            return "Unstable"
        }
    }
    
    func proceedToNext() {
        gameState.completedScenarios.append(gameState.currentScenario?.title ?? "")
        
        if gameState.currentScenarioIndex < gameState.scenarios.count - 1 {
            withAnimation {
                gameState.currentScenarioIndex += 1
                startTime = Date()
                selectedChoice = nil
                showFeedback = false
            }
        } else {
            checkAchievements()
            withAnimation {
                gameState.currentScreen = .completion
            }
        }
    }
    
    func handleTimeUp() {
        HapticManager.shared.error()
        gameState.mistakes += 1
        gameState.totalDecisions += 1
        gameState.riskLevel = min(1.0, gameState.riskLevel + 0.3)
        
        gameState.lastMistake = MistakeInfo(
            scenario: gameState.currentScenario?.title ?? "Unknown",
            wrongChoice: "No decision made in time",
            correctChoice: gameState.currentScenario?.choices.first(where: { $0.id == gameState.currentScenario?.correctChoiceId })?.text ?? "",
            explanation: "In emergencies, quick decision-making is critical. Hesitation can cost lives.",
            consequence: "Time ran out! Delay in emergencies can be fatal."
        )
        
        withAnimation {
            showTimeUpAlert = false
            gameState.currentScreen = .mistake
        }
    }
    
    func checkAchievements() {
        if gameState.mistakes == 0 {
            gameState.addAchievement(Achievement(
                title: "Zero Mistake Handler",
                description: "Completed training without errors",
                icon: "star.fill"
            ))
        }
        
        if gameState.accuracyPercentage >= 90 {
            gameState.addAchievement(Achievement(
                title: "Hazard Expert",
                description: "90%+ accuracy achieved",
                icon: "shield.fill"
            ))
        }
        
        let avgTime = gameState.reactionTimes.reduce(0, +) / Double(max(gameState.reactionTimes.count, 1))
        if avgTime < 5.0 {
            gameState.addAchievement(Achievement(
                title: "Quick Responder",
                description: "Average response under 5 seconds",
                icon: "bolt.fill"
            ))
        }
        
        let totalTimeUsed = gameState.reactionTimes.reduce(0, +)
        if totalTimeUsed < 180 && gameState.accuracyPercentage >= 80 {
            gameState.addAchievement(Achievement(
                title: "Speed Demon",
                description: "Completed training quickly with high accuracy",
                icon: "hare.fill"
            ))
        }
    }
}

struct IndicatorBadge: View {
    let icon: String
    let label: String
    let value: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 6) {
            HStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.system(size: 12))
                Text(label)
                    .font(.system(size: 10, weight: .bold))
            }
            .foregroundColor(color)
            
            Text(value)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.primary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 10)
        .background(color.opacity(0.1))
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .strokeBorder(color.opacity(0.3), lineWidth: 1.5)
        )
    }
}

struct ChoiceButton: View {
    let choice: Choice
    let isSelected: Bool
    let showFeedback: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text(choice.text)
                    .font(.body)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.leading)
                
                if showFeedback && isSelected {
                    HStack {
                        Image(systemName: choice.isCorrect ? "checkmark.circle.fill" : "xmark.circle.fill")
                        Text(choice.isCorrect ? "Correct Response!" : choice.consequence)
                            .font(.caption)
                    }
                    .foregroundColor(choice.isCorrect ? .green : .red)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(backgroundColor())
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(borderColor(), lineWidth: 2)
            )
        }
        .buttonStyle(PlainButtonStyle())
        .disabled(showFeedback)
    }
    
    func backgroundColor() -> Color {
        if showFeedback && isSelected {
            return choice.isCorrect ? Color.green.opacity(0.1) : Color.red.opacity(0.1)
        }
        return Color(UIColor.secondarySystemGroupedBackground)
    }
    
    func borderColor() -> Color {
        if showFeedback && isSelected {
            return choice.isCorrect ? .green : .red
        }
        return isSelected ? .blue : Color.clear
    }
}

struct StatDisplay: View {
    let icon: String
    let value: String
    let label: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .foregroundColor(color)
                .font(.system(size: 18))
            Text(value)
                .font(.headline)
                .foregroundColor(.primary)
            Text(label)
                .font(.caption2)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(Color(UIColor.secondarySystemGroupedBackground))
        .cornerRadius(12)
    }
}

struct TimerDisplayView: View {
    @ObservedObject var timerManager: TimerManager
    
    let emergencyRed = Color(red: 1.0, green: 0.3, blue: 0.2)
    let emergencyOrange = Color(red: 1.0, green: 0.5, blue: 0.0)
    
    var body: some View {
        HStack(spacing: 15) {
            ZStack {
                Circle()
                    .stroke(Color(UIColor.systemGray5), lineWidth: 6)
                    .frame(width: 70, height: 70)
                
                Circle()
                    .trim(from: 0, to: timerManager.getProgressPercentage())
                    .stroke(timerColor(), lineWidth: 6)
                    .frame(width: 70, height: 70)
                    .rotationEffect(.degrees(-90))
                    .animation(.linear(duration: 0.5), value: timerManager.timeRemaining)
                
                VStack(spacing: 2) {
                    Image(systemName: "timer")
                        .font(.system(size: 14))
                        .foregroundColor(timerColor())
                    Text("\(timerManager.timeRemaining)")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .foregroundColor(timerColor())
                }
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text("TIME PRESSURE")
                    .font(.caption.weight(.bold))
                    .foregroundColor(.secondary)
                
                Text(timeMessage())
                    .font(.subheadline.weight(.semibold))
                    .foregroundColor(timerColor())
            }
            
            Spacer()
        }
        .padding()
        .background(Color(UIColor.secondarySystemGroupedBackground))
        .cornerRadius(12)
    }
    
    func timerColor() -> Color {
        let time = timerManager.timeRemaining
        if time > 40 { return .green }
        if time > 20 { return emergencyOrange }
        return emergencyRed
    }
    
    func timeMessage() -> String {
        let time = timerManager.timeRemaining
        if time > 40 { return "Under Control" }
        if time > 20 { return "Act Quickly" }
        if time > 10 { return "URGENT!" }
        return "CRITICAL!"
    }
}

struct TimeUpOverlay: View {
    let onDismiss: () -> Void
    
    let emergencyRed = Color(red: 1.0, green: 0.3, blue: 0.2)
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.6)
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                Image(systemName: "clock.badge.exclamationmark.fill")
                    .font(.system(size: 70))
                    .foregroundColor(emergencyRed)
                
                Text("Time's Up!")
                    .font(.largeTitle.bold())
                    .foregroundColor(.primary)
                
                Text("In emergencies, every second counts.\nQuick decision-making saves lives.")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                
                Button(action: onDismiss) {
                    Text("Continue")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(emergencyRed)
                        .cornerRadius(12)
                }
            }
            .padding(30)
            .background(Color(UIColor.systemBackground))
            .cornerRadius(24)
            .shadow(radius: 20)
            .padding(.horizontal, 30)
        }
    }
}
