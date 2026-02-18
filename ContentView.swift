import SwiftUI

struct ContentView: View {
    @StateObject private var gameState = GameState()
    
    var body: some View {
        ZStack {
            // Clean white background
            Color(UIColor.systemBackground)
                .ignoresSafeArea()
            
            // Navigation Logic
            switch gameState.currentScreen {
            case .intro:
                IntroScreen(gameState: gameState)
            case .home:
                HomeScreen(gameState: gameState)
            case .environmentSelection:
                EnvironmentSelectionScreen(gameState: gameState)
            case .learning:
                LearningCardScreen(gameState: gameState)
            case .recognize:
                RecognizeScreen(gameState: gameState)
            case .response:
                ResponseScreen(gameState: gameState)
            case .mistake:
                MistakeScreen(gameState: gameState)
            case .storage:
                StorageScreen(gameState: gameState)
            case .completion:
                CompletionScreen(gameState: gameState)
            }
        }
    }
}
