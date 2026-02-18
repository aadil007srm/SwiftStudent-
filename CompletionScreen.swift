import SwiftUI

struct CompletionScreen: View {
    @ObservedObject var gameState: GameState
    
    let emergencyRed = Color(red: 1.0, green: 0.3, blue: 0.2)
    let emergencyOrange = Color(red: 1.0, green: 0.5, blue: 0.0)
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Header with Performance Icon
                    VStack(spacing: 16) {
                        ZStack {
                            Circle()
                                .fill(performanceColor().opacity(0.15))
                                .frame(width: 120, height: 120)
                            
                            Image(systemName: performanceIcon())
                                .font(.system(size: 60))
                                .foregroundColor(performanceColor())
                        }
                        
                        Text("Training Complete!")
                            .font(.title.bold())
                            .foregroundColor(.primary)
                        
                        Text(performanceMessage())
                            .font(.headline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    .padding(.top, 20)
                    
                    // Performance Grade
                    VStack(spacing: 12) {
                        Text("PERFORMANCE GRADE")
                            .font(.caption.weight(.bold))
                            .foregroundColor(.secondary)
                        
                        HStack {
                            ForEach(0..<5) { index in
                                Image(systemName: index < riskRating() ? "star.fill" : "star")
                                    .font(.title2)
                                    .foregroundColor(index < riskRating() ? .orange : Color(UIColor.systemGray4))
                            }
                        }
                        
                        Text(riskRatingText())
                            .font(.subheadline.weight(.medium))
                            .foregroundColor(.primary)
                    }
                    .padding()
                    .background(Color(UIColor.secondarySystemGroupedBackground))
                    .cornerRadius(16)
                    .padding(.horizontal)
                    
                    // Key Metrics
                    VStack(spacing: 12) {
                        Text("KEY METRICS")
                            .font(.caption.weight(.bold))
                            .foregroundColor(.secondary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                            MetricCard(
                                icon: "star.fill",
                                title: "Final Score",
                                value: "\(gameState.score)",
                                color: .orange
                            )
                            
                            MetricCard(
                                icon: "percent",
                                title: "Accuracy",
                                value: "\(Int(gameState.accuracyPercentage))%",
                                color: .green
                            )
                            
                            MetricCard(
                                icon: "xmark.circle.fill",
                                title: "Mistakes",
                                value: "\(gameState.mistakes)",
                                color: emergencyRed
                            )
                            
                            MetricCard(
                                icon: "clock.fill",
                                title: "Avg. Time",
                                value: String(format: "%.1fs", averageReactionTime()),
                                color: .blue
                            )
                            
                            MetricCard(
                                icon: "bolt.fill",
                                title: "Fastest",
                                value: String(format: "%.1fs", fastestTime()),
                                color: emergencyOrange
                            )
                            
                            MetricCard(
                                icon: "checkmark.circle.fill",
                                title: "Completed",
                                value: "\(gameState.completedScenarios.count)",
                                color: .green
                            )
                        }
                    }
                    .padding()
                    .background(Color(UIColor.secondarySystemGroupedBackground))
                    .cornerRadius(16)
                    .padding(.horizontal)
                    
                    // Critical Skills Assessment
                    VStack(spacing: 12) {
                        Text("CRITICAL SKILLS")
                            .font(.caption.weight(.bold))
                            .foregroundColor(.secondary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        VStack(spacing: 10) {
                            SkillBar(label: "Urgency Recognition", value: urgencyScore(), color: emergencyRed)
                            SkillBar(label: "Risk Assessment", value: riskScore(), color: emergencyOrange)
                            SkillBar(label: "Response Control", value: controlScore(), color: .blue)
                            SkillBar(label: "Decision Stability", value: stabilityScore(), color: .green)
                        }
                    }
                    .padding()
                    .background(Color(UIColor.secondarySystemGroupedBackground))
                    .cornerRadius(16)
                    .padding(.horizontal)
                    
                    // Achievements
                    if !gameState.achievements.isEmpty {
                        VStack(spacing: 12) {
                            Text("🏆 ACHIEVEMENTS UNLOCKED")
                                .font(.caption.weight(.bold))
                                .foregroundColor(.secondary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            ForEach(gameState.achievements) { achievement in
                                HStack(spacing: 12) {
                                    ZStack {
                                        Circle()
                                            .fill(Color.yellow.opacity(0.2))
                                            .frame(width: 44, height: 44)
                                        
                                        Image(systemName: achievement.icon)
                                            .foregroundColor(.orange)
                                            .font(.title3)
                                    }
                                    
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text(achievement.title)
                                            .font(.headline)
                                            .foregroundColor(.primary)
                                        Text(achievement.description)
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                                    
                                    Spacer()
                                }
                                .padding()
                                .background(Color.yellow.opacity(0.1))
                                .cornerRadius(12)
                            }
                        }
                        .padding()
                        .background(Color(UIColor.secondarySystemGroupedBackground))
                        .cornerRadius(16)
                        .padding(.horizontal)
                    }
                    
                    // Improvement Areas
                    if !improvementSuggestions().isEmpty {
                        VStack(spacing: 12) {
                            Text("💡 AREAS FOR IMPROVEMENT")
                                .font(.caption.weight(.bold))
                                .foregroundColor(.secondary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            ForEach(improvementSuggestions(), id: \.self) { suggestion in
                                HStack(alignment: .top, spacing: 10) {
                                    Image(systemName: "arrow.up.right.circle.fill")
                                        .foregroundColor(.blue)
                                    Text(suggestion)
                                        .font(.body)
                                        .foregroundColor(.primary)
                                    Spacer()
                                }
                                .padding()
                                .background(Color.blue.opacity(0.1))
                                .cornerRadius(12)
                            }
                        }
                        .padding()
                        .background(Color(UIColor.secondarySystemGroupedBackground))
                        .cornerRadius(16)
                        .padding(.horizontal)
                    }
                    
                    // Action Buttons
                    VStack(spacing: 12) {
                        Button(action: {
                            HapticManager.shared.mediumImpact()
                            withAnimation {
                                gameState.reset()
                            }
                        }) {
                            HStack {
                                Image(systemName: "arrow.clockwise.circle.fill")
                                Text("Retrain")
                            }
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [emergencyRed, emergencyOrange]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(16)
                        }
                        
                        Button(action: {
                            HapticManager.shared.lightImpact()
                            withAnimation {
                                gameState.currentScreen = .home
                            }
                        }) {
                            HStack {
                                Image(systemName: "house.circle.fill")
                                Text("Back to Home")
                            }
                            .font(.headline)
                            .foregroundColor(.blue)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(16)
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom, 30)
            }
            .navigationTitle("Results")
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationViewStyle(.stack)
        .onAppear {
            gameState.timerManager.reset()
        }
    }
    
    // Helper Functions
    func averageReactionTime() -> Double {
        guard !gameState.reactionTimes.isEmpty else { return 0 }
        return gameState.reactionTimes.reduce(0, +) / Double(gameState.reactionTimes.count)
    }
    
    func fastestTime() -> Double {
        guard !gameState.reactionTimes.isEmpty else { return 0 }
        return gameState.reactionTimes.min() ?? 0
    }
    
    func riskRating() -> Int {
        let accuracy = gameState.accuracyPercentage
        if accuracy >= 90 { return 5 }
        if accuracy >= 80 { return 4 }
        if accuracy >= 70 { return 3 }
        if accuracy >= 60 { return 2 }
        return 1
    }
    
    func riskRatingText() -> String {
        switch riskRating() {
        case 5: return "Expert Emergency Responder"
        case 4: return "Advanced Safety Skills"
        case 3: return "Proficient Response Ability"
        case 2: return "Developing Skills"
        default: return "Needs More Practice"
        }
    }
    
    func performanceIcon() -> String {
        let rating = riskRating()
        if rating >= 4 { return "trophy.fill" }
        if rating >= 3 { return "medal.fill" }
        return "flag.checkered"
    }
    
    func performanceColor() -> Color {
        let rating = riskRating()
        if rating >= 4 { return .orange }
        if rating >= 3 { return .green }
        return .blue
    }
    
    func performanceMessage() -> String {
        let rating = riskRating()
        if rating >= 4 { return "Excellent emergency response skills!" }
        if rating >= 3 { return "Good understanding of safety protocols!" }
        return "Keep training to improve your skills!"
    }
    
    func urgencyScore() -> Double {
        return min(gameState.accuracyPercentage / 100.0, 1.0)
    }
    
    func riskScore() -> Double {
        return 1.0 - gameState.riskLevel
    }
    
    func controlScore() -> Double {
        let avgTime = averageReactionTime()
        return max(0, min(1.0, 1.0 - (avgTime / 30.0)))
    }
    
    func stabilityScore() -> Double {
        guard gameState.totalDecisions > 0 else { return 0 }
        return Double(gameState.correctDecisions) / Double(gameState.totalDecisions)
    }
    
    func improvementSuggestions() -> [String] {
        var suggestions: [String] = []
        
        if gameState.accuracyPercentage < 80 {
            suggestions.append("Review hazard identification patterns")
        }
        
        if averageReactionTime() > 10.0 {
            suggestions.append("Practice faster emergency decision-making")
        }
        
        if gameState.mistakes > 3 {
            suggestions.append("Study safety protocols more thoroughly")
        }
        
        if gameState.riskLevel > 0.5 {
            suggestions.append("Focus on risk assessment strategies")
        }
        
        return suggestions
    }
}

struct MetricCard: View {
    let icon: String
    let title: String
    let value: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
            
            Text(value)
                .font(.title3.bold())
                .foregroundColor(.primary)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(color.opacity(0.1))
        .cornerRadius(12)
    }
}

struct SkillBar: View {
    let label: String
    let value: Double
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(label)
                    .font(.subheadline.weight(.medium))
                    .foregroundColor(.primary)
                Spacer()
                Text("\(Int(value * 100))%")
                    .font(.subheadline.weight(.semibold))
                    .foregroundColor(color)
            }
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color(UIColor.systemGray5))
                        .frame(height: 8)
                        .cornerRadius(4)
                    
                    Rectangle()
                        .fill(color)
                        .frame(width: geometry.size.width * value, height: 8)
                        .cornerRadius(4)
                }
            }
            .frame(height: 8)
        }
    }
}
