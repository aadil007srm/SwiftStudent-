import AVFoundation

@MainActor
class SoundManager: NSObject, ObservableObject {
    static let shared = SoundManager()
    
    @Published var isSoundEnabled: Bool = true
    
    private var audioPlayers: [String: AVAudioPlayer] = [:]
    private var backgroundPlayer: AVAudioPlayer?
    
    private override init() {
        super.init()
        setupAudioSession()
    }
    
    private func setupAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.ambient, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to set up audio session: \(error)")
        }
    }
    
    // Play sound effect
    func playSound(_ soundName: String, volume: Float = 1.0) {
        guard isSoundEnabled else { return }
        
        // For now, we'll use system sounds simulation
        // In a real app, you would load actual sound files
        print("Playing sound: \(soundName)")
    }
    
    func playAlarm() {
        playSound("alarm", volume: 0.7)
    }
    
    func playFireCrackle() {
        playSound("fire_crackle", volume: 0.5)
    }
    
    func playExplosion() {
        playSound("explosion", volume: 0.8)
    }
    
    func playSuccess() {
        playSound("success", volume: 0.6)
    }
    
    func playError() {
        playSound("error", volume: 0.6)
    }
    
    func playTick() {
        playSound("tick", volume: 0.3)
    }
    
    func stopAllSounds() {
        audioPlayers.values.forEach { $0.stop() }
        backgroundPlayer?.stop()
    }
    
    func toggleSound() {
        isSoundEnabled.toggle()
        if !isSoundEnabled {
            stopAllSounds()
        }
    }
}
