import SwiftUI

struct HomeScreen: View {
    @ObservedObject var gameState: GameState
    @StateObject private var badgeManager = BadgeManager()
    
    var body: some View {
        NavigationStack {
            List {
                // Hero Section
                Section {
                    VStack(spacing: 20) {
                        Image(systemName: "flame.circle.fill")
                            .font(.system(size: 60))
                            .foregroundStyle(.red.gradient)
                        
                        Text("Emergency Response Training")
                            .font(.title2.bold())
                            .multilineTextAlignment(.center)
                        
                        Text("Learn to recognize hazards and respond under time pressure")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .listRowBackground(Color.clear)
                }
                
                // Training Section
                Section("Training") {
                    Button {
                        gameState.currentScreen = .environmentSelection
                    } label: {
                        HStack {
                            Label("Start Training", systemImage: "play.circle.fill")
                                .font(.headline)
                            Spacer()
                        }
                    }
                    .tint(.red)
                }
                
                // Quick Access Features
                Section("Learn") {
                    NavigationLink {
                        FireTypesView(gameState: gameState)  // ✅ Added gameState parameter
                    } label: {
                        Label("Fire Types Guide", systemImage: "flame.fill")
                    }
                    
                    NavigationLink {
                        ExtinguisherGuideView(gameState: gameState)  // ✅ Added gameState parameter
                    } label: {
                        Label("Extinguisher Guide", systemImage: "fireworks")
                    }
                    
                    NavigationLink {
                        PowerSafetyView(gameState: gameState)
                    } label: {
                        Label("Power Safety", systemImage: "bolt.fill")
                    }
                }
                
                // Stats Section
                if gameState.totalDecisions > 0 {
                    Section("Your Progress") {
                        NavigationLink {
                            TrainingProgressView(gameState: gameState)
                        } label: {
                            VStack(spacing: 12) {
                                HStack(spacing: 20) {
                                    StatBadge(
                                        icon: "target",
                                        value: "\(gameState.score)",
                                        label: "Score",
                                        color: .blue
                                    )
                                    
                                    StatBadge(
                                        icon: "percent",
                                        value: "\(gameState.accuracyPercentage)%",
                                        label: "Accuracy",
                                        color: .green
                                    )
                                }
                                
                                HStack(spacing: 20) {
                                    StatBadge(
                                        icon: "checkmark.circle",
                                        value: "\(gameState.correctDecisions)",
                                        label: "Correct",
                                        color: .green
                                    )
                                    
                                    StatBadge(
                                        icon: "xmark.circle",
                                        value: "\(gameState.mistakes)",
                                        label: "Mistakes",
                                        color: .red
                                    )
                                }
                            }
                        }
                    }
                    
                    // Badges Section
                    Section("Achievements") {
                        NavigationLink {
                            BadgesCollectionView(gameState: gameState)
                        } label: {
                            HStack {
                                Image(systemName: "trophy.fill")
                                    .foregroundStyle(.yellow.gradient)
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Badges")
                                        .font(.headline)
                                    
                                    // ✅ Fixed: Use .count on the Set
                                    Text("\(badgeManager.earnedBadges.count) earned")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                                
                                Spacer()
                                
                                // Show first 3 earned badges
                                HStack(spacing: 4) {
                                    ForEach(Array(BadgeManager.allBadges.filter { badgeManager.earnedBadges.contains($0.name) }.prefix(3))) { badge in
                                        Image(systemName: badge.icon)
                                            .font(.caption)
                                            .foregroundStyle(badge.color)
                                    }
                                }
                            }
                        }
                    }
                }
                
                // About Section
                Section {
                    LabeledContent("Version", value: "1.0")
                    LabeledContent("Developer", value: "Swift Student Challenge 2025")
                    LabeledContent("Purpose", value: "Fire Safety Training")
                } header: {
                    Text("About")
                }
            }
            .navigationTitle("Safe60")
            .onAppear {
                badgeManager.checkAndAwardBadges(gameState: gameState)
            }
        }
    }
}

// Stat Badge Component
struct StatBadge: View {
    let icon: String
    let value: String
    let label: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
                .foregroundStyle(color.gradient)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(value)
                    .font(.headline)
                
                Text(label)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(.secondarySystemBackground))
        )
    }
}

#Preview {
    HomeScreen(gameState: GameState())
}
