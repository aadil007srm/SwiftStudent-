import SwiftUI

// MARK: - Seeded Random Number Generator
/// A deterministic linear-congruential RNG useful for testing.
struct SeededRNG: RandomNumberGenerator {
    private var state: UInt64

    init(seed: UInt64) { state = seed }

    mutating func next() -> UInt64 {
        // 64-bit linear congruential generator (LCG) with Knuth/Newlib constants
        state = state &* 6_364_136_223_846_793_005 &+ 1_442_695_040_888_963_407
        return state
    }
}

class FireSpreadEngine {

    // MARK: - Fire Spread Calculation

    /// Calculates the next fire state using the system RNG.
    static func calculateSpread(from fires: [FireHazard], walls: [Wall], timeElapsed: Int) -> [FireHazard] {
        var rng = SystemRandomNumberGenerator()
        return calculateSpread(from: fires, walls: walls, timeElapsed: timeElapsed, rng: &rng)
    }

    /// Calculates the next fire state using an injectable RNG (enables deterministic testing).
    static func calculateSpread<R: RandomNumberGenerator>(
        from fires: [FireHazard],
        walls: [Wall],
        timeElapsed: Int,
        rng: inout R
    ) -> [FireHazard] {
        var allFires = fires

        for fire in fires where !fire.isSuppressed {
            let spreadChance = spreadProbability(for: fire.intensity, timeElapsed: timeElapsed)

            if Double.random(in: 0...1, using: &rng) < spreadChance {
                let directions: [(CGFloat, CGFloat)] = [
                    (20, 0), (-20, 0), (0, 20), (0, -20),
                    (14, 14), (-14, 14), (14, -14), (-14, -14)
                ]
                for (dx, dy) in directions {
                    let newPosition = CGPoint(x: fire.position.x + dx, y: fire.position.y + dy)
                    if isValidPosition(newPosition, walls: walls, existingFires: allFires) {
                        allFires.append(FireHazard(position: newPosition, intensity: .small))
                    }
                }
            }
        }

        // Upgrade fire intensities over time (suppressed fires do not upgrade)
        return allFires.map { fire in
            guard !fire.isSuppressed else { return fire }
            let upgradeChance = Double(timeElapsed) / 100.0
            if Double.random(in: 0...1, using: &rng) < upgradeChance {
                switch fire.intensity {
                case .small:  return FireHazard(position: fire.position, intensity: .medium)
                case .medium: return FireHazard(position: fire.position, intensity: .large)
                case .large:  return fire
                }
            }
            return fire
        }
    }

    // MARK: - Smoke Generation

    /// Creates fresh smoke zones from the current fire list.
    static func generateSmoke(from fires: [FireHazard]) -> [SmokeZone] {
        fires.map { fire in
            let density: SmokeZone.SmokeDensity = fire.isSuppressed ? .light : {
                switch fire.intensity {
                case .small:  return .light
                case .medium: return .medium
                case .large:  return .heavy
                }
            }()
            return SmokeZone(center: fire.position, radius: fire.spreadRadius * 2.5, density: density)
        }
    }

    /// Evolves existing smoke zones (expansion + persistence) and merges with newly generated smoke.
    /// - Parameters:
    ///   - existing: smoke zones carried over from the previous tick.
    ///   - fires: current fire state (used to generate any new smoke zones).
    ///   - expansionPerTick: additional radius each smoke zone gains per tick.
    static func evolveSmoke(existing: [SmokeZone], fires: [FireHazard],
                            expansionPerTick: CGFloat = 4) -> [SmokeZone] {
        // Age and expand existing smoke
        var evolved: [SmokeZone] = existing.compactMap { zone in
            let newAge = zone.age + 1
            // Persist for up to 6 ticks even if the originating fire is gone
            guard newAge <= 6 else { return nil }
            var z = zone
            z.age = newAge
            z.radius += expansionPerTick
            return z
        }

        // Add new smoke from active fires (avoid duplicates near existing zones)
        for fire in fires {
            let newSmoke = SmokeZone(
                center: fire.position,
                radius: fire.spreadRadius * 2.5,
                density: fire.isSuppressed ? .light : {
                    switch fire.intensity {
                    case .small:  return SmokeZone.SmokeDensity.light
                    case .medium: return .medium
                    case .large:  return .heavy
                    }
                }()
            )
            // Only add if there's no existing zone very close to this fire
            let alreadyCovered = evolved.contains { dist($0.center, newSmoke.center) < 10 }
            if !alreadyCovered {
                evolved.append(newSmoke)
            }
        }
        return evolved
    }

    // MARK: - Helper Methods

    static func isInFire(_ point: CGPoint, fires: [FireHazard]) -> Bool {
        fires.contains { fire in
            !fire.isSuppressed && dist(point, fire.position) < fire.spreadRadius
        }
    }

    static func isInHeavySmoke(_ point: CGPoint, smokeZones: [SmokeZone]) -> Bool {
        smokeZones.contains { smoke in
            smoke.density == .heavy && dist(point, smoke.center) < smoke.radius
        }
    }

    static func isInSmoke(_ point: CGPoint, smokeZones: [SmokeZone]) -> Bool {
        smokeZones.contains { dist(point, $0.center) < $0.radius }
    }

    // MARK: - Private Helpers

    private static func spreadProbability(for intensity: FireHazard.FireIntensity, timeElapsed: Int) -> Double {
        let base: Double = {
            switch intensity {
            case .small:  return 0.3
            case .medium: return 0.5
            case .large:  return 0.7
            }
        }()
        return min(base + Double(timeElapsed) / 100.0, 0.9)
    }

    private static func isValidPosition(_ position: CGPoint, walls: [Wall], existingFires: [FireHazard]) -> Bool {
        guard position.x >= 20 && position.x <= 300 &&
              position.y >= 20 && position.y <= 300 else { return false }

        for fire in existingFires where dist(position, fire.position) < 10 {
            return false
        }
        return true
    }

    private static func dist(_ a: CGPoint, _ b: CGPoint) -> CGFloat {
        let dx = a.x - b.x, dy = a.y - b.y
        return sqrt(dx * dx + dy * dy)
    }
}
