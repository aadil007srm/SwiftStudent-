import SwiftUI

struct ExitDoor: Identifiable {
    let id = UUID()
    var position: CGPoint
    var status: DoorStatus

    enum DoorStatus {
        case safe      // Green
        case risky     // Yellow - smoke nearby
        case blocked   // Red - fire blocking
    }

    var color: Color {
        switch status {
        case .safe:    return .exitGreen
        case .risky:   return .exitYellow
        case .blocked: return .exitRed
        }
    }
}

struct Person: Identifiable {
    let id = UUID()
    var position: CGPoint
    var isRescued: Bool = false
    var name: String = "Person"
}

struct FireHazard: Identifiable {
    let id = UUID()
    var position: CGPoint
    var intensity: FireIntensity
    var spreadRadius: CGFloat = 30.0

    enum FireIntensity {
        case small
        case medium
        case large

        var radius: CGFloat {
            switch self {
            case .small:  return 14
            case .medium: return 20
            case .large:  return 28
            }
        }
    }
}

struct SmokeZone: Identifiable {
    let id = UUID()
    var center: CGPoint
    var radius: CGFloat
    var density: SmokeDensity

    enum SmokeDensity {
        case light
        case medium
        case heavy

        var opacity: Double {
            switch self {
            case .light:  return 0.2
            case .medium: return 0.4
            case .heavy:  return 0.6
            }
        }
    }
}

struct EvacuationExtinguisher: Identifiable {
    let id = UUID()
    var position: CGPoint
    var isUsed: Bool = false
}

struct Wall {
    var start: CGPoint
    var end: CGPoint
}

struct Hallway {
    var frame: CGRect
}

struct Room {
    let name: String
    let frame: CGRect
    let type: RoomType
}

enum RoomType {
    case lab, office, storage, kitchen, conference, factory
}

enum Difficulty {
    case easy
    case medium
    case hard
}
