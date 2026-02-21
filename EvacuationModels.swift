import SwiftUI

// MARK: - Difficulty
enum Difficulty {
    case easy, medium, hard
}

// MARK: - RoomType
enum RoomType {
    case lab, office, kitchen, storage, factory, conference
}

// MARK: - Wall
struct Wall: Identifiable, Sendable {
    let id = UUID()
    let start: CGPoint
    let end: CGPoint
}

// MARK: - Room
struct Room: Identifiable, Sendable {
    let id = UUID()
    let name: String
    let frame: CGRect
    let type: RoomType
}

// MARK: - Hallway
struct Hallway: Identifiable, Sendable {
    let id = UUID()
    let frame: CGRect
}

// MARK: - Person
struct Person: Identifiable, Sendable {
    let id: UUID
    var position: CGPoint
    var isRescued: Bool
    var isFollower: Bool
    /// Index into drawnRoute that this follower is currently at.
    var followerRouteIndex: Int

    init(position: CGPoint) {
        self.id = UUID()
        self.position = position
        self.isRescued = false
        self.isFollower = false
        self.followerRouteIndex = 0
    }
}

// MARK: - ExitDoor
struct ExitDoor: Identifiable, Sendable {
    let id: UUID
    let position: CGPoint
    var status: DoorStatus

    enum DoorStatus: Sendable {
        case safe, risky, blocked
    }

    init(position: CGPoint, status: DoorStatus) {
        self.id = UUID()
        self.position = position
        self.status = status
    }
}

// MARK: - EvacuationExtinguisher
struct EvacuationExtinguisher: Identifiable, Sendable {
    let id: UUID
    var position: CGPoint
    var isPickedUp: Bool

    init(position: CGPoint) {
        self.id = UUID()
        self.position = position
        self.isPickedUp = false
    }
}

// MARK: - FireHazard
struct FireHazard: Identifiable, Sendable {
    let id: UUID
    var position: CGPoint
    var intensity: FireIntensity
    /// True when suppressed by a fire extinguisher.
    var isSuppressed: Bool

    enum FireIntensity: Sendable {
        case small, medium, large
    }

    var spreadRadius: CGFloat {
        switch intensity {
        case .small:  return 15
        case .medium: return 25
        case .large:  return 35
        }
    }

    init(position: CGPoint, intensity: FireIntensity, isSuppressed: Bool = false) {
        self.id = UUID()
        self.position = position
        self.intensity = intensity
        self.isSuppressed = isSuppressed
    }
}

// MARK: - SmokeZone
struct SmokeZone: Identifiable, Sendable {
    let id: UUID
    var center: CGPoint
    var radius: CGFloat
    var density: SmokeDensity
    /// How many spread ticks this smoke zone has existed (drives expansion).
    var age: Int

    enum SmokeDensity: Sendable {
        case light, medium, heavy
    }

    init(center: CGPoint, radius: CGFloat, density: SmokeDensity, age: Int = 0) {
        self.id = UUID()
        self.center = center
        self.radius = radius
        self.density = density
        self.age = age
    }

    /// True when the smoke is dense enough to slow movement.
    var slowsMovement: Bool { density == .heavy }
}
