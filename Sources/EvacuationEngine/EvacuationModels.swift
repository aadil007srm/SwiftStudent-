import Foundation

// MARK: - Difficulty
public enum Difficulty {
    case easy, medium, hard
}

// MARK: - RoomType
public enum RoomType {
    case lab, office, kitchen, storage, factory, conference
}

// MARK: - Wall
public struct Wall: Identifiable, Sendable {
    public let id = UUID()
    public let start: CGPoint
    public let end: CGPoint

    public init(start: CGPoint, end: CGPoint) {
        self.start = start
        self.end = end
    }
}

// MARK: - Room
public struct Room: Identifiable, Sendable {
    public let id = UUID()
    public let name: String
    public let frame: CGRect
    public let type: RoomType

    public init(name: String, frame: CGRect, type: RoomType) {
        self.name = name
        self.frame = frame
        self.type = type
    }
}

// MARK: - Hallway
public struct Hallway: Identifiable, Sendable {
    public let id = UUID()
    public let frame: CGRect

    public init(frame: CGRect) {
        self.frame = frame
    }
}

// MARK: - Person
public struct Person: Identifiable, Sendable {
    public let id: UUID
    public var position: CGPoint
    public var isRescued: Bool
    public var isFollower: Bool
    /// Index into drawnRoute that this follower is currently at.
    public var followerRouteIndex: Int

    public init(position: CGPoint) {
        self.id = UUID()
        self.position = position
        self.isRescued = false
        self.isFollower = false
        self.followerRouteIndex = 0
    }
}

// MARK: - ExitDoor
public struct ExitDoor: Identifiable, Sendable {
    public let id: UUID
    public let position: CGPoint
    public var status: DoorStatus

    public enum DoorStatus: Sendable {
        case safe, risky, blocked
    }

    public init(position: CGPoint, status: DoorStatus) {
        self.id = UUID()
        self.position = position
        self.status = status
    }
}

// MARK: - EvacuationExtinguisher
public struct EvacuationExtinguisher: Identifiable, Sendable {
    public let id: UUID
    public var position: CGPoint
    public var isPickedUp: Bool

    public init(position: CGPoint) {
        self.id = UUID()
        self.position = position
        self.isPickedUp = false
    }
}

// MARK: - FireHazard
public struct FireHazard: Identifiable, Sendable {
    public let id: UUID
    public var position: CGPoint
    public var intensity: FireIntensity
    /// True when suppressed by a fire extinguisher.
    public var isSuppressed: Bool

    public enum FireIntensity: Sendable {
        case small, medium, large
    }

    public var spreadRadius: CGFloat {
        switch intensity {
        case .small:  return 15
        case .medium: return 25
        case .large:  return 35
        }
    }

    public init(position: CGPoint, intensity: FireIntensity, isSuppressed: Bool = false) {
        self.id = UUID()
        self.position = position
        self.intensity = intensity
        self.isSuppressed = isSuppressed
    }
}

// MARK: - SmokeZone
public struct SmokeZone: Identifiable, Sendable {
    public let id: UUID
    public var center: CGPoint
    public var radius: CGFloat
    public var density: SmokeDensity
    /// How many spread ticks this smoke zone has existed (drives expansion).
    public var age: Int

    public enum SmokeDensity: Sendable {
        case light, medium, heavy
    }

    public init(center: CGPoint, radius: CGFloat, density: SmokeDensity, age: Int = 0) {
        self.id = UUID()
        self.center = center
        self.radius = radius
        self.density = density
        self.age = age
    }

    /// True when the smoke is dense enough to slow movement.
    public var slowsMovement: Bool { density == .heavy }
}
