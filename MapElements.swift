import SwiftUI

// MARK: - Room Type
enum RoomType {
    case lab
    case office
    case storage
    case kitchen
    case conference
    case factory
}

// MARK: - Room
struct Room {
    let name: String
    let frame: CGRect
    let type: RoomType
}

// MARK: - Hallway
struct Hallway {
    let frame: CGRect
}

// MARK: - Wall
struct Wall {
    let start: CGPoint
    let end: CGPoint
}

// MARK: - Exit Door
struct ExitDoor: Identifiable {
    let id = UUID()
    let position: CGPoint
    var status: DoorStatus
    
    enum DoorStatus {
        case safe
        case risky
        case blocked
    }
}

// MARK: - Person
struct Person: Identifiable {
    let id = UUID()
    let position: CGPoint
    var isRescued: Bool = false
}

// MARK: - Fire Hazard
struct FireHazard: Identifiable {
    let id = UUID()
    let position: CGPoint
    let intensity: FireIntensity
    var spreadRadius: CGFloat {
        switch intensity {
        case .small: return 15
        case .medium: return 25
        case .large: return 40
        }
    }
    
    enum FireIntensity {
        case small
        case medium
        case large
    }
}

// MARK: - Smoke Zone
struct SmokeZone: Identifiable {
    let id = UUID()
    let center: CGPoint
    let radius: CGFloat
    let density: SmokeDensity
    
    enum SmokeDensity {
        case light
        case medium
        case heavy
    }
}

// MARK: - Evacuation Extinguisher
struct EvacuationExtinguisher: Identifiable {
    let id = UUID()
    let position: CGPoint
    var isUsed: Bool = false
}

// MARK: - Difficulty
enum Difficulty {
    case easy
    case medium
    case hard
}
