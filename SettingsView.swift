import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var soundManager = SoundManager.shared
    @StateObject private var voiceManager = VoiceManager.shared
    @AppStorage("hapticsEnabled") private var hapticsEnabled = true
    
    var body: some View {
        NavigationStack {
            List {
                // Audio Settings
                Section("Audio") {
                    Toggle(isOn: $soundManager.isSoundEnabled) {
                        Label("Sound Effects", systemImage: "speaker.wave.2.fill")
                    }
                    .tint(.red)
                    
                    Toggle(isOn: $voiceManager.isVoiceEnabled) {
                        Label("Voice Guidance", systemImage: "speaker.wave.3.fill")
                    }
                    .tint(.red)
                }
                
                // Haptic Settings
                Section("Haptics") {
                    Toggle(isOn: $hapticsEnabled) {
                        Label("Haptic Feedback", systemImage: "hand.tap.fill")
                    }
                    .tint(.red)
                }
                
                // About Section
                Section("About Safe60") {
                    LabeledContent("Version", value: "1.0")
                    
                    LabeledContent("Purpose") {
                        Text("Fire emergency training")
                            .foregroundStyle(.secondary)
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Mission")
                            .font(.headline)
                        
                        Text("Safe60 trains factory workers to make correct decisions in the first 60 seconds of a fire emergency through visual, simulation-based training.")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.vertical, 4)
                }
                
                // Developer Info
                Section("Developer") {
                    LabeledContent("Created by", value: "Swift Student Challenge 2025")
                    
                    LabeledContent("Target") {
                        Text("Factory workers & safety training")
                            .foregroundStyle(.secondary)
                    }
                }
                
                // Impact Statement
                Section {
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Image(systemName: "heart.fill")
                                .foregroundStyle(.red)
                            Text("Impact Statement")
                                .font(.headline)
                        }
                        
                        Text("This app is designed to help workers in firecracker factories and chemical industries respond correctly during fire emergencies. Many workers have limited literacy, so we use visual training and voice guidance to make safety education accessible to everyone.")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.vertical, 4)
                }
                
                // Reset Data
                Section {
                    Button(role: .destructive) {
                        resetAllData()
                    } label: {
                        Label("Reset All Progress", systemImage: "trash.fill")
                    }
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    private func resetAllData() {
        UserDefaults.standard.removeObject(forKey: "unlockedBadges")
        UserDefaults.standard.removeObject(forKey: "performanceMetrics")
        UserDefaults.standard.removeObject(forKey: "hasCompletedOnboarding")
    }
}
