import SwiftUI

struct CompletionScreen: View {
    @ObservedObject var gameState: GameState
    @StateObject private var badgeManager = BadgeManager()
    @State private var showConfetti = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Main Content
                List {
                    // Results Header
                    Section {
                        VStack(spacing: 20) {
                            ZStack {
                                Circle()
                                    .fill(resultColor().opacity(0.2).gradient)
                                    .frame(width: 120, height: 120)
                                
                                Image(systemName: resultIcon())
                                    .font(.system(size: 60))
                                    .foregroundStyle(resultColor().gradient)
                            }
                            .scaleEffect(showConfetti ? 1.0 : 0.8)
                            .animation(.spring(duration: 0.6), value: showConfetti)
                            
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
                                .font(.headline)
                            Spacer()
                            Text(grade())
                                .font(.system(size: 48, weight: .bold, design: .rounded))
                                .foregroundStyle(gradeColor())
                        }
                        .padding(.vertical, 8)
                    }
                    
                    // Detailed Results
                    Section("Results") {
                        LabeledContent("Final Score", value: "\(gameState.score)")
                        LabeledContent("Accuracy", value: "\(gameState.accuracyPercentage)%")
                        LabeledContent("Correct Answers", value: "\(gameState.correctDecisions)")
                        LabeledContent("Mistakes", value: "\(gameState.mistakes)")
                        LabeledContent("Total Decisions", value: "\(gameState.totalDecisions)")
                    }
                    
                    // Newly Earned Badges
                    let newBadges = getNewlyEarnedBadges()
                    if !newBadges.isEmpty {
                        Section("🎉 New Badges Earned!") {
                            ForEach(newBadges) { badge in
                                HStack(spacing: 12) {
                                    ZStack {
                                        Circle()
                                            .fill(badge.color.gradient)
                                            .frame(width: 50, height: 50)
                                        
                                        Image(systemName: badge.icon)
                                            .font(.title3)
                                            .foregroundStyle(.white)
                                    }
                                    
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(badge.name)
                                            .font(.headline)
                                        Text(badge.description)
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                    }
                                }
                                .padding(.vertical, 4)
                            }
                        }
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
                
                // Confetti Effect (optional visual enhancement)
                if showConfetti && gameState.accuracyPercentage >= 90 {
                    ConfettiView()
                        .allowsHitTesting(false)
                }
            }
            .onAppear {
                withAnimation {
                    showConfetti = true
                }
                badgeManager.checkAndAwardBadges(gameState: gameState)
            }
        }
    }
    
    private func getNewlyEarnedBadges() -> [Badge] {
        badgeManager.checkAndAwardBadges(gameState: gameState)
        return BadgeManager.allBadges.filter { badgeManager.earnedBadges.contains($0.name) }
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

// Simple Confetti Effect
struct ConfettiView: View {
    @State private var animate = false
    
    var body: some View {
        ZStack {
            ForEach(0..<30, id: \.self) { index in
                ConfettiPiece(index: index)
            }
        }
        .onAppear {
            animate = true
        }
    }
}

struct ConfettiPiece: View {
    let index: Int
    @State private var yPosition: CGFloat = -50
    @State private var xPosition: CGFloat = 0
    @State private var rotation: Double = 0
    
    let colors: [Color] = [.red, .orange, .yellow, .green, .blue, .purple]
    
    var body: some View {
        Rectangle()
            .fill(colors[index % colors.count])
            .frame(width: 10, height: 10)
            .rotationEffect(.degrees(rotation))
            .position(x: xPosition, y: yPosition)
            .onAppear {
                xPosition = CGFloat.random(in: 50...350)
                
                withAnimation(
                    .easeIn(duration: Double.random(in: 2...4))
                    .repeatForever(autoreverses: false)
                ) {
                    yPosition = 900
                    rotation = Double.random(in: 0...720)
                }
            }
    }
}

#Preview {
    CompletionScreen(gameState: {
        let state = GameState()
        state.score = 80
        state.correctDecisions = 8
        state.mistakes = 2
        state.totalDecisions = 10
        return state
    }())
}
