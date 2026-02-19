import SwiftUI
import Charts

struct TrainingProgressView: View {
    @ObservedObject var gameState: GameState
    @StateObject private var badgeManager = BadgeManager()
    
    var body: some View {
        NavigationStack {
            List {
                // Summary Section
                Section {
                    VStack(spacing: 20) {
                        Image(systemName: "chart.line.uptrend.xyaxis")
                            .font(.system(size: 60))
                            .foregroundStyle(.blue.gradient)
                        
                        Text("Your Progress")
                            .font(.title.bold())
                        
                        Text("Track your emergency response training")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                }
                .listRowBackground(Color.clear)
                
                // Stats Overview
                Section("Overview") {
                    HStack {
                        StatCard(
                            icon: "target",
                            value: "\(gameState.score)",
                            label: "Total Score",
                            color: .blue
                        )
                        
                        StatCard(
                            icon: "percent",
                            value: "\(gameState.accuracyPercentage)%",
                            label: "Accuracy",
                            color: .green
                        )
                    }
                    
                    HStack {
                        StatCard(
                            icon: "checkmark.circle",
                            value: "\(gameState.correctDecisions)",
                            label: "Correct",
                            color: .green
                        )
                        
                        StatCard(
                            icon: "xmark.circle",
                            value: "\(gameState.mistakes)",
                            label: "Mistakes",
                            color: .red
                        )
                    }
                }
                
                // Performance Chart
                if gameState.totalDecisions > 0 {
                    Section("Performance") {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Accuracy: \(gameState.accuracyPercentage)%")
                                .font(.headline)
                            
                            // Simple progress bar (iOS 16 compatible)
                            GeometryReader { geometry in
                                ZStack(alignment: .leading) {
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color.gray.opacity(0.2))
                                        .frame(height: 20)
                                    
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(accuracyColor().gradient)
                                        .frame(
                                            width: geometry.size.width * CGFloat(gameState.accuracyPercentage) / 100,
                                            height: 20
                                        )
                                }
                            }
                            .frame(height: 20)
                            
                            HStack {
                                Label("\(gameState.correctDecisions) Correct", systemImage: "checkmark.circle.fill")
                                    .font(.caption)
                                    .foregroundStyle(.green)
                                
                                Spacer()
                                
                                Label("\(gameState.mistakes) Mistakes", systemImage: "xmark.circle.fill")
                                    .font(.caption)
                                    .foregroundStyle(.red)
                            }
                        }
                        .padding(.vertical, 8)
                    }
                }
                
                // Badges Section
                Section("Badges Earned") {
                    if badgeManager.earnedBadges.isEmpty {
                        HStack {
                            Image(systemName: "star.slash")
                                .foregroundStyle(.secondary)
                            Text("No badges earned yet. Keep training!")
                                .foregroundStyle(.secondary)
                        }
                        .padding(.vertical, 8)
                    } else {
                        LazyVGrid(columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ], spacing: 16) {
                            ForEach(BadgeManager.allBadges.filter { badgeManager.earnedBadges.contains($0.name) }) { badge in
                                VStack(spacing: 8) {
                                    ZStack {
                                        Circle()
                                            .fill(badge.color.gradient)
                                            .frame(width: 60, height: 60)
                                        
                                        Image(systemName: badge.icon)
                                            .font(.title2)
                                            .foregroundStyle(.white)
                                    }
                                    
                                    Text(badge.name)
                                        .font(.caption2)
                                        .multilineTextAlignment(.center)
                                        .lineLimit(2)
                                }
                            }
                        }
                        .padding(.vertical, 8)
                    }
                    
                    NavigationLink {
                        BadgesCollectionView(gameState: gameState)
                    } label: {
                        Label("View All Badges", systemImage: "trophy.fill")
                    }
                }
                
                // Scenarios Completed
                Section("Training History") {
                    LabeledContent("Total Scenarios", value: "\(gameState.totalDecisions)")
                    LabeledContent("Current Environment", value: gameState.selectedEnvironment.rawValue)
                    
                    if gameState.scenarios.count > 0 {
                        LabeledContent("Progress", value: "\(gameState.currentScenarioIndex + 1)/\(gameState.scenarios.count)")
                    }
                }
            }
            .navigationTitle("Progress")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Back") {
                        gameState.currentScreen = .home
                    }
                }
            }
            .onAppear {
                badgeManager.checkAndAwardBadges(gameState: gameState)
            }
        }
    }
    
    private func accuracyColor() -> Color {
        let accuracy = gameState.accuracyPercentage
        if accuracy >= 90 { return .green }
        if accuracy >= 70 { return .orange }
        return .red
    }
}

// Stat Card Component
struct StatCard: View {
    let icon: String
    let value: String
    let label: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(color.gradient)
            
            Text(value)
                .font(.title.bold())
            
            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.secondarySystemBackground))
        )
    }
}

#Preview {
    TrainingProgressView(gameState: GameState())
}
