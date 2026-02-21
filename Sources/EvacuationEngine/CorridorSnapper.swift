import Foundation

/// Snaps map-coordinate points to the nearest corridor (hallway) area.
public struct CorridorSnapper {

    /// Returns `point` unchanged if it lies inside any hallway rect;
    /// otherwise returns the closest point on the boundary of the nearest hallway rect.
    public static func snap(point: CGPoint, hallways: [Hallway]) -> CGPoint {
        guard !hallways.isEmpty else { return point }

        // Already inside a corridor – no adjustment needed.
        for hallway in hallways where hallway.frame.contains(point) {
            return point
        }

        // Clamp to the nearest hallway rect.
        var bestPoint = point
        var bestDist  = CGFloat.infinity
        for hallway in hallways {
            let clamped = clamp(point: point, to: hallway.frame)
            let d = dist(point, clamped)
            if d < bestDist {
                bestDist  = d
                bestPoint = clamped
            }
        }
        return bestPoint
    }

    // MARK: - Private helpers

    private static func clamp(point: CGPoint, to rect: CGRect) -> CGPoint {
        CGPoint(
            x: max(rect.minX, min(rect.maxX, point.x)),
            y: max(rect.minY, min(rect.maxY, point.y))
        )
    }

    private static func dist(_ a: CGPoint, _ b: CGPoint) -> CGFloat {
        let dx = a.x - b.x, dy = a.y - b.y
        return sqrt(dx * dx + dy * dy)
    }
}
