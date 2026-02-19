import SwiftUI

struct HomeScreen: View {
    @ObservedObject var gameState: GameState
    @StateObject private var badgeManager = BadgeManager()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    // Hero Card
                    HeroCard()
                    
                    // Action Cards Grid
                    VStack(spacing: 16) {
                        Text("Quick Actions")
                            .font(.title3.bold())
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                        
                        LazyVGrid(columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ], spacing: 16) {
                            // Start Training Card
                            ActionCard(
                                icon: "flame.fill",
                                title: "Start Training",
                                subtitle: "Practice scenarios",
                                gradient: [.safe60Red, .safe60Orange],
                                action: {
                                    gameState.currentScreen = .environmentSelection
                                }
                            )
                            
                            // Learn Basics Card
                            NavigationLink {
                                SafetyFundamentalsView(gameState: gameState)
                            } label: {
                                ActionCardLabel(
                                    icon: "book.fill",
                                    title: "Learn Basics",
                                    subtitle: "Fire safety guide",
                                    gradient: [.safe60Info, .blue]
                                )
                            }
                            
                            // Your Badges Card
                            NavigationLink {
                                BadgesCollectionView(gameState: gameState)
                            } label: {
                                ActionCardLabel(
                                    icon: "trophy.fill",
                                    title: "Your Badges",
                                    subtitle: "\(badgeManager.earnedBadges.count) earned",
                                    gradient: [.yellow, .orange]
                                )
                            }
                            
                            // Track Progress Card
                            if gameState.totalDecisions > 0 {
                                NavigationLink {
                                    TrainingProgressView(gameState: gameState)
                                } label: {
                                    ActionCardLabel(
                                        icon: "chart.bar.fill",
                                        title: "Track Progress",
                                        subtitle: "\(gameState.accuracyPercentage)% accuracy",
                                        gradient: [.safe60Success, .green]
                                    )
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    // Floating Stats (if user has progress)
                    if gameState.totalDecisions > 0 {
                        FloatingStatsCard(gameState: gameState)
                            .padding(.horizontal)
                    }
                    
                    // About Section
                    VStack(alignment: .leading, spacing: 8) {
                        Text("About Safe60")
                            .font(.caption.bold())
                            .foregroundStyle(.secondary)
                        
                        Text("Emergency response training app designed for factory workers and safety-conscious professionals.")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        
                        Text("Version 1.0 • Swift Student Challenge 2025")
                            .font(.caption2)
                            .foregroundStyle(.tertiary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(.secondarySystemBackground))
                    )
                    .padding(.horizontal)
                    .padding(.bottom, 24)
                }
                .padding(.top)
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Safe60")
            .navigationBarTitleDisplayMode(.large)
            .onAppear {
                badgeManager.checkAndAwardBadges(gameState: gameState)
            }
        }
    }
}

// MARK: - Hero Card Component
struct HeroCard: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "flame.circle.fill")
                .font(.system(size: 70))
                .foregroundStyle(
                    LinearGradient(
                        colors: [.safe60Red, .safe60Orange],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
            
            VStack(spacing: 8) {
                Text("Emergency Response Training")
                    .font(.title2.bold())
                    .multilineTextAlignment(.center)
                
                Text("Master fire safety in 60 seconds per scenario")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 32)
        .padding(.horizontal, 24)
        .background(
            LinearGradient(
                colors: [Color.safe60Red.opacity(0.1), Color.safe60Orange.opacity(0.05)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(
                    LinearGradient(
                        colors: [Color.safe60Red.opacity(0.3), Color.safe60Orange.opacity(0.3)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 2
                )
        )
        .padding(.horizontal)
        .shadow(color: Color.safe60Red.opacity(0.2), radius: 10, x: 0, y: 5)
    }
}

// MARK: - Action Card Component
struct ActionCard: View {
    let icon: String
    let title: String
    let subtitle: String
    let gradient: [Color]
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 12) {
                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: gradient,
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 56, height: 56)
                    
                    Image(systemName: icon)
                        .font(.title2)
                        .foregroundStyle(.white)
                }
                
                VStack(spacing: 4) {
                    Text(title)
                        .font(.headline)
                        .foregroundStyle(.primary)
                    
                    Text(subtitle)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(16)
            .shadow(color: Color.cardShadow, radius: 8, x: 0, y: 4)
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Action Card Label (for NavigationLink)
struct ActionCardLabel: View {
    let icon: String
    let title: String
    let subtitle: String
    let gradient: [Color]
    
    var body: some View {
        VStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: gradient,
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 56, height: 56)
                
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundStyle(.white)
            }
            
            VStack(spacing: 4) {
                Text(title)
                    .font(.headline)
                    .foregroundStyle(.primary)
                
                Text(subtitle)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(16)
        .shadow(color: Color.cardShadow, radius: 8, x: 0, y: 4)
    }
}

// MARK: - Safety Fundamentals Hub View
struct SafetyFundamentalsView: View {
    @ObservedObject var gameState: GameState
    
    var body: some View {
        List {
            Section("Safety Fundamentals") {
                NavigationLink {
                    FireTypesView(gameState: gameState)
                } label: {
                    Label("Fire Types Guide", systemImage: "flame.fill")
                }
                
                NavigationLink {
                    ExtinguisherGuideView(gameState: gameState)
                } label: {
                    Label("Extinguisher Guide", systemImage: "fireworks")
                }
                
                NavigationLink {
                    PowerSafetyView(gameState: gameState)
                } label: {
                    Label("Power Safety", systemImage: "bolt.fill")
                }
            }
        }
        .navigationTitle("Learn Basics")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Floating Stats Card
struct FloatingStatsCard: View {
    @ObservedObject var gameState: GameState
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Your Stats")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(spacing: 16) {
                MiniStatCard(
                    icon: "target",
                    value: "\(gameState.score)",
                    label: "Score",
                    color: .safe60Info
                )
                
                MiniStatCard(
                    icon: "percent",
                    value: "\(gameState.accuracyPercentage)%",
                    label: "Accuracy",
                    color: .safe60Success
                )
                
                MiniStatCard(
                    icon: "checkmark.circle.fill",
                    value: "\(gameState.correctDecisions)",
                    label: "Correct",
                    color: .safe60Success
                )
            }
        }
        .padding()
        .background(
            LinearGradient(
                colors: [Color.blue.opacity(0.1), Color.purple.opacity(0.1)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.blue.opacity(0.2), lineWidth: 1)
        )
    }
}

// MARK: - Mini Stat Card
struct MiniStatCard: View {
    let icon: String
    let value: String
    let label: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundStyle(color)
            
            Text(value)
                .font(.title3.bold())
            
            Text(label)
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(Color(.systemBackground))
        .cornerRadius(12)
    }
}

#Preview {
    HomeScreen(gameState: GameState())
}
