import AVFoundation
import SwiftUI

@MainActor
class VoiceManager: ObservableObject {
    static let shared = VoiceManager()
    
    @Published var isVoiceEnabled: Bool = true
    
    private let synthesizer = AVSpeechSynthesizer()
    
    private init() {}
    
    func speak(_ text: String, rate: Float = 0.5) {
        guard isVoiceEnabled else { return }
        
        // Stop any ongoing speech
        if synthesizer.isSpeaking {
            synthesizer.stopSpeaking(at: .immediate)
        }
        
        let utterance = AVSpeechUtterance(string: text)
        utterance.rate = rate
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.volume = 0.7
        
        synthesizer.speak(utterance)
    }
    
    func speakScenario(_ scenario: Scenario) {
        let text = "\(scenario.title). \(scenario.description)"
        speak(text)
    }
    
    func speakFireType(_ fireType: FireType) {
        speak(fireType.voiceExplanation)
    }
    
    func speakFeedback(correct: Bool) {
        if correct {
            speak("Correct! Well done.")
        } else {
            speak("Incorrect. Try again.")
        }
    }
    
    func stop() {
        if synthesizer.isSpeaking {
            synthesizer.stopSpeaking(at: .immediate)
        }
    }
    
    func toggleVoice() {
        isVoiceEnabled.toggle()
        if !isVoiceEnabled {
            stop()
        }
    }
}
