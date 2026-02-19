import SwiftUI

enum ExtinguisherType: String, CaseIterable, Identifiable {
    case water = "Water"
    case foam = "Foam"
    case co2 = "CO2"
    case dryChemical = "Dry Chemical"
    case dryPowder = "Dry Powder"
    
    var id: String { rawValue }
    
    var icon: String {
        switch self {
        case .water: return "💧"
        case .foam: return "🧯"
        case .co2: return "🧯"
        case .dryChemical: return "🧯"
        case .dryPowder: return "🧂"
        }
    }
    
    var color: Color {
        switch self {
        case .water: return .blue
        case .foam: return .cyan
        case .co2: return .green
        case .dryChemical: return .red
        case .dryPowder: return .orange
        }
    }
    
    var compatibleFireTypes: [FireType] {
        switch self {
        case .water:
            return [.classA]
        case .foam:
            return [.classA, .classB]
        case .co2:
            return [.classB, .classC]
        case .dryChemical:
            return [.classA, .classB, .classC]
        case .dryPowder:
            return [.classD]
        }
    }
    
    var description: String {
        switch self {
        case .water:
            return "Best for solid materials. Cools the fire. Never use on electrical or liquid fires."
        case .foam:
            return "Works on solid and liquid fires. Creates a blanket that smothers flames."
        case .co2:
            return "Safe for electrical fires. Displaces oxygen without leaving residue."
        case .dryChemical:
            return "Multi-purpose extinguisher. Works on most fire types except metal fires."
        case .dryPowder:
            return "Special extinguisher for metal and firecracker fires. Creates a heat-absorbing crust."
        }
    }
    
    var systemImage: String {
        switch self {
        case .water: return "drop.fill"
        case .foam: return "flame.fill"
        case .co2: return "wind"
        case .dryChemical: return "extinguisher.fill"
        case .dryPowder: return "powdersand.fill"
        }
    }
}

struct ExtinguisherGuide {
    let extinguisher: ExtinguisherType
    let compatibleWith: [FireType]
    let incompatibleWith: [FireType]
    
    static func isCompatible(extinguisher: ExtinguisherType, fireType: FireType) -> Bool {
        return extinguisher.compatibleFireTypes.contains(fireType)
    }
}
