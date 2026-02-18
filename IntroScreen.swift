import SwiftUI

struct IntroScreen: View {
    @ObservedObject var gameState: GameState
    @State private var animateTitle = false
    
    var body: some View {
        VStack(spacing: 40) {
            Spacer()
            
            // App Icon - Emergency Theme
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [Color(red: 1.0, green: 0.3, blue: 0.2), Color(red: 1.0, green: 0.5, blue: 0.0)]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 140, height: 140)
                    .shadow(color: Color(red: 1.0, green: 0.3, blue: 0.2).opacity(0.4), radius: 20, x: 0, y: 10)
                
                Image(systemName: "exclamationmark.triangle.fill")
                    .font(.system(size: 70))
                    .foregroundColor(.white)
            }
            .scaleEffect(animateTitle ? 1.0 : 0.5)
            .animation(.spring(response: 0.6, dampingFraction: 0.6), value: animateTitle)
            
            // Title
            VStack(spacing: 12) {
                Text("Safe60")
                    .font(.system(size: 52, weight: .bold, design: .rounded))
                    .foregroundColor(.primary)
                
                Text("Emergency Hazard Recognition")
                    .font(.title3.weight(.medium))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                
                Text("Make correct safety decisions under pressure")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
            }
            .opacity(animateTitle ? 1 : 0)
            
            Spacer()
            
            // Start Button
            Button(action: {
                HapticManager.shared.lightImpact()
                withAnimation(.spring(response: 0.4)) {
                    gameState.currentScreen = .home
                }
            }) {
                HStack {
                    Text("Begin Training")
                        .font(.headline)
                    Image(systemName: "arrow.right.circle.fill")
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [Color(red: 1.0, green: 0.3, blue: 0.2), Color(red: 1.0, green: 0.5, blue: 0.0)]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .cornerRadius(16)
            }
            .padding(.horizontal, 40)
            .shadow(color: Color(red: 1.0, green: 0.3, blue: 0.2).opacity(0.3), radius: 10, x: 0, y: 5)
            
            Spacer()
                .frame(height: 60)
        }
        .padding()
        .onAppear {
            withAnimation(.easeOut(duration: 0.8)) {
                animateTitle = true
            }
        }
    }
}
