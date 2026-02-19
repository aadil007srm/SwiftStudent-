import SwiftUI

struct PowerSafetyView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var voiceManager = VoiceManager.shared
    @State private var selectedStep: Int?
    
    let safetySteps = [
        PowerSafetyStep(
            id: 0,
            title: "Identify the Hazard",
            icon: "exclamationmark.triangle.fill",
            color: .red,
            description: "Is there smoke, sparks, or fire from electrical equipment?",
            action: "Look for warning signs: burning smell, sparks, smoke, or unusual sounds."
        ),
        PowerSafetyStep(
            id: 1,
            title: "Don't Touch Water",
            icon: "drop.fill",
            color: .blue,
            description: "NEVER use water on electrical fires!",
            action: "Water conducts electricity and can cause electrocution or make the fire spread."
        ),
        PowerSafetyStep(
            id: 2,
            title: "Cut the Power",
            icon: "bolt.slash.fill",
            color: .yellow,
            description: "Turn off power at the circuit breaker if safe to do so.",
            action: "Locate the electrical panel. Switch off the affected circuit. Do not touch if there's water nearby."
        ),
        PowerSafetyStep(
            id: 3,
            title: "Use CO2 Extinguisher",
            icon: "extinguisher.fill",
            color: .green,
            description: "After cutting power, use a CO2 or dry chemical extinguisher.",
            action: "Aim at the base of the fire. Never use water-based extinguishers on electrical fires."
        ),
        PowerSafetyStep(
            id: 4,
            title: "Evacuate if Needed",
            icon: "figure.run",
            color: .orange,
            description: "If fire spreads or you can't cut power safely, evacuate immediately.",
            action: "Alert others. Use emergency exits. Call fire department. Don't return until cleared."
        )
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    // Header
                    VStack(spacing: 12) {
                        Image(systemName: "bolt.shield.fill")
                            .font(.system(size: 60))
                            .foregroundStyle(.yellow.gradient)
                        
                        Text("Electrical Safety")
                            .font(.title.bold())
                        
                        Text("Learn how to respond to electrical fires safely")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                    
                    // Flowchart
                    VStack(spacing: 20) {
                        ForEach(Array(safetySteps.enumerated()), id: \.element.id) { index, step in
                            VStack(spacing: 0) {
                                PowerSafetyStepCard(
                                    step: step,
                                    stepNumber: index + 1,
                                    isExpanded: selectedStep == step.id
                                ) {
                                    withAnimation(.spring()) {
                                        if selectedStep == step.id {
                                            selectedStep = nil
                                            voiceManager.stop()
                                        } else {
                                            selectedStep = step.id
                                            voiceManager.speak(step.description + " " + step.action)
                                        }
                                    }
                                }
                                
                                // Arrow to next step
                                if index < safetySteps.count - 1 {
                                    Image(systemName: "arrow.down")
                                        .font(.title2)
                                        .foregroundStyle(.secondary)
                                        .padding(.vertical, 8)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    // Warning Box
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .foregroundStyle(.red)
                            Text("Critical Safety Rules")
                                .font(.headline)
                                .foregroundStyle(.red)
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("❌ NEVER use water on electrical fires")
                            Text("❌ NEVER touch electrical equipment with wet hands")
                            Text("❌ NEVER attempt to fight a large electrical fire yourself")
                            Text("✅ ALWAYS call emergency services for major fires")
                            Text("✅ ALWAYS evacuate if unsure")
                        }
                        .font(.subheadline)
                    }
                    .padding()
                    .background(.red.opacity(0.1))
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(.red.opacity(0.3), lineWidth: 2)
                    )
                    .padding(.horizontal)
                    
                    // Safe Distance Info
                    VStack(alignment: .leading, spacing: 12) {
                        Text("📏 Safe Distances")
                            .font(.headline)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("• Electrical panel: Keep 3 feet clear")
                            Text("• Downed power lines: Stay 10+ meters away")
                            Text("• Electrical fire: Use extinguisher from 6-8 feet")
                        }
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
            .navigationTitle("Power Safety")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Done") {
                        voiceManager.stop()
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

struct PowerSafetyStep: Identifiable {
    let id: Int
    let title: String
    let icon: String
    let color: Color
    let description: String
    let action: String
}

struct PowerSafetyStepCard: View {
    let step: PowerSafetyStep
    let stepNumber: Int
    let isExpanded: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 12) {
                HStack(spacing: 16) {
                    // Step number
                    ZStack {
                        Circle()
                            .fill(step.color.gradient)
                            .frame(width: 50, height: 50)
                        
                        Text("\(stepNumber)")
                            .font(.title2.bold())
                            .foregroundStyle(.white)
                    }
                    
                    // Icon and title
                    HStack(spacing: 12) {
                        Image(systemName: step.icon)
                            .font(.title2)
                            .foregroundStyle(step.color)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(step.title)
                                .font(.headline)
                                .foregroundStyle(.primary)
                            
                            if !isExpanded {
                                Text(step.description)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                    .lineLimit(1)
                            }
                        }
                    }
                    
                    Spacer()
                    
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundStyle(.secondary)
                }
                
                // Expanded details
                if isExpanded {
                    VStack(alignment: .leading, spacing: 12) {
                        Divider()
                        
                        Text(step.description)
                            .font(.body)
                            .foregroundStyle(.primary)
                        
                        Text(step.action)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .padding()
                            .background(step.color.opacity(0.1))
                            .cornerRadius(8)
                        
                        // Voice indicator
                        HStack {
                            Spacer()
                            Image(systemName: "speaker.wave.2.fill")
                                .foregroundStyle(step.color)
                            Text("Tap to hear details")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            Spacer()
                        }
                    }
                    .transition(.opacity.combined(with: .move(edge: .top)))
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(step.color.opacity(isExpanded ? 0.5 : 0.2), lineWidth: 2)
            )
        }
        .buttonStyle(.plain)
    }
}
