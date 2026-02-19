import SwiftUI

struct HomeScreen: View {
    @ObservedObject var gameState: GameState
    @StateObject private var badgeManager = BadgeManager()
    @State private var showFireTypes = false
    @State private var showExtinguisherGuide = false
    @State private var showPowerSafety = false
    @State private var showProgress = false
    @State private var showSettings = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    // Hero Section
                    VStack(spacing: 20) {
                        FireAnimation()
                            .frame(height: 80)
                        
                        Text("Safe60")
                            .font(.largeTitle.bold())
                        
                        Text("The first 60 seconds decide everything")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    
                    // Main Training Button
                    PulsingButton(
                        title: "Start Training",
                        icon: "play.circle.fill",
                        color: .red
                    ) {
                        gameState.currentScreen = .environmentSelection
                    }
                    .padding(.horizontal)
                    
                    // Quick Access Cards
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Learn & Practice")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                            QuickAccessCard(
                                title: "Learn Fire Types",
                                icon: "flame.fill",
                                color: .red
                            ) {
                                showFireTypes = true
                            }
                            
                            QuickAccessCard(
                                title: "Extinguisher Guide",
                                icon: "extinguisher.fill",
                                color: .green
                            ) {
                                showExtinguisherGuide = true
                            }
                            
                            QuickAccessCard(
                                title: "Power Safety",
                                icon: "bolt.shield.fill",
                                color: .yellow
                            ) {
                                showPowerSafety = true
                            }
                            
                            QuickAccessCard(
                                title: "Your Progress",
                                icon: "chart.line.uptrend.xyaxis",
                                color: .blue
                            ) {
                                showProgress = true
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    // Stats Section
                    if gameState.totalDecisions > 0 {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Recent Stats")
                                .font(.headline)
                                .padding(.horizontal)
                            
                            VStack(spacing: 12) {
                                HStack {
                                    Label("Score", systemImage: "star.fill")
                                        .foregroundStyle(.yellow)
                                    Spacer()
                                    Text("\(gameState.score)")
                                        .font(.headline)
                                }
                                
                                HStack {
                                    Label("Accuracy", systemImage: "target")
                                        .foregroundStyle(.green)
                                    Spacer()
                                    Text("\(gameState.accuracyPercentage)%")
                                        .font(.headline)
                                }
                                
                                HStack {
                                    Label("Correct Decisions", systemImage: "checkmark.circle.fill")
                                        .foregroundStyle(.blue)
                                    Spacer()
                                    Text("\(gameState.correctDecisions)")
                                        .font(.headline)
                                }
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                            .padding(.horizontal)
                        }
                    }
                    
                    // Badges Section
                    if badgeManager.unlockedCount > 0 {
                        VStack(alignment: .leading, spacing: 16) {
                            HStack {
                                Text("Badges")
                                    .font(.headline)
                                Spacer()
                                Text("\(badgeManager.unlockedCount)/\(badgeManager.badges.count)")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                            .padding(.horizontal)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 12) {
                                    ForEach(badgeManager.badges.filter { $0.isUnlocked }) { badge in
                                        VStack(spacing: 8) {
                                            ZStack {
                                                Circle()
                                                    .fill(badge.colorValue.gradient)
                                                    .frame(width: 50, height: 50)
                                                
                                                Image(systemName: badge.icon)
                                                    .foregroundStyle(.white)
                                            }
                                            
                                            Text(badge.name)
                                                .font(.caption2)
                                                .lineLimit(2)
                                                .multilineTextAlignment(.center)
                                                .frame(width: 60)
                                        }
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                    
                    // Settings Button
                    Button {
                        showSettings = true
                    } label: {
                        Label("Settings", systemImage: "gearshape.fill")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .padding()
                }
                .padding(.vertical)
            }
            .navigationTitle("Safe60")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showFireTypes) {
                FireTypesView()
            }
            .sheet(isPresented: $showExtinguisherGuide) {
                ExtinguisherGuideView()
            }
            .sheet(isPresented: $showPowerSafety) {
                PowerSafetyView()
            }
            .sheet(isPresented: $showProgress) {
                ProgressView()
            }
            .sheet(isPresented: $showSettings) {
                SettingsView()
            }
        }
    }
}
