import SwiftUI

struct EnvironmentSelectionScreen: View {
    @ObservedObject var gameState: GameState
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Header
                    VStack(spacing: 12) {
                        Image(systemName: "building.2.fill")
                            .font(.system(size: 60))
                            .foregroundStyle(.blue.gradient)
                        
                        Text("Select Environment")
                            .font(.title.bold())
                        
                        Text("Choose where to practice emergency response")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                    
                    // Environment Cards
                    ForEach(EnvironmentType.allCases) { environment in
                        EnvironmentCard(
                            environment: environment,
                            scenarioCount: ScenarioData.scenarios(for: environment).count
                        ) {
                            gameState.selectedEnvironment = environment
                            gameState.loadScenarios(for: environment)
                            withAnimation {
                                gameState.currentScreen = .training
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
            .navigationTitle("Choose Environment")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct EnvironmentCard: View {
    let environment: EnvironmentType
    let scenarioCount: Int
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 0) {
                // Header with icon
                HStack(spacing: 16) {
                    ZStack {
                        Circle()
                            .fill(environment.color.gradient)
                            .frame(width: 60, height: 60)
                        
                        Image(systemName: environment.icon)
                            .font(.title2)
                            .foregroundStyle(.white)
                    }
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text(environment.rawValue)
                            .font(.title3.bold())
                            .foregroundStyle(.primary)
                        
                        Text(environment.description)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .font(.title3.weight(.semibold))
                        .foregroundStyle(.tertiary)
                }
                .padding()
                
                Divider()
                
                // Scenario count and difficulty
                HStack(spacing: 24) {
                    Label("\(scenarioCount) scenarios", systemImage: "list.bullet")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    
                    Spacer()
                    
                    HStack(spacing: 4) {
                        ForEach(0..<difficultyLevel(for: environment), id: \.self) { _ in
                            Image(systemName: "flame.fill")
                                .font(.caption2)
                        }
                        ForEach(0..<(3 - difficultyLevel(for: environment)), id: \.self) { _ in
                            Image(systemName: "flame")
                                .font(.caption2)
                        }
                    }
                    .foregroundStyle(environment.color)
                }
                .padding(.horizontal)
                .padding(.vertical, 12)
                .background(environment.color.opacity(0.05))
            }
            .background(Color(.systemGray6))
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(environment.color.opacity(0.2), lineWidth: 1)
            )
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
