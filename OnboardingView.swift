import SwiftUI

struct OnboardingView: View {
    @ObservedObject var gameState: GameState
    @State private var currentPage = 0
    @StateObject private var voiceManager = VoiceManager.shared
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                colors: [.red.opacity(0.2), .orange.opacity(0.15)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack {
                // Skip button
                HStack {
                    Spacer()
                    Button("Skip") {
                        completeOnboarding()
                    }
                    .foregroundStyle(.secondary)
                    .padding()
                }
                
                // Content
                TabView(selection: $currentPage) {
                    OnboardingPage(
                        icon: "exclamationmark.triangle.fill",
                        title: "60 Seconds = Life or Death",
                        description: "In a fire emergency, the first 60 seconds are critical. Your decisions during this time can save lives.",
                        color: .red
                    )
                    .tag(0)
                    
                    OnboardingPage(
                        icon: "flame.fill",
                        title: "Wrong Action = Disaster",
                        description: "Using the wrong extinguisher or making the wrong choice can make a fire worse. Learn the right responses.",
                        color: .orange
                    )
                    .tag(1)
                    
                    OnboardingPage(
                        icon: "checkmark.shield.fill",
                        title: "Right Training = Safety",
                        description: "Practice visual, scenario-based training. No heavy reading required. Just learn and respond.",
                        color: .green
                    )
                    .tag(2)
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
                .indexViewStyle(.page(backgroundDisplayMode: .always))
                .onChange(of: currentPage) { oldValue, newValue in
                    speakCurrentPage()
                }
                
                // Continue button
                if currentPage == 2 {
                    PulsingButton(
                        title: "Get Started",
                        icon: "play.fill",
                        color: .red
                    ) {
                        completeOnboarding()
                    }
                    .padding(.horizontal, 40)
                    .padding(.bottom, 40)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
        }
        .onAppear {
            speakCurrentPage()
        }
    }
    
    private func speakCurrentPage() {
        let texts = [
            "60 Seconds equals Life or Death. In a fire emergency, the first 60 seconds are critical.",
            "Wrong Action equals Disaster. Using the wrong extinguisher can make a fire worse.",
            "Right Training equals Safety. Practice visual scenario-based training."
        ]
        
        if currentPage < texts.count {
            voiceManager.speak(texts[currentPage])
        }
    }
    
    private func completeOnboarding() {
        voiceManager.stop()
        UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding")
        withAnimation {
            gameState.currentScreen = .home
        }
    }
}

struct OnboardingPage: View {
    let icon: String
    let title: String
    let description: String
    let color: Color
    
    @State private var isAnimated = false
    
    var body: some View {
        VStack(spacing: 40) {
            Spacer()
            
            // Icon
            ZStack {
                Circle()
                    .fill(color.gradient)
                    .frame(width: 160, height: 160)
                    .shadow(color: color.opacity(0.4), radius: 20)
                
                Image(systemName: icon)
                    .font(.system(size: 80))
                    .foregroundStyle(.white)
            }
            .scaleEffect(isAnimated ? 1.0 : 0.8)
            .rotationEffect(.degrees(isAnimated ? 0 : -10))
            
            // Text
            VStack(spacing: 16) {
                Text(title)
                    .font(.title.bold())
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.primary)
                
                Text(description)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.secondary)
                    .padding(.horizontal, 40)
            }
            .opacity(isAnimated ? 1.0 : 0.0)
            .offset(y: isAnimated ? 0 : 20)
            
            Spacer()
        }
        .onAppear {
            withAnimation(.spring(duration: 0.8)) {
                isAnimated = true
            }
        }
    }
}
