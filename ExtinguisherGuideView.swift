import SwiftUI

struct ExtinguisherGuideView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var soundManager = SoundManager.shared
    @StateObject private var badgeManager = BadgeManager()
    @State private var score = 0
    @State private var attempts = 0
    @State private var showFeedback = false
    @State private var feedbackMessage = ""
    @State private var isCorrect = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    VStack(spacing: 24) {
                        // Header
                        VStack(spacing: 12) {
                            Image(systemName: "flame.fill")
                                .font(.system(size: 60))
                                .foregroundStyle(.red.gradient)
                            
                            Text("Extinguisher Guide")
                                .font(.title.bold())
                            
                            Text("Drag the correct extinguisher to each fire type")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                                .multilineTextAlignment(.center)
                        }
                        .padding()
                        
                        // Score
                        HStack {
                            Label("Score: \(score)", systemImage: "star.fill")
                                .font(.headline)
                                .foregroundStyle(.yellow)
                            
                            Spacer()
                            
                            Label("Attempts: \(attempts)", systemImage: "arrow.counterclockwise")
                                .font(.headline)
                                .foregroundStyle(.blue)
                        }
                        .padding(.horizontal)
                        
                        // Fire Types (Drop Targets)
                        VStack(spacing: 16) {
                            Text("Fire Types")
                                .font(.headline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            ForEach(FireType.allCases) { fireType in
                                FireTypeDropTarget(fireType: fireType) { extinguisher in
                                    handleDrop(extinguisher: extinguisher, on: fireType)
                                }
                            }
                        }
                        .padding(.horizontal)
                        
                        // Extinguishers (Drag Sources)
                        VStack(spacing: 16) {
                            Text("Extinguishers")
                                .font(.headline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 12) {
                                ForEach(ExtinguisherType.allCases) { extinguisher in
                                    ExtinguisherDragView(extinguisher: extinguisher)
                                }
                            }
                        }
                        .padding(.horizontal)
                        
                        // Instructions
                        VStack(alignment: .leading, spacing: 8) {
                            Text("💡 Quick Guide:")
                                .font(.headline)
                            
                            Text("• Water 💧 → Class A (Wood, Paper)")
                            Text("• Foam 🧯 → Class A & B (Liquids)")
                            Text("• CO2 🧯 → Class B & C (Electrical)")
                            Text("• Dry Powder 🧂 → Class D (Metal)")
                        }
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        .padding(.horizontal)
                    }
                    .padding(.vertical)
                }
                
                // Feedback overlay
                if showFeedback {
                    FeedbackOverlay(message: feedbackMessage, isCorrect: isCorrect)
                        .transition(.scale.combined(with: .opacity))
                }
            }
            .navigationTitle("Extinguisher Guide")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Done") {
                        if score >= 4 {
                            badgeManager.unlockBadge(id: "extinguisher_pro")
                        }
                        dismiss()
                    }
                }
            }
        }
    }
    
    private func handleDrop(extinguisher: ExtinguisherType, on fireType: FireType) {
        attempts += 1
        
        let compatible = ExtinguisherGuide.isCompatible(extinguisher: extinguisher, fireType: fireType)
        
        if compatible {
            score += 10
            isCorrect = true
            feedbackMessage = "✅ Correct! \(extinguisher.rawValue) works on \(fireType.name)"
            soundManager.playSuccess()
            HapticManager.shared.success()
        } else {
            isCorrect = false
            feedbackMessage = "❌ Wrong! \(extinguisher.rawValue) is not safe for \(fireType.name)"
            soundManager.playError()
            HapticManager.shared.error()
        }
        
        withAnimation {
            showFeedback = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation {
                showFeedback = false
            }
        }
    }
}

struct FireTypeDropTarget: View {
    let fireType: FireType
    let onDrop: (ExtinguisherType) -> Void
    
    @State private var isTargeted = false
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Text(fireType.icon)
                    .font(.system(size: 30))
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(fireType.name)
                        .font(.headline)
                    
                    Text(fireType.materials)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                
                Spacer()
            }
            .padding()
            .background(isTargeted ? fireType.color.opacity(0.3) : Color(.systemGray6))
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isTargeted ? fireType.color : Color.clear, lineWidth: 2)
            )
        }
        .onDrop(of: [.text], isTargeted: $isTargeted) { providers in
            providers.first?.loadItem(forTypeIdentifier: "public.text", options: nil) { data, error in
                if let data = data as? Data,
                   let text = String(data: data, encoding: .utf8),
                   let extinguisher = ExtinguisherType(rawValue: text) {
                    DispatchQueue.main.async {
                        onDrop(extinguisher)
                    }
                }
            }
            return true
        }
    }
}

struct ExtinguisherDragView: View {
    let extinguisher: ExtinguisherType
    
    var body: some View {
        VStack(spacing: 8) {
            Text(extinguisher.icon)
                .font(.system(size: 40))
            
            Text(extinguisher.rawValue)
                .font(.caption.bold())
                .multilineTextAlignment(.center)
        }
        .frame(width: 100, height: 100)
        .background(extinguisher.color.opacity(0.2))
        .cornerRadius(12)
        .onDrag {
            NSItemProvider(object: extinguisher.rawValue as NSString)
        }
    }
}

struct FeedbackOverlay: View {
    let message: String
    let isCorrect: Bool
    
    var body: some View {
        VStack {
            Spacer()
            
            Text(message)
                .font(.headline)
                .foregroundStyle(.white)
                .padding()
                .background(isCorrect ? Color.green : Color.red)
                .cornerRadius(12)
                .padding()
            
            Spacer()
                .frame(height: 200)
        }
    }
}
