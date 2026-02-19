import SwiftUI

struct ContentView: View {
    @StateObject private var gameState = GameState()
    
    var body: some View {
        Group {
            switch gameState.currentScreen {
            case .intro:
                IntroScreen(gameState: gameState)
            case .home:
                HomeScreen(gameState: gameState)
            case .environmentSelection:
                EnvironmentSelectionScreen(gameState: gameState)
            case .training:
                TrainingScreen(gameState: gameState)
            case .completion:
                CompletionScreen(gameState: gameState)
            }
        }
    }
}

#Preview {
    ContentView()
}
