import Foundation
import CoreGraphics

// MARK: - Fire Spread Engine (100% offline, no networking)
struct FireSpreadEngine {

    /// Calculate new fire positions by expanding from existing fires.
    static func calculateSpread(from fires: [FireHazard], walls: [Wall]) -> [FireHazard] {
        var allFires = fires
        let existingPositions = Set(fires.map { GridKey($0.position) })
        var newFires: [FireHazard] = []

        for fire in fires {
            let adjacentCells = getAdjacentCells(fire.position, step: 30)
            for cell in adjacentCells {
                guard !existingPositions.contains(GridKey(cell)) else { continue }
                guard !isBlocked(cell, by: walls) else { continue }
                guard !newFires.contains(where: { GridKey($0.position) == GridKey(cell) }) else { continue }
                newFires.append(FireHazard(position: cell, intensity: .small))
            }
        }

        // Upgrade intensity of existing fires over time
        allFires = allFires.map { fire in
            var f = fire
            switch f.intensity {
            case .small:  f.intensity = .medium
            case .medium: f.intensity = .large
            case .large:  break
            }
            return f
        }

        allFires.append(contentsOf: newFires)
        return allFires
    }

    /// Generate smoke zones around fire locations.
    static func generateSmoke(from fires: [FireHazard]) -> [SmokeZone] {
        var smokeZones: [SmokeZone] = []
        for fire in fires {
            smokeZones.append(SmokeZone(center: fire.position, radius: 45.0, density: .heavy))
            smokeZones.append(SmokeZone(center: fire.position, radius: 70.0, density: .medium))
            smokeZones.append(SmokeZone(center: fire.position, radius: 100.0, density: .light))
        }
        return smokeZones
    }

    /// Returns adjacent cardinal and diagonal cells at `step` distance.
    static func getAdjacentCells(_ point: CGPoint, step: CGFloat) -> [CGPoint] {
        let directions: [(CGFloat, CGFloat)] = [
            (0, -1), (1, 0), (0, 1), (-1, 0),
            (1, -1), (1, 1), (-1, 1), (-1, -1)
        ]
        return directions.map { (dx, dy) in
            CGPoint(x: point.x + dx * step, y: point.y + dy * step)
        }
    }

    /// Returns true if the given point is within any wall segment (simple AABB check).
    static func isBlocked(_ point: CGPoint, by walls: [Wall]) -> Bool {
        for wall in walls {
            let minX = min(wall.start.x, wall.end.x) - 5
            let maxX = max(wall.start.x, wall.end.x) + 5
            let minY = min(wall.start.y, wall.end.y) - 5
            let maxY = max(wall.start.y, wall.end.y) + 5
            if point.x >= minX && point.x <= maxX && point.y >= minY && point.y <= maxY {
                return true
            }
        }
        return false
    }

    /// Checks whether a point is within a given distance of a fire or smoke zone.
    static func isHazardous(_ point: CGPoint, fires: [FireHazard], smokeZones: [SmokeZone], safeRadius: CGFloat = 25) -> Bool {
        for fire in fires {
            if distance(point, fire.position) < safeRadius + fire.intensity.radius {
                return true
            }
        }
        for smoke in smokeZones where smoke.density == .heavy {
            if distance(point, smoke.center) < smoke.radius * 0.6 {
                return true
            }
        }
        return false
    }

    // MARK: - Helpers
    static func distance(_ a: CGPoint, _ b: CGPoint) -> CGFloat {
        let dx = a.x - b.x
        let dy = a.y - b.y
        return sqrt(dx * dx + dy * dy)
    }

    private struct GridKey: Hashable {
        let x: Int
        let y: Int
        init(_ point: CGPoint, step: CGFloat = 30) {
            x = Int((point.x / step).rounded())
            y = Int((point.y / step).rounded())
        }
    }
}
