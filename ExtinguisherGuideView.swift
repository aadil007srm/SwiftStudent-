import SwiftUI

struct ExtinguisherGuideView: View {
    @ObservedObject var gameState: GameState
    @State private var draggedExtinguisher: ExtinguisherType?
    @State private var showFeedback = false
    @State private var isCorrect = false
    
    // ✅ Use the shared data
    let extinguishers = ExtinguisherType.allExtinguishers
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    // Header
                    VStack(spacing: 8) {
                        Image(systemName: "flame.fill")
                            .font(.system(size: 50))
                            .foregroundStyle(.red.gradient)
                        
                        Text("Extinguisher Guide")
                            .font(.title.bold())
                        
                        Text("Learn which extinguisher to use for each fire type")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                    
                    // Extinguisher Cards
                    ForEach(extinguishers) { extinguisher in
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Image(systemName: extinguisher.icon)
                                    .font(.title)
                                    .foregroundStyle(extinguisher.color.gradient)
                                
                                Text(extinguisher.name)
                                    .font(.title2.bold())
                                
                                Spacer()
                            }
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Label("Use on:", systemImage: "checkmark.circle.fill")
                                    .font(.headline)
                                    .foregroundStyle(.green)
                                
                                ForEach(extinguisher.compatibleFires, id: \.self) { fire in
                                    Text("• \(fire)")
                                        .font(.body)
                                }
                            }
                            
                            Divider()
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Label("Do NOT use on:", systemImage: "xmark.circle.fill")
                                    .font(.headline)
                                    .foregroundStyle(.red)
                                
                                ForEach(extinguisher.incompatibleFires, id: \.self) { fire in
                                    Text("• \(fire)")
                                        .font(.body)
                                }
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color(.systemBackground))
                                .shadow(color: extinguisher.color.opacity(0.2), radius: 8)
                        )
                        .padding(.horizontal)
                    }
                    
                    // Quick Reference
                    VStack(spacing: 16) {
                        Text("Quick Reference")
                            .font(.title2.bold())
                        
                        HStack(spacing: 20) {
                            quickRefCard(icon: "flame.fill", text: "Class A\nWood/Paper", color: .brown, extinguisher: "💧 Water")
                            quickRefCard(icon: "bolt.fill", text: "Class C\nElectrical", color: .yellow, extinguisher: "🧯 CO2")
                        }
                        
                        HStack(spacing: 20) {
                            quickRefCard(icon: "flask.fill", text: "Class B\nChemical", color: .purple, extinguisher: "🧯 Foam")
                            quickRefCard(icon: "sparkles", text: "Class D\nMetal/Firecracker", color: .orange, extinguisher: "🧂 Powder")
                        }
                    }
                    .padding()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Back") {
                        gameState.currentScreen = .home
                    }
                }
            }
        }
    }
    
    private func quickRefCard(icon: String, text: String, color: Color, extinguisher: String) -> some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.largeTitle)
                .foregroundStyle(color.gradient)
            
            Text(text)
                .font(.caption)
                .multilineTextAlignment(.center)
            
            Text(extinguisher)
                .font(.title3)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.secondarySystemBackground))
        )
    }
}

#Preview {
    ExtinguisherGuideView(gameState: GameState())
}
