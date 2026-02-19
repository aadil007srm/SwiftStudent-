import SwiftUI

struct EnvironmentSelectionScreen: View {
    @ObservedObject var gameState: GameState
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    // Header
                    VStack(spacing: 12) {
                        Image(systemName: "building.2.fill")
                            .font(.system(size: 70))
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [.safe60Info, .blue],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                        
                        Text("Select Environment")
                            .font(.title.bold())
                        
                        Text("Choose where to practice emergency response")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.top, 20)
                    .padding(.horizontal)
                    
                    // Large Environment Cards
                    VStack(spacing: 20) {
                        ForEach(EnvironmentType.allCases) { environment in
                            LargeEnvironmentCard(
                                environment: environment,
                                scenarioCount: ScenarioData.scenarios(for: environment).count
                            ) {
                                gameState.selectedEnvironment = environment
                                gameState.loadScenarios(for: environment)
                                withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                                    gameState.currentScreen = .training
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 24)
                }
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Choose Environment")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        withAnimation {
                            gameState.currentScreen = .home
                        }
                    } label: {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Home")
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Large Environment Card
struct LargeEnvironmentCard: View {
    let environment: EnvironmentType
    let scenarioCount: Int
    let action: () -> Void
    @State private var isPressed = false
    
    var body: some View {
        Button(action: {
            withAnimation(.spring(response: 0.3)) {
                isPressed = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.spring(response: 0.3)) {
                    isPressed = false
                }
                action()
            }
        }) {
            VStack(spacing: 0) {
                // Top Section - Icon and Title
                VStack(spacing: 20) {
                    // Large Icon with Gradient Background
                    ZStack {
                        Circle()
                            .fill(
                                LinearGradient(
                                    colors: [environment.color, environment.color.opacity(0.7)],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 100, height: 100)
                            .shadow(color: environment.color.opacity(0.3), radius: 15, x: 0, y: 8)
                        
                        Image(systemName: environment.icon)
                            .font(.system(size: 48))
                            .foregroundStyle(.white)
                    }
                    
                    // Environment Name
                    VStack(spacing: 8) {
                        Text(environment.rawValue)
                            .font(.title2.bold())
                            .foregroundStyle(.primary)
                        
                        Text(environment.description)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 32)
                .padding(.horizontal, 24)
                .padding(.bottom, 24)
                .background(
                    LinearGradient(
                        colors: [
                            environment.color.opacity(0.15),
                            environment.color.opacity(0.05)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                
                Divider()
                
                // Bottom Section - Info and CTA
                HStack {
                    // Scenario Count
                    HStack(spacing: 8) {
                        Image(systemName: "list.bullet.circle.fill")
                            .foregroundStyle(environment.color)
                        
                        Text("\(scenarioCount) scenarios")
                            .font(.subheadline.bold())
                            .foregroundStyle(.primary)
                    }
                    
                    Spacer()
                    
                    // Difficulty Indicator
                    HStack(spacing: 4) {
                        ForEach(0..<difficultyLevel(for: environment), id: \.self) { _ in
                            Image(systemName: "flame.fill")
                                .font(.caption)
                                .foregroundStyle(environment.color)
                        }
                        ForEach(0..<(3 - difficultyLevel(for: environment)), id: \.self) { _ in
                            Image(systemName: "flame")
                                .font(.caption)
                                .foregroundStyle(environment.color.opacity(0.3))
                        }
                    }
                    
                    // Arrow
                    Image(systemName: "arrow.right.circle.fill")
                        .font(.title2)
                        .foregroundStyle(environment.color)
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 16)
                .background(Color(.secondarySystemBackground))
            }
            .background(Color(.systemBackground))
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(environment.color.opacity(0.3), lineWidth: 2)
            )
            .shadow(color: environment.color.opacity(isPressed ? 0.1 : 0.2), radius: isPressed ? 8 : 15, x: 0, y: isPressed ? 4 : 10)
            .scaleEffect(isPressed ? 0.98 : 1.0)
        }
        .buttonStyle(.plain)
    }
    
    private func difficultyLevel(for environment: EnvironmentType) -> Int {
        switch environment {
        case .kitchen: return 1
        case .office: return 1
        case .lab: return 2
        case .factory: return 3
        }
    }
}

#Preview {
    EnvironmentSelectionScreen(gameState: GameState())
}
