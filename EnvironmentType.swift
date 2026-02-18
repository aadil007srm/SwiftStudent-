import SwiftUI

enum EnvironmentType: String, CaseIterable {
    case lab = "Laboratory"
    case warehouse = "Warehouse"
    case office = "Office"
    case kitchen = "Kitchen"
    case serverRoom = "Server Room"
    case factory = "Factory"
    
    var icon: String {
        switch self {
        case .lab: return "flask.fill"
        case .warehouse: return "shippingbox.fill"
        case .office: return "building.2.fill"
        case .kitchen: return "fork.knife"
        case .serverRoom: return "server.rack"
        case .factory: return "gearshape.2.fill"
        }
    }
    
    var color: Color {
        switch self {
        case .lab: return .blue
        case .warehouse: return .orange
        case .office: return .green
        case .kitchen: return .red
        case .serverRoom: return .purple
        case .factory: return .brown
        }
    }
    
    var description: String {
        switch self {
        case .lab: return "Chemical hazards & scientific equipment"
        case .warehouse: return "Storage & logistics safety"
        case .office: return "Electrical & fire safety"
        case .kitchen: return "Fire & burn prevention"
        case .serverRoom: return "Electrical & cooling systems"
        case .factory: return "Industrial machinery & materials"
        }
    }
}
