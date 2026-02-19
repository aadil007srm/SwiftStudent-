import SwiftUI

struct IntroScreen: View {
    @ObservedObject var gameState: GameState
    @State private var isAnimated = false
    @State private var countdown = 60
    @State private var pulseScale: CGFloat = 1.0
    @State private var autoTransitionTimer: Timer?
    @State private var countdownTimer: Timer?
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                colors: [.red.opacity(0.3), .orange.opacity(0.2)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            // Particle effects
            ParticleSystem(type: .fire)
                .frame(height: 300)
                .offset(y: 200)
                .opacity(0.6)
            
            VStack(spacing: 40) {
                Spacer()
                
                // Large animated "60" countdown
                ZStack {
                    // Pulsing circle background
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [.red, .orange],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 180, height: 180)
                        .scaleEffect(pulseScale)
                        .shadow(color: .red.opacity(0.5), radius: 20)
                    
                    // Countdown number
                    Text("\(countdown)")
                        .font(.system(size: 80, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)
                }
                .scaleEffect(isAnimated ? 1.0 : 0.8)
                .opacity(isAnimated ? 1.0 : 0.0)
                
                // Tagline
                VStack(spacing: 8) {
                    Text("The First 60 Seconds")
                        .font(.title.bold())
                        .foregroundStyle(.primary)
                    
                    Text("Decide Everything")
                        .font(.title2)
                        .foregroundStyle(.secondary)
                }
                .opacity(isAnimated ? 1.0 : 0.0)
                
                // App name
                Text("Safe60")
                    .font(.system(size: 48, weight: .bold, design: .rounded))
                    .foregroundStyle(.primary)
                    .opacity(isAnimated ? 1.0 : 0.0)
                
                Text("Fire Emergency Training for Factory Workers")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                    .opacity(isAnimated ? 1.0 : 0.0)
                
                Spacer()
            }
        }
        .onAppear {
            startAnimations()
            startAutoTransition()
        }
        .onDisappear {
            autoTransitionTimer?.invalidate()
            autoTransitionTimer = nil
            countdownTimer?.invalidate()
            countdownTimer = nil
        }
    }
    
    private func startAnimations() {
        withAnimation(.spring(duration: 0.8)) {
            isAnimated = true
        }
        
        // Pulsing animation
        withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
            pulseScale = 1.15
        }
        
        // Countdown animation
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
            if countdown > 0 {
                countdown -= 1
            } else {
                countdown = 60
            }
        }
    }
    
    private func startAutoTransition() {
        autoTransitionTimer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { _ in
            withAnimation(.spring()) {
                // Check if user has completed onboarding
                let hasCompletedOnboarding = UserDefaults.standard.bool(forKey: "hasCompletedOnboarding")
                if hasCompletedOnboarding {
                    gameState.currentScreen = .home
                } else {
                    gameState.currentScreen = .onboarding
                }
            }
        }
    }
}
