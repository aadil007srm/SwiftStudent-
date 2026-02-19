import SwiftUI
import AVFoundation

struct OnboardingView: View {
    @ObservedObject var gameState: GameState
    @State private var currentPage = 0
    @State private var speechSynthesizer = AVSpeechSynthesizer()
    
    let slides: [(icon: String, title: String, subtitle: String, speech: String)] = [
        (
            icon: "clock.fill",
            title: "60 Seconds = Life or Death",
            subtitle: "When fire starts, the first minute decides if you control it or it explodes",
            speech: "When fire starts, 60 seconds decide if you control it or it explodes"
        ),
        (
            icon: "xmark.octagon.fill",
            title: "Wrong Action = Disaster",
            subtitle: "Water on chemical fire? Using phone near gas? These mistakes are fatal",
            speech: "Water on chemical fire? Using phone near gas? Fatal mistakes"
        ),
        (
            icon: "checkmark.shield.fill",
            title: "Right Training = Safety",
            subtitle: "Safe60 trains your instincts to make the correct decision under pressure",
            speech: "Safe60 trains your instincts to save lives"
        )
    ]
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                colors: [.red.opacity(0.2), .orange.opacity(0.1)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Skip button
                HStack {
                    Spacer()
                    Button("Skip") {
                        speechSynthesizer.stopSpeaking(at: .immediate)
                        withAnimation {
                            gameState.currentScreen = .home
                        }
                    }
                    .padding()
                }
                
                // Slides
                TabView(selection: $currentPage) {
                    ForEach(0..<slides.count, id: \.self) { index in
                        SlideView(slide: slides[index])
                            .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
                .indexViewStyle(.page(backgroundDisplayMode: .always))
                
                // Continue/Get Started button
                Button {
                    speechSynthesizer.stopSpeaking(at: .immediate)
                    if currentPage < slides.count - 1 {
                        withAnimation {
                            currentPage += 1
                        }
                    } else {
                        withAnimation {
                            gameState.currentScreen = .home
                        }
                    }
                } label: {
                    Text(currentPage < slides.count - 1 ? "Continue" : "Get Started")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.red.gradient, in: RoundedRectangle(cornerRadius: 16))
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 40)
            }
        }
        .onChange(of: currentPage) { newValue in  // ✅ iOS 16 compatible version
            speakSlide(at: newValue)
        }
        .onAppear {
            speakSlide(at: 0)
        }
        .onDisappear {
            speechSynthesizer.stopSpeaking(at: .immediate)
        }
    }
    
    private func speakSlide(at index: Int) {
        guard index < slides.count else { return }
        speechSynthesizer.stopSpeaking(at: .immediate)
        
        let utterance = AVSpeechUtterance(string: slides[index].speech)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = 0.5
        speechSynthesizer.speak(utterance)
    }
}

struct SlideView: View {
    let slide: (icon: String, title: String, subtitle: String, speech: String)
    @State private var isAnimated = false
    
    var body: some View {
        VStack(spacing: 40) {
            Spacer()
            
            // Icon
            ZStack {
                Circle()
                    .fill(.red.opacity(0.2))
                    .frame(width: 180, height: 180)
                
                Image(systemName: slide.icon)
                    .font(.system(size: 80))
                    .foregroundStyle(.red.gradient)
            }
            .scaleEffect(isAnimated ? 1.0 : 0.8)
            .opacity(isAnimated ? 1.0 : 0.0)
            
            // Text content
            VStack(spacing: 16) {
                Text(slide.title)
                    .font(.title.bold())
                    .multilineTextAlignment(.center)
                
                Text(slide.subtitle)
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
            }
            .opacity(isAnimated ? 1.0 : 0.0)
            
            Spacer()
        }
        .onAppear {
            withAnimation(.spring(duration: 0.6)) {
                isAnimated = true
            }
        }
    }
}

#Preview {
    OnboardingView(gameState: GameState())
}
