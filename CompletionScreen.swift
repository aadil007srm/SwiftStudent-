import SwiftUI

struct CompletionScreen: View {
    @ObservedObject var gameState: GameState
    @StateObject private var badgeManager = BadgeManager()
    @StateObject private var performanceTracker = PerformanceTracker()
    @State private var showTrophy = false
    @State private var trophyScale: CGFloat = 0.5
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    // Animated Trophy
                    if showTrophy {
                        ZStack {
                            Circle()
                                .fill(resultColor().opacity(0.2))
                                .frame(width: 150, height: 150)
                            
                            Image(systemName: resultIcon())
                                .font(.system(size: 80))
                                .foregroundStyle(resultColor().gradient)
                        }
                        .scaleEffect(trophyScale)
                        .padding(.top, 20)
                    }
                    
                    // Title and message
                    VStack(spacing: 12) {
                        Text("Training Complete!")
                            .font(.title.bold())
                        
                        Text(performanceMessage())
                            .font(.body)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    
                    // Performance Grade
                    HStack(spacing: 20) {
                        VStack(spacing: 8) {
                            Text("Grade")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            
                            Text(grade())
                                .font(.system(size: 60, weight: .bold))
                                .foregroundStyle(gradeColor())
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(gradeColor().opacity(0.1))
                        .cornerRadius(16)
                        
                        VStack(spacing: 8) {
                            Text("Score")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            
                            Text("\(gameState.score)")
                                .font(.system(size: 40, weight: .bold))
                                .foregroundStyle(.yellow)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(16)
                    }
                    .padding(.horizontal)
                    
                    // Detailed Results
                    VStack(spacing: 12) {
                        Text("Performance Details")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        VStack(spacing: 12) {
                            ResultRow(
                                icon: "target",
                                label: "Accuracy",
                                value: "\(gameState.accuracyPercentage)%",
                                color: .green
                            )
                            
                            ResultRow(
                                icon: "checkmark.circle.fill",
                                label: "Correct Decisions",
                                value: "\(gameState.correctDecisions)",
                                color: .blue
                            )
                            
                            ResultRow(
                                icon: "xmark.circle.fill",
                                label: "Mistakes",
                                value: "\(gameState.mistakes)",
                                color: .red
                            )
                            
                            ResultRow(
                                icon: "list.bullet",
                                label: "Total Decisions",
                                value: "\(gameState.totalDecisions)",
                                color: .orange
                            )
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                    }
                    .padding(.horizontal)
                    
                    // Insights
                    if gameState.accuracyPercentage == 100 {
                        InsightCard(
                            icon: "star.fill",
                            text: "Perfect score! You made all the right decisions.",
                            color: .yellow
                        )
                    } else if gameState.accuracyPercentage >= 80 {
                        InsightCard(
                            icon: "chart.line.uptrend.xyaxis",
                            text: "Great work! You're becoming an expert responder.",
                            color: .green
                        )
                    } else {
                        InsightCard(
                            icon: "lightbulb.fill",
                            text: "Keep practicing! Review fire types and extinguisher guides.",
                            color: .blue
                        )
                    }
                    
                    // Newly unlocked badges
                    if !newlyUnlockedBadges.isEmpty {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("New Badges Unlocked! 🎉")
                                .font(.headline)
                            
                            ForEach(newlyUnlockedBadges) { badge in
                                HStack(spacing: 12) {
                                    ZStack {
                                        Circle()
                                            .fill(badge.colorValue.gradient)
                                            .frame(width: 50, height: 50)
                                        
                                        Image(systemName: badge.icon)
                                            .foregroundStyle(.white)
                                    }
                                    
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(badge.name)
                                            .font(.headline)
                                        
                                        Text(badge.description)
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                    }
                                    
                                    Spacer()
                                }
                                .padding()
                                .background(badge.colorValue.opacity(0.1))
                                .cornerRadius(12)
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    // Action Buttons
                    VStack(spacing: 12) {
                        CustomButton(
                            title: "Train Again",
                            icon: "arrow.clockwise",
                            color: .red
                        ) {
                            savePerformance()
                            withAnimation {
                                gameState.reset()
                            }
                        }
                        
                        CustomButton(
                            title: "Back to Home",
                            icon: "house.fill",
                            color: .blue
                        ) {
                            savePerformance()
                            gameState.currentScreen = .home
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                }
            }
            .navigationTitle("Results")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            checkBadges()
            animateTrophy()
        }
    }
    
    private func animateTrophy() {
        showTrophy = true
        withAnimation(.spring(response: 0.6, dampingFraction: 0.5)) {
            trophyScale = 1.0
        }
    }
    
    private func checkBadges() {
        badgeManager.checkAndUnlockBadges(gameState: gameState)
    }
    
    private func savePerformance() {
        performanceTracker.recordSession(
            score: gameState.score,
            accuracy: gameState.accuracyPercentage,
            responseTime: Double(60 - gameState.timerManager.timeRemaining),
            environment: gameState.selectedEnvironment.rawValue
        )
    }
    
    private var newlyUnlockedBadges: [Badge] {
        // Return recently unlocked badges (simplified - in real app would check timestamps)
        badgeManager.badges.filter { $0.isUnlocked }
    }
    
    private func resultIcon() -> String {
        let accuracy = gameState.accuracyPercentage
        if accuracy >= 90 { return "trophy.fill" }
        if accuracy >= 70 { return "star.fill" }
        return "hand.thumbsup.fill"
    }
    
    private func resultColor() -> Color {
        let accuracy = gameState.accuracyPercentage
        if accuracy >= 90 { return .yellow }
        if accuracy >= 70 { return .green }
        return .blue
    }
    
    private func performanceMessage() -> String {
        let accuracy = gameState.accuracyPercentage
        if accuracy >= 90 { return "Excellent work! You're an expert emergency responder." }
        if accuracy >= 70 { return "Good job! You have solid emergency response skills." }
        if accuracy >= 50 { return "Keep practicing to improve your decision-making." }
        return "Review the training materials and try again."
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

struct ResultRow: View {
    let icon: String
    let label: String
    let value: String
    let color: Color
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundStyle(color)
                .frame(width: 24)
            
            Text(label)
                .foregroundStyle(.secondary)
            
            Spacer()
            
            Text(value)
                .font(.headline)
                .foregroundStyle(.primary)
        }
    }
}

struct InsightCard: View {
    let icon: String
    let text: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(color)
            
            Text(text)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            
            Spacer()
        }
        .padding()
        .background(color.opacity(0.1))
        .cornerRadius(12)
        .padding(.horizontal)
    }
}
