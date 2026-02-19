import SwiftUI

enum FireType: String, CaseIterable, Identifiable {
    case classA = "Class A"
    case classB = "Class B"
    case classC = "Class C"
    case classD = "Class D"
    
    var id: String { rawValue }
    
    var name: String {
        switch self {
        case .classA: return "Class A - Solid Materials"
        case .classB: return "Class B - Flammable Liquids"
        case .classC: return "Class C - Electrical"
        case .classD: return "Class D - Metal/Firecracker"
        }
    }
    
    var materials: String {
        switch self {
        case .classA: return "Wood, Paper, Cloth, Plastic"
        case .classB: return "Gasoline, Oil, Grease, Chemicals"
        case .classC: return "Electrical Equipment, Wiring, Motors"
        case .classD: return "Metal Powders, Firecrackers, Pyrotechnics"
        }
    }
    
    var correctExtinguisher: String {
        switch self {
        case .classA: return "💧 Water or Foam"
        case .classB: return "🧯 Foam or CO2"
        case .classC: return "🧯 CO2 or Dry Chemical"
        case .classD: return "🧂 Dry Powder (Special)"
        }
    }
    
    var wrongExtinguisher: String {
        switch self {
        case .classA: return "❌ Don't use: CO2 on large fires"
        case .classB: return "❌ NEVER use: Water (spreads fire)"
        case .classC: return "❌ NEVER use: Water (electrocution risk)"
        case .classD: return "❌ NEVER use: Water (explosion risk)"
        }
    }
    
    var icon: String {
        switch self {
        case .classA: return "🪵"
        case .classB: return "🧪"
        case .classC: return "🔌"
        case .classD: return "🎆"
        }
    }
    
    var color: Color {
        switch self {
        case .classA: return .brown
        case .classB: return .purple
        case .classC: return .yellow
        case .classD: return .red
        }
    }
    
    var voiceExplanation: String {
        switch self {
        case .classA:
            return "Class A fires involve solid materials like wood, paper, cloth and plastic. Use water or foam extinguishers. These are the most common fires."
        case .classB:
            return "Class B fires involve flammable liquids like gasoline, oil and chemicals. Never use water as it spreads the fire. Use foam or CO2 extinguishers."
        case .classC:
            return "Class C fires involve electrical equipment. Never use water as you risk electrocution. First cut the power if safe, then use CO2 or dry chemical extinguishers."
        case .classD:
            return "Class D fires involve combustible metals and firecrackers. These are extremely dangerous. Never use water as it can cause explosions. Use special dry powder extinguishers only."
        }
    }
}
