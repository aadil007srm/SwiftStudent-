import SwiftUI

enum EnvironmentType: String, CaseIterable, Identifiable {
    case lab = "Laboratory"
    case office = "Office"
    case kitchen = "Kitchen"
    case factory = "Factory"
    
    var id: String { rawValue }
    
    var icon: String {
        switch self {
        case .lab: return "flask.fill"
        case .office: return "building.2.fill"
        case .kitchen: return "fork.knife"
        case .factory: return "gearshape.2.fill"
        }
    }
    
    var color: Color {
        switch self {
        case .lab: return .labPurple
        case .office: return .officeBlue
        case .kitchen: return .kitchenRed
        case .factory: return .factoryOrange
        }
    }
    
    var description: String {
        switch self {
        case .lab: return "Chemical & equipment safety"
        case .office: return "Fire & electrical safety"
        case .kitchen: return "Fire & burn prevention"
        case .factory: return "Industrial safety"
        }
    }
}
