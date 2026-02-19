import SwiftUI

struct FireTypesView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var voiceManager = VoiceManager.shared
    @StateObject private var badgeManager = BadgeManager()
    @State private var expandedType: FireType?
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Header
                    VStack(spacing: 12) {
                        FireAnimation()
                            .frame(height: 80)
                        
                        Text("Learn Fire Types")
                            .font(.title.bold())
                        
                        Text("Understand different fires and how to extinguish them")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                    
                    // Fire Types List
                    ForEach(FireType.allCases) { fireType in
                        FireTypeCard(
                            fireType: fireType,
                            isExpanded: expandedType == fireType
                        ) {
                            withAnimation(.spring()) {
                                if expandedType == fireType {
                                    expandedType = nil
                                    voiceManager.stop()
                                } else {
                                    expandedType = fireType
                                    voiceManager.speakFireType(fireType)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
            .navigationTitle("Fire Types")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Done") {
                        voiceManager.stop()
                        badgeManager.unlockBadge(id: "fire_master")
                        dismiss()
                    }
                }
            }
        }
        .onDisappear {
            voiceManager.stop()
        }
    }
}

struct FireTypeCard: View {
    let fireType: FireType
    let isExpanded: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 16) {
                // Header
                HStack(spacing: 16) {
                    // Icon
                    Text(fireType.icon)
                        .font(.system(size: 50))
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(fireType.name)
                            .font(.headline)
                            .foregroundStyle(.primary)
                        
                        Text(fireType.materials)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    
                    Spacer()
                    
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundStyle(.secondary)
                }
                
                // Expanded content
                if isExpanded {
                    VStack(alignment: .leading, spacing: 12) {
                        Divider()
                        
                        // What to use
                        VStack(alignment: .leading, spacing: 6) {
                            Text("✅ What to Use")
                                .font(.subheadline.bold())
                                .foregroundStyle(.green)
                            
                            Text(fireType.correctExtinguisher)
                                .font(.body)
                                .foregroundStyle(.primary)
                        }
                        
                        // What NOT to use
                        VStack(alignment: .leading, spacing: 6) {
                            Text(fireType.wrongExtinguisher)
                                .font(.subheadline.bold())
                                .foregroundStyle(.red)
                            
                            if fireType == .classB || fireType == .classC || fireType == .classD {
                                Text("Using water can cause serious injury or explosion!")
                                    .font(.caption)
                                    .foregroundStyle(.red)
                                    .padding(8)
                                    .background(.red.opacity(0.1))
                                    .cornerRadius(8)
                            }
                        }
                        
                        // Voice button
                        HStack {
                            Spacer()
                            Image(systemName: "speaker.wave.2.fill")
                                .foregroundStyle(fireType.color)
                            Text("Tap to hear explanation")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            Spacer()
                        }
                        .padding(.top, 8)
                    }
                    .transition(.opacity.combined(with: .move(edge: .top)))
                }
            }
            .padding()
            .background(fireType.color.opacity(0.1))
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(fireType.color.opacity(0.3), lineWidth: 2)
            )
        }
        .buttonStyle(.plain)
    }
}
