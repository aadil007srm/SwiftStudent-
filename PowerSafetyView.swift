import SwiftUI

struct PowerSafetyView: View {
    @ObservedObject var gameState: GameState
    
    var body: some View {
        ScrollView {
                VStack(spacing: 24) {
                    // Header
                    VStack(spacing: 12) {
                        Image(systemName: "bolt.trianglebadge.exclamationmark.fill")
                            .font(.system(size: 60))
                            .foregroundStyle(.yellow.gradient)
                        
                        Text("Electrical Safety")
                            .font(.title.bold())
                        
                        Text("Learn when and how to cut power safely")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                    
                    // When to Cut Power
                    VStack(alignment: .leading, spacing: 16) {
                        Text("When to Cut Power")
                            .font(.title2.bold())
                        
                        SafetyRule(
                            icon: "flame.fill",
                            title: "Electrical Fire",
                            description: "If electrical equipment is on fire, cut power at the main breaker BEFORE using extinguisher",
                            color: .red
                        )
                        
                        SafetyRule(
                            icon: "smoke.fill",
                            title: "Smoking Equipment",
                            description: "If you see smoke coming from electrical panels or equipment, cut power immediately",
                            color: .gray
                        )
                        
                        SafetyRule(
                            icon: "bolt.fill",
                            title: "Sparking/Arcing",
                            description: "If equipment is sparking, cut power at the breaker, never touch the equipment",
                            color: .yellow
                        )
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color(.secondarySystemBackground))
                    )
                    
                    // How to Cut Power Safely
                    VStack(alignment: .leading, spacing: 16) {
                        Text("How to Cut Power Safely")
                            .font(.title2.bold())
                        
                        StepCard(number: 1, text: "Locate the main electrical panel (breaker box)")
                        StepCard(number: 2, text: "Stand on dry surface, use dry hands")
                        StepCard(number: 3, text: "Flip the main breaker to OFF position")
                        StepCard(number: 4, text: "Verify power is off before approaching fire")
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color(.secondarySystemBackground))
                    )
                    
                    // Danger Warnings
                    VStack(alignment: .leading, spacing: 16) {
                        Text("⚠️ NEVER")
                            .font(.title2.bold())
                            .foregroundStyle(.red)
                        
                        DangerWarning(text: "Use water on electrical fires")
                        DangerWarning(text: "Touch electrical equipment while standing in water")
                        DangerWarning(text: "Cut power if breaker panel is on fire")
                        DangerWarning(text: "Approach downed power lines")
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.red.opacity(0.1))
                    )
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct SafetyRule: View {
    let icon: String
    let title: String
    let description: String
    let color: Color
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(color.gradient)
                .frame(width: 40)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                Text(description)
                    .font(.body)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

struct StepCard: View {
    let number: Int
    let text: String
    
    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(Color.blue.gradient)
                    .frame(width: 32, height: 32)
                
                Text("\(number)")
                    .font(.headline.bold())
                    .foregroundStyle(.white)
            }
            
            Text(text)
                .font(.body)
        }
    }
}

struct DangerWarning: View {
    let text: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "xmark.circle.fill")
                .foregroundStyle(.red)
            Text(text)
                .font(.body)
        }
    }
}

#Preview {
    PowerSafetyView(gameState: GameState())
}
