import SwiftUI

enum HazardType: String, CaseIterable {
    case electrical = "Electrical"
    case flammableLiquid = "Flammable Liquid"
    case gas = "Gas"
    case heavySmoke = "Heavy Smoke"
    
    var color: Color {
        switch self {
        case .electrical: return .yellow
        case .flammableLiquid: return .red
        case .gas: return .green
        case .heavySmoke: return .gray
        }
    }
    
    var icon: String {
        switch self {
        case .electrical: return "bolt.fill"
        case .flammableLiquid: return "flame.fill"
        case .gas: return "wind"
        case .heavySmoke: return "smoke.fill"
        }
    }
}
