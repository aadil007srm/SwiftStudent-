import SwiftUI

struct HomeScreen: View {
    @ObservedObject var gameState: GameState
    
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
                        Label("Start Training", systemImage: "play.circle.fill")
                            .font(.headline)
                    }
                    .tint(.red)
                }
                
                // Stats Section
                if gameState.totalDecisions > 0 {
                    Section("Your Progress") {
                        LabeledContent("Score", value: "\(gameState.score)")
                        LabeledContent("Accuracy", value: "\(gameState.accuracyPercentage)%")
                        LabeledContent("Mistakes", value: "\(gameState.mistakes)")
                    }
                }
                
                // About Section
                Section {
                    LabeledContent("Version", value: "1.0")
                    LabeledContent("Developer", value: "Swift Student Challenge 2025")
                } header: {
                    Text("About")
                }
            }
            .navigationTitle("Safe60")
        }
    }
}
