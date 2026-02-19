import SwiftUI

struct CompletionScreen: View {
    @ObservedObject var gameState: GameState
    @StateObject private var badgeManager = BadgeManager()
    @State private var showConfetti = false
    @State private var showGrade = false
    @State private var showStats = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                
                // Main Content
                ScrollView {
                    VStack(spacing: 32) {
                        // Top Spacer
                        Spacer()
                            .frame(height: 20)
                        
                        // Large Animated Grade
                        VStack(spacing: 20) {
                            ZStack {
                                // Outer Ring
                                Circle()
                                    .stroke(
                                        LinearGradient(
                                            colors: [gradeColor(), gradeColor().opacity(0.5)],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        ),
                                        lineWidth: 8
                                    )
                                    .frame(width: 140, height: 140)
                                
                                // Inner Circle
                                Circle()
                                    .fill(
                                        LinearGradient(
                                            colors: [gradeColor().opacity(0.2), gradeColor().opacity(0.1)],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .frame(width: 120, height: 120)
                                
                                // Grade Letter
                                Text(grade())
                                    .font(.system(size: 64, weight: .bold, design: .rounded))
                                    .foregroundStyle(gradeColor())
                            }
                            .scaleEffect(showGrade ? 1.0 : 0.3)
                            .rotationEffect(.degrees(showGrade ? 0 : 180))
                            .opacity(showGrade ? 1 : 0)
                            
                            // Trophy/Star Icon
                            Image(systemName: resultIcon())
                                .font(.system(size: 50))
                                .foregroundStyle(resultColor())
                                .opacity(showGrade ? 1 : 0)
                                .scaleEffect(showGrade ? 1.0 : 0.5)
                            
                            // Performance Message
                            VStack(spacing: 8) {
                                Text(performanceTitle())
                                    .font(.title2.bold())
                                
                                Text(performanceMessage())
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal)
                            }
                            .opacity(showGrade ? 1 : 0)
                        }
                        
                        // Stats in Circular Progress Rings
                        if showStats {
                            VStack(spacing: 20) {
                                Text("Performance Stats")
                                    .font(.headline)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.horizontal)
                                
                                HStack(spacing: 16) {
                                    CircularStatCard(
                                        value: gameState.accuracyPercentage,
                                        total: 100,
                                        label: "Accuracy",
                                        color: .safe60Success
                                    )
                                    
                                    CircularStatCard(
                                        value: gameState.correctDecisions,
                                        total: gameState.totalDecisions,
                                        label: "Correct",
                                        color: .safe60Info
                                    )
                                    
                                    CircularStatCard(
                                        value: gameState.score,
                                        total: gameState.totalDecisions * 10,
                                        label: "Score",
                                        color: .safe60Warning
                                    )
                                }
                                .padding(.horizontal)
                            }
                            .transition(.opacity.combined(with: .scale))
                        }
                        
                        // Newly Earned Badges
                        let newBadges = getNewlyEarnedBadges()
                        if !newBadges.isEmpty {
                            VStack(spacing: 16) {
                                HStack {
                                    Image(systemName: "sparkles")
                                        .foregroundStyle(.yellow)
                                    Text("New Badges Unlocked!")
                                        .font(.headline)
                                    Image(systemName: "sparkles")
                                        .foregroundStyle(.yellow)
                                }
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 16) {
                                        ForEach(newBadges) { badge in
                                            BadgeUnlockCard(badge: badge)
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                            }
                            .padding(.vertical)
                            .background(
                                LinearGradient(
                                    colors: [Color.yellow.opacity(0.1), Color.orange.opacity(0.05)],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(16)
                            .padding(.horizontal)
                        }
                        
                        // Action Buttons
                        VStack(spacing: 12) {
                            // Train Again Button
                            Button {
                                withAnimation(.spring(response: 0.4)) {
                                    gameState.reset()
                                }
                            } label: {
                                HStack {
                                    Image(systemName: "arrow.clockwise.circle.fill")
                                        .font(.title3)
                                    Text("Train Again")
                                        .font(.headline)
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(
                                    LinearGradient(
                                        colors: [.safe60Red, .safe60Orange],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .foregroundStyle(.white)
                                .cornerRadius(12)
                                .shadow(color: Color.safe60Red.opacity(0.3), radius: 8, x: 0, y: 4)
                            }
                            
                            // Go Home Button
                            Button {
                                withAnimation {
                                    gameState.currentScreen = .home
                                }
                            } label: {
                                HStack {
                                    Image(systemName: "house.fill")
                                        .font(.title3)
                                    Text("Back to Home")
                                        .font(.headline)
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(.secondarySystemBackground))
                                .foregroundStyle(.primary)
                                .cornerRadius(12)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 24)
                    }
                }
                
                // Confetti Effect for A grade
                if showConfetti && gameState.accuracyPercentage >= 90 {
                    ConfettiView()
                        .allowsHitTesting(false)
                }
            }
            .navigationTitle("Training Complete")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                badgeManager.checkAndAwardBadges(gameState: gameState)
                
                // Staggered animations
                withAnimation(.spring(response: 0.6, dampingFraction: 0.7).delay(0.2)) {
                    showGrade = true
                }
                
                withAnimation(.spring(response: 0.5).delay(0.8)) {
                    showStats = true
                }
                
                if gameState.accuracyPercentage >= 90 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        withAnimation {
                            showConfetti = true
                        }
                    }
                }
            }
        }
    }
    
    private func getNewlyEarnedBadges() -> [Badge] {
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
        if accuracy >= 70 { return .safe60Success }
        return .safe60Info
    }
    
    private func performanceTitle() -> String {
        let accuracy = gameState.accuracyPercentage
        if accuracy >= 90 { return "Excellent Work!" }
        if accuracy >= 70 { return "Good Job!" }
        return "Keep Practicing!"
    }
    
    private func performanceMessage() -> String {
        let accuracy = gameState.accuracyPercentage
        if accuracy >= 90 { return "You're an expert emergency responder!" }
        if accuracy >= 70 { return "You have solid safety skills." }
        return "Review the guides to improve your response."
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
        if accuracy >= 90 { return .safe60Success }
        if accuracy >= 70 { return .safe60Warning }
        return .safe60Danger
    }
}

// MARK: - Circular Stat Card
struct CircularStatCard: View {
    let value: Int
    let total: Int
    let label: String
    let color: Color
    
    var progress: Double {
        guard total > 0 else { return 0 }
        return Double(value) / Double(total)
    }
    
    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                // Background Circle
                Circle()
                    .stroke(color.opacity(0.2), lineWidth: 8)
                    .frame(width: 80, height: 80)
                
                // Progress Circle
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(
                        LinearGradient(
                            colors: [color, color.opacity(0.7)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        style: StrokeStyle(lineWidth: 8, lineCap: .round)
                    )
                    .frame(width: 80, height: 80)
                    .rotationEffect(.degrees(-90))
                
                // Value Text
                Text("\(value)")
                    .font(.title3.bold())
                    .foregroundStyle(color)
            }
            
            Text(label)
                .font(.caption.bold())
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
    }
}

// MARK: - Badge Unlock Card
struct BadgeUnlockCard: View {
    let badge: Badge
    @State private var animate = false
    
    var body: some View {
        VStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [badge.color, badge.color.opacity(0.7)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 70, height: 70)
                    .shadow(color: badge.color.opacity(0.4), radius: 10, x: 0, y: 5)
                
                Image(systemName: badge.icon)
                    .font(.title2)
                    .foregroundStyle(.white)
            }
            .scaleEffect(animate ? 1.0 : 0.8)
            .rotationEffect(.degrees(animate ? 0 : -20))
            
            VStack(spacing: 4) {
                Text(badge.name)
                    .font(.caption.bold())
                    .multilineTextAlignment(.center)
                
                Text(badge.description)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
            }
            .frame(width: 100)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
        .onAppear {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.6).delay(0.3)) {
                animate = true
            }
        }
    }
}

// MARK: - Confetti Effect
struct ConfettiView: View {
    @State private var animate = false
    
    var body: some View {
        ZStack {
            ForEach(0..<50, id: \.self) { index in
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
    
    let colors: [Color] = [.red, .orange, .yellow, .green, .blue, .purple, .pink]
    let shapes = ["circle", "rectangle", "triangle"]
    
    var body: some View {
        Group {
            if index % 3 == 0 {
                Circle()
                    .fill(colors[index % colors.count])
                    .frame(width: 10, height: 10)
            } else if index % 3 == 1 {
                Rectangle()
                    .fill(colors[index % colors.count])
                    .frame(width: 10, height: 10)
            } else {
                RoundedRectangle(cornerRadius: 2)
                    .fill(colors[index % colors.count])
                    .frame(width: 12, height: 8)
            }
        }
        .rotationEffect(.degrees(rotation))
        .position(x: xPosition, y: yPosition)
        .onAppear {
            xPosition = CGFloat.random(in: 0...400)
            
            withAnimation(
                .easeIn(duration: Double.random(in: 2.5...4.5))
                .repeatForever(autoreverses: false)
            ) {
                yPosition = 1000
                rotation = Double.random(in: 0...1080)
            }
        }
    }
}

#Preview {
    CompletionScreen(gameState: {
        let state = GameState()
        state.score = 90
        state.correctDecisions = 9
        state.mistakes = 1
        state.totalDecisions = 10
        return state
    }())
}
