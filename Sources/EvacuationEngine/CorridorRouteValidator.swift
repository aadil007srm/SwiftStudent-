import Foundation

/// Validates that a route polyline stays within corridor (hallway) areas.
public struct CorridorRouteValidator {

    /// Validates that every sampled point along each route segment lies inside
    /// at least one hallway rectangle.
    ///
    /// - Parameters:
    ///   - route:    The route as an ordered array of map-coordinate points.
    ///   - hallways: The hallway definitions to validate against.
    ///   - step:     Sampling step size in map units (default 5).
    /// - Returns:    A tuple `(isValid, reason)` where `reason` is non-nil when invalid.
    public static func validate(
        route: [CGPoint],
        hallways: [Hallway],
        step: CGFloat = 5
    ) -> (isValid: Bool, reason: String?) {
        guard route.count >= 2 else { return (true, nil) }

        for i in 0..<(route.count - 1) {
            let from = route[i]
            let to   = route[i + 1]
            let segLen = dist(from, to)
            guard segLen > 0 else { continue }

            // Sample along the segment at `step`-unit intervals.
            var t: CGFloat = 0
            while t < segLen {
                let ratio  = t / segLen
                let sample = CGPoint(
                    x: from.x + (to.x - from.x) * ratio,
                    y: from.y + (to.y - from.y) * ratio
                )
                if !isInsideAnyHallway(sample, hallways: hallways) {
                    return (false, "Route leaves corridor area")
                }
                t += step
            }

            // Always check the segment endpoint.
            if !isInsideAnyHallway(to, hallways: hallways) {
                return (false, "Route leaves corridor area")
            }
        }

        return (true, nil)
    }

    // MARK: - Private helpers

    private static func isInsideAnyHallway(_ point: CGPoint, hallways: [Hallway]) -> Bool {
        hallways.contains { $0.frame.contains(point) }
    }

    private static func dist(_ a: CGPoint, _ b: CGPoint) -> CGFloat {
        let dx = a.x - b.x, dy = a.y - b.y
        return sqrt(dx * dx + dy * dy)
    }
}
