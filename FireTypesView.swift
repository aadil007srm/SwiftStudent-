import SwiftUI

struct FireTypesView: View {
    @ObservedObject var gameState: GameState
    @State private var expandedType: FireClass?
    
    enum FireClass: String, CaseIterable, Identifiable {
        case classA = "Class A - Wood/Paper"
        case classB = "Class B - Flammable Liquids"
        case classC = "Class C - Electrical"
        case classD = "Class D - Metal/Firecracker"
        
        var id: String { rawValue }
        
        var icon: String {
            switch self {
            case .classA: return "leaf.fill"
            case .classB: return "drop.fill"
            case .classC: return "bolt.fill"
            case .classD: return "sparkles"
            }
        }
        
        var color: Color {
            switch self {
            case .classA: return .brown
            case .classB: return .purple
            case .classC: return .yellow
            case .classD: return .orange
            }
        }
        
        var correctExtinguisher: String {
            switch self {
            case .classA: return "💧 Water or Foam"
            case .classB: return "🧯 Foam or CO2"
            case .classC: return "🧯 CO2 or Dry Powder"
            case .classD: return "🧂 Dry Powder (Special)"
            }
        }
        
        var dangerousExtinguisher: String {
            switch self {
            case .classA: return "❌ None (most work)"
            case .classB: return "❌ Water (spreads fire)"
            case .classC: return "❌ Water (electrocution risk)"
            case .classD: return "❌ Water (explosive reaction)"
            }
        }
        
        var description: String {
            switch self {
            case .classA:
                return "Fires involving solid materials like wood, paper, cloth, and plastic. These are the most common fires."
            case .classB:
                return "Fires involving flammable liquids like gasoline, oil, paint, and solvents. Never use water!"
            case .classC:
                return "Fires involving electrical equipment like motors, generators, and appliances. Cut power first if safe."
            case .classD:
                return "Fires involving combustible metals and firecrackers. Extremely dangerous - requires special extinguishers."
            }
        }
        
        var examples: [String] {
            switch self {
            case .classA:
                return ["Wood furniture", "Paper documents", "Cardboard boxes", "Fabric/clothing"]
            case .classB:
                return ["Gasoline", "Oil", "Paint", "Chemical solvents"]
            case .classC:
                return ["Electrical panels", "Motors", "Appliances", "Wiring"]
            case .classD:
                return ["Firecracker powder", "Magnesium", "Sodium", "Potassium"]
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    // Header
                    VStack(spacing: 12) {
                        Image(systemName: "flame.fill")
                            .font(.system(size: 60))
                            .foregroundStyle(.red.gradient)
                        
                        Text("Fire Classification")
                            .font(.title.bold())
                        
                        Text("Learn the 4 types of fires and how to fight them")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                    
                    // Fire Types
                    ForEach(FireClass.allCases) { fireClass in
                        FireTypeCard(
                            fireClass: fireClass,
                            isExpanded: expandedType == fireClass
                        ) {
                            withAnimation(.spring()) {
                                expandedType = expandedType == fireClass ? nil : fireClass
                            }
                        }
                    }
                }
                .padding()
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
}

struct FireTypeCard: View {
    let fireClass: FireTypesView.FireClass
    let isExpanded: Bool
    let onTap: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Header
            Button(action: onTap) {
                HStack {
                    Image(systemName: fireClass.icon)
                        .font(.title)
                        .foregroundStyle(fireClass.color.gradient)
                        .frame(width: 40)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(fireClass.rawValue)
                            .font(.headline)
                            .foregroundStyle(.primary)
                        
                        if !isExpanded {
                            Text("Tap to learn more")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                    
                    Spacer()
                    
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundStyle(.secondary)
                }
            }
            .buttonStyle(.plain)
            
            // Expanded Content
            if isExpanded {
                VStack(alignment: .leading, spacing: 16) {
                    Divider()
                    
                    // Description
                    Text(fireClass.description)
                        .font(.body)
                    
                    // Examples
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Examples:")
                            .font(.subheadline.bold())
                        
                        ForEach(fireClass.examples, id: \.self) { example in
                            HStack {
                                Image(systemName: "circle.fill")
                                    .font(.system(size: 6))
                                    .foregroundStyle(fireClass.color)
                                Text(example)
                                    .font(.callout)
                            }
                        }
                    }
                    
                    Divider()
                    
                    // Correct Extinguisher
                    HStack(spacing: 12) {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundStyle(.green)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Use:")
                                .font(.caption.bold())
                            Text(fireClass.correctExtinguisher)
                                .font(.body)
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(8)
                    
                    // Dangerous Extinguisher
                    HStack(spacing: 12) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.red)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Never Use:")
                                .font(.caption.bold())
                            Text(fireClass.dangerousExtinguisher)
                                .font(.body)
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.red.opacity(0.1))
                    .cornerRadius(8)
                }
                .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.secondarySystemBackground))
                .shadow(color: fireClass.color.opacity(0.2), radius: 8)
        )
    }
}

#Preview {
    FireTypesView(gameState: GameState())
}
