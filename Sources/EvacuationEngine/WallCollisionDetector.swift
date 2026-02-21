import Foundation

/// Provides geometric helpers for wall-collision detection during route drawing.
public struct WallCollisionDetector {

    // MARK: - Public API

    /// Returns `true` if the segment (p1 → p2) properly crosses any wall segment.
    public static func segmentCrossesWall(from p1: CGPoint, to p2: CGPoint, walls: [Wall]) -> Bool {
        for wall in walls where segmentsIntersect(p1, p2, wall.start, wall.end) {
            return true
        }
        return false
    }

    /// Returns `true` if line segment (p1 → p2) properly intersects line segment (p3 → p4).
    public static func segmentsIntersect(_ p1: CGPoint, _ p2: CGPoint,
                                  _ p3: CGPoint, _ p4: CGPoint) -> Bool {
        let d1 = cross(p3, p4, p1)
        let d2 = cross(p3, p4, p2)
        let d3 = cross(p1, p2, p3)
        let d4 = cross(p1, p2, p4)

        if signsDiffer(d1, d2) && signsDiffer(d3, d4) { return true }

        // Collinear / endpoint cases
        if d1 == 0 && onSegment(p3, p4, p1) { return true }
        if d2 == 0 && onSegment(p3, p4, p2) { return true }
        if d3 == 0 && onSegment(p1, p2, p3) { return true }
        if d4 == 0 && onSegment(p1, p2, p4) { return true }

        return false
    }

    // MARK: - Private Helpers

    /// Cross product of vectors (pi→pj) and (pi→pk).
    private static func cross(_ pi: CGPoint, _ pj: CGPoint, _ pk: CGPoint) -> CGFloat {
        (pj.x - pi.x) * (pk.y - pi.y) - (pj.y - pi.y) * (pk.x - pi.x)
    }

    /// Returns true when a and b have strictly opposite signs.
    private static func signsDiffer(_ a: CGFloat, _ b: CGFloat) -> Bool {
        (a > 0 && b < 0) || (a < 0 && b > 0)
    }

    /// Returns true when pk lies on segment (pi → pj) – assumes the three points are collinear.
    private static func onSegment(_ pi: CGPoint, _ pj: CGPoint, _ pk: CGPoint) -> Bool {
        pk.x <= max(pi.x, pj.x) && pk.x >= min(pi.x, pj.x) &&
        pk.y <= max(pi.y, pj.y) && pk.y >= min(pi.y, pj.y)
    }
}
