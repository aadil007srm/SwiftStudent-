import XCTest
import Foundation
@testable import EvacuationEngine

// MARK: - Wall Collision Detector Tests

final class WallCollisionDetectorTests: XCTestCase {

    // MARK: Non-intersecting segments

    func testParallelHorizontalSegments() {
        // Two horizontal lines at different y – should not intersect
        let p1 = CGPoint(x: 0, y: 0); let p2 = CGPoint(x: 100, y: 0)
        let p3 = CGPoint(x: 0, y: 50); let p4 = CGPoint(x: 100, y: 50)
        XCTAssertFalse(WallCollisionDetector.segmentsIntersect(p1, p2, p3, p4))
    }

    func testParallelVerticalSegments() {
        let p1 = CGPoint(x: 0, y: 0); let p2 = CGPoint(x: 0, y: 100)
        let p3 = CGPoint(x: 50, y: 0); let p4 = CGPoint(x: 50, y: 100)
        XCTAssertFalse(WallCollisionDetector.segmentsIntersect(p1, p2, p3, p4))
    }

    func testCollinearNonOverlapping() {
        // Same line but non-touching
        let p1 = CGPoint(x: 0, y: 0); let p2 = CGPoint(x: 40, y: 0)
        let p3 = CGPoint(x: 60, y: 0); let p4 = CGPoint(x: 100, y: 0)
        XCTAssertFalse(WallCollisionDetector.segmentsIntersect(p1, p2, p3, p4))
    }

    func testTShapeNoIntersection() {
        // T-shape: horizontal segment ends just before vertical one starts
        let p1 = CGPoint(x: 0, y: 50); let p2 = CGPoint(x: 40, y: 50)
        let p3 = CGPoint(x: 50, y: 0); let p4 = CGPoint(x: 50, y: 100)
        XCTAssertFalse(WallCollisionDetector.segmentsIntersect(p1, p2, p3, p4))
    }

    // MARK: Intersecting segments

    func testXShapeIntersection() {
        // Classic X crossing
        let p1 = CGPoint(x: 0, y: 0); let p2 = CGPoint(x: 100, y: 100)
        let p3 = CGPoint(x: 100, y: 0); let p4 = CGPoint(x: 0, y: 100)
        XCTAssertTrue(WallCollisionDetector.segmentsIntersect(p1, p2, p3, p4))
    }

    func testOrthogonalCross() {
        // Horizontal crosses vertical in the middle
        let p1 = CGPoint(x: 0, y: 50); let p2 = CGPoint(x: 100, y: 50)
        let p3 = CGPoint(x: 50, y: 0); let p4 = CGPoint(x: 50, y: 100)
        XCTAssertTrue(WallCollisionDetector.segmentsIntersect(p1, p2, p3, p4))
    }

    func testDiagonalCross() {
        let p1 = CGPoint(x: 0, y: 0); let p2 = CGPoint(x: 100, y: 50)
        let p3 = CGPoint(x: 100, y: 0); let p4 = CGPoint(x: 0, y: 50)
        XCTAssertTrue(WallCollisionDetector.segmentsIntersect(p1, p2, p3, p4))
    }

    // MARK: Shared endpoint / collinear overlap

    func testSharedEndpoint() {
        // Segments share exactly one endpoint – counts as intersection
        let p1 = CGPoint(x: 0, y: 0); let p2 = CGPoint(x: 50, y: 50)
        let p3 = CGPoint(x: 50, y: 50); let p4 = CGPoint(x: 100, y: 0)
        XCTAssertTrue(WallCollisionDetector.segmentsIntersect(p1, p2, p3, p4))
    }

    func testCollinearOverlapping() {
        // Segments are collinear and overlap
        let p1 = CGPoint(x: 0, y: 0); let p2 = CGPoint(x: 60, y: 0)
        let p3 = CGPoint(x: 40, y: 0); let p4 = CGPoint(x: 100, y: 0)
        XCTAssertTrue(WallCollisionDetector.segmentsIntersect(p1, p2, p3, p4))
    }

    // MARK: segmentCrossesWall

    func testSegmentCrossesWallTrue() {
        let wall = Wall(start: CGPoint(x: 50, y: 0), end: CGPoint(x: 50, y: 100))
        // Route segment crosses the wall horizontally
        XCTAssertTrue(
            WallCollisionDetector.segmentCrossesWall(
                from: CGPoint(x: 0, y: 50),
                to: CGPoint(x: 100, y: 50),
                walls: [wall]
            )
        )
    }

    func testSegmentCrossesWallFalse() {
        let wall = Wall(start: CGPoint(x: 50, y: 0), end: CGPoint(x: 50, y: 40))
        // Route segment passes below the wall – no intersection
        XCTAssertFalse(
            WallCollisionDetector.segmentCrossesWall(
                from: CGPoint(x: 0, y: 50),
                to: CGPoint(x: 100, y: 50),
                walls: [wall]
            )
        )
    }

    func testEmptyWallList() {
        XCTAssertFalse(
            WallCollisionDetector.segmentCrossesWall(
                from: .zero,
                to: CGPoint(x: 100, y: 100),
                walls: []
            )
        )
    }
}

// MARK: - Fire Spread Engine Tests

final class FireSpreadEngineTests: XCTestCase {

    // MARK: Seeded RNG determinism

    func testSeededRNGReproducibility() {
        var rng1 = SeededRNG(seed: 42)
        var rng2 = SeededRNG(seed: 42)
        for _ in 0..<100 {
            XCTAssertEqual(rng1.next(), rng2.next())
        }
    }

    func testSeededRNGDifferentSeeds() {
        var rng1 = SeededRNG(seed: 1)
        var rng2 = SeededRNG(seed: 2)
        // Very unlikely to produce identical output for first value
        XCTAssertNotEqual(rng1.next(), rng2.next())
    }

    // MARK: Deterministic fire spread

    func testDeterministicSpreadSameSeed() {
        let fire = FireHazard(position: CGPoint(x: 160, y: 160), intensity: .large)
        var rng1 = SeededRNG(seed: 999)
        var rng2 = SeededRNG(seed: 999)
        let result1 = FireSpreadEngine.calculateSpread(from: [fire], walls: [], timeElapsed: 30, rng: &rng1)
        let result2 = FireSpreadEngine.calculateSpread(from: [fire], walls: [], timeElapsed: 30, rng: &rng2)
        XCTAssertEqual(result1.count, result2.count)
        for (f1, f2) in zip(result1, result2) {
            XCTAssertEqual(f1.position.x, f2.position.x, accuracy: 0.001)
            XCTAssertEqual(f1.position.y, f2.position.y, accuracy: 0.001)
        }
    }

    func testDeterministicSpreadDifferentSeedProducesDifferentResult() {
        let fire = FireHazard(position: CGPoint(x: 160, y: 160), intensity: .large)
        var rng1 = SeededRNG(seed: 1)
        var rng2 = SeededRNG(seed: 2)
        let result1 = FireSpreadEngine.calculateSpread(from: [fire], walls: [], timeElapsed: 60, rng: &rng1)
        let result2 = FireSpreadEngine.calculateSpread(from: [fire], walls: [], timeElapsed: 60, rng: &rng2)
        // With different seeds the results should not be identical (counts or positions differ).
        // We test at least one of: count differs OR first fire position differs.
        let countsDiffer = result1.count != result2.count
        let positionsDiffer = zip(result1, result2).contains { f1, f2 in
            abs(f1.position.x - f2.position.x) > 0.001 || abs(f1.position.y - f2.position.y) > 0.001
        }
        XCTAssertTrue(countsDiffer || positionsDiffer, "Different seeds should produce different fire spread results")
    }

    // MARK: Suppressed fires do not spread

    func testSuppressedFireDoesNotSpread() {
        let fire = FireHazard(position: CGPoint(x: 160, y: 160), intensity: .large, isSuppressed: true)
        var rng = SeededRNG(seed: 42)
        let result = FireSpreadEngine.calculateSpread(from: [fire], walls: [], timeElapsed: 60, rng: &rng)
        // Only the original (suppressed) fire should remain; no new fires spawned
        XCTAssertEqual(result.count, 1)
        XCTAssertTrue(result[0].isSuppressed)
    }

    // MARK: Smoke generation

    func testSmokeGeneratedForEachFire() {
        let fires = [
            FireHazard(position: CGPoint(x: 50, y: 50), intensity: .small),
            FireHazard(position: CGPoint(x: 200, y: 200), intensity: .large)
        ]
        let smoke = FireSpreadEngine.generateSmoke(from: fires)
        XCTAssertEqual(smoke.count, 2)
    }

    func testHeavySmokeForLargeFire() {
        let fire = FireHazard(position: CGPoint(x: 160, y: 160), intensity: .large)
        let smoke = FireSpreadEngine.generateSmoke(from: [fire])
        XCTAssertEqual(smoke.first?.density, .heavy)
    }

    func testLightSmokeForSmallFire() {
        let fire = FireHazard(position: CGPoint(x: 160, y: 160), intensity: .small)
        let smoke = FireSpreadEngine.generateSmoke(from: [fire])
        XCTAssertEqual(smoke.first?.density, .light)
    }

    func testSuppressedFireProducesLightSmoke() {
        let fire = FireHazard(position: CGPoint(x: 160, y: 160), intensity: .large, isSuppressed: true)
        let smoke = FireSpreadEngine.generateSmoke(from: [fire])
        XCTAssertEqual(smoke.first?.density, .light)
    }

    // MARK: Smoke evolution

    func testSmokeExpandsOverTime() {
        let zone = SmokeZone(center: CGPoint(x: 100, y: 100), radius: 30, density: .medium, age: 0)
        let evolved = FireSpreadEngine.evolveSmoke(existing: [zone], fires: [], expansionPerTick: 4)
        XCTAssertEqual(evolved.first?.radius ?? 0, 34, accuracy: 0.001)
        XCTAssertEqual(evolved.first?.age, 1)
    }

    func testSmokeExpiresAfterMaxAge() {
        let zone = SmokeZone(center: CGPoint(x: 100, y: 100), radius: 30, density: .medium, age: 6)
        let evolved = FireSpreadEngine.evolveSmoke(existing: [zone], fires: [])
        XCTAssertTrue(evolved.isEmpty, "Smoke at age 6 should expire after one more tick")
    }

    // MARK: Point-in-smoke / fire helpers

    func testIsInFireTrue() {
        let fire = FireHazard(position: CGPoint(x: 100, y: 100), intensity: .large) // spreadRadius=35
        XCTAssertTrue(FireSpreadEngine.isInFire(CGPoint(x: 110, y: 100), fires: [fire]))
    }

    func testIsInFireFalseWhenSuppressed() {
        let fire = FireHazard(position: CGPoint(x: 100, y: 100), intensity: .large, isSuppressed: true)
        XCTAssertFalse(FireSpreadEngine.isInFire(CGPoint(x: 110, y: 100), fires: [fire]))
    }

    func testIsInHeavySmoke() {
        let zone = SmokeZone(center: CGPoint(x: 100, y: 100), radius: 40, density: .heavy)
        XCTAssertTrue(FireSpreadEngine.isInHeavySmoke(CGPoint(x: 110, y: 100), smokeZones: [zone]))
        XCTAssertFalse(FireSpreadEngine.isInHeavySmoke(CGPoint(x: 200, y: 200), smokeZones: [zone]))
    }
}
