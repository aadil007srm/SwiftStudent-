import SwiftUI

struct EnvironmentSelectionScreen: View {
    @ObservedObject var gameState: GameState
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(EnvironmentType.allCases) { environment in
                    Button {
                        gameState.selectedEnvironment = environment
                        gameState.loadScenarios(for: environment)
                        withAnimation {
                            gameState.currentScreen = .training
                        }
                    } label: {
                        HStack(spacing: 16) {
                            Image(systemName: environment.icon)
                                .font(.title2)
                                .foregroundStyle(environment.color.gradient)
                                .frame(width: 50)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(environment.rawValue)
                                    .font(.headline)
                                    .foregroundStyle(.primary)
                                
                                Text(environment.description)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .font(.caption.weight(.semibold))
                                .foregroundStyle(.tertiary)
                        }
                        .padding(.vertical, 8)
                    }
                    .buttonStyle(.plain)
                }
            }
            .navigationTitle("Select Environment")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Back") {
                        gameState.currentScreen = .home
                    }
                }
            }
        }
    }
}
