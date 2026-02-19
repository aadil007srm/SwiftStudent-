import SwiftUI

struct IntroScreen: View {
    @ObservedObject var gameState: GameState
    @State private var isAnimated = false
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                colors: [.red.opacity(0.3), .orange.opacity(0.2)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 40) {
                Spacer()
                
                // App Icon
                ZStack {
                    Circle()
                        .fill(.red.gradient)
                        .frame(width: 140, height: 140)
                        .shadow(color: .red.opacity(0.4), radius: 20)
                    
                    Image(systemName: "exclamationmark.triangle.fill")
                        .font(.system(size: 70))
                        .foregroundStyle(.white)
                }
                .scaleEffect(isAnimated ? 1.0 : 0.8)
                .opacity(isAnimated ? 1.0 : 0.0)
                
                // Title
                VStack(spacing: 12) {
                    Text("Safe60")
                        .font(.system(size: 54, weight: .bold, design: .rounded))
                        .foregroundStyle(.primary)
                    
                    Text("Emergency Response Training")
                        .font(.title3)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                    
                    Text("60-second emergency scenarios")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .opacity(isAnimated ? 1.0 : 0.0)
                
                Spacer()
                
                // Start Button - iOS 16 style
                Button {
                    withAnimation(.spring()) {
                        gameState.currentScreen = .home
                    }
                } label: {
                    Text("Start Training")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.red.gradient, in: RoundedRectangle(cornerRadius: 16))
                }
                .buttonStyle(.plain)
                .padding(.horizontal, 40)
                .shadow(color: .red.opacity(0.3), radius: 10)
                .scaleEffect(isAnimated ? 1.0 : 0.9)
                
                Spacer()
                    .frame(height: 60)
            }
        }
        .onAppear {
            withAnimation(.spring(duration: 0.8)) {
                isAnimated = true
            }
        }
    }
}
