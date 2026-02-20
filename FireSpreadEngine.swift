import SwiftUI

class FireSpreadEngine {
    
    // MARK: - Fire Spread Calculation
    static func calculateSpread(from fires: [FireHazard], walls: [Wall], timeElapsed: Int) -> [FireHazard] {
        var allFires = fires
        
        // Spread existing fires
        for fire in fires {
            let spreadChance = spreadProbability(for: fire.intensity, timeElapsed: timeElapsed)
            
            if Double.random(in: 0...1) < spreadChance {
                // Try to spread in 8 directions
                let directions: [(CGFloat, CGFloat)] = [
                    (20, 0), (-20, 0), (0, 20), (0, -20),
                    (14, 14), (-14, 14), (14, -14), (-14, -14)
                ]
                
                for (dx, dy) in directions {
                    let newPosition = CGPoint(x: fire.position.x + dx, y: fire.position.y + dy)
                    
                    // Check if position is valid
                    if isValidPosition(newPosition, walls: walls, existingFires: allFires) {
                        let newFire = FireHazard(position: newPosition, intensity: .small)
                        allFires.append(newFire)
                    }
                }
            }
        }
        
        // Upgrade fire intensities over time
        return allFires.map { fire in
            let upgradeChance = Double(timeElapsed) / 100.0
            if Double.random(in: 0...1) < upgradeChance {
                switch fire.intensity {
                case .small:
                    return FireHazard(position: fire.position, intensity: .medium)
                case .medium:
                    return FireHazard(position: fire.position, intensity: .large)
                case .large:
                    return fire
                }
            }
            return fire
        }
    }
    
    // MARK: - Smoke Generation
    static func generateSmoke(from fires: [FireHazard]) -> [SmokeZone] {
        var smokeZones: [SmokeZone] = []
        
        for fire in fires {
            let smokeRadius: CGFloat = fire.spreadRadius * 2.5
            let density: SmokeZone.SmokeDensity = {
                switch fire.intensity {
                case .small: return .light
                case .medium: return .medium
                case .large: return .heavy
                }
            }()
            
            let smoke = SmokeZone(center: fire.position, radius: smokeRadius, density: density)
            smokeZones.append(smoke)
        }
        
        return smokeZones
    }
    
    // MARK: - Helper Methods
    static func isInFire(_ point: CGPoint, fires: [FireHazard]) -> Bool {
        fires.contains { fire in
            let dx = point.x - fire.position.x
            let dy = point.y - fire.position.y
            return sqrt(dx * dx + dy * dy) < fire.spreadRadius
        }
    }
    
    static func isInHeavySmoke(_ point: CGPoint, smokeZones: [SmokeZone]) -> Bool {
        smokeZones.contains { smoke in
            let dx = point.x - smoke.center.x
            let dy = point.y - smoke.center.y
            let dist = sqrt(dx * dx + dy * dy)
            return smoke.density == .heavy && dist < smoke.radius
        }
    }
    
    // MARK: - Private Helpers
    private static func spreadProbability(for intensity: FireHazard.FireIntensity, timeElapsed: Int) -> Double {
        let baseProb: Double = {
            switch intensity {
            case .small: return 0.3
            case .medium: return 0.5
            case .large: return 0.7
            }
        }()
        
        return min(baseProb + Double(timeElapsed) / 100.0, 0.9)
    }
    
    private static func isValidPosition(_ position: CGPoint, walls: [Wall], existingFires: [FireHazard]) -> Bool {
        // Check bounds
        guard position.x >= 20 && position.x <= 300 &&
              position.y >= 20 && position.y <= 300 else {
            return false
        }
        
        // Check if fire already exists nearby
        for fire in existingFires {
            let dx = position.x - fire.position.x
            let dy = position.y - fire.position.y
            if sqrt(dx * dx + dy * dy) < 10 {
                return false
            }
        }
        
        return true
    }
}
