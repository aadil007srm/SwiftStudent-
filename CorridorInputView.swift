import SwiftUI
import EvacuationEngine

/// A gesture-driven route input view that constrains drawn paths to corridor areas.
///
/// As the user drags, each raw gesture point is converted to map coordinates and
/// snapped to the nearest hallway rect via `CorridorSnapper`. Points are only
/// appended when they advance at least `minAdvance` map units from the previous
/// accepted point, reducing input noise. `EvacuationGameState.drawnRoute` is
/// updated incrementally so the Validate Route button reflects live progress.
struct CorridorInputView: View {
    @ObservedObject var evacuationGame: EvacuationGameState
    /// Converts a screen-space point to map coordinates (320×320 space).
    var toMapCoords: (CGPoint) -> CGPoint
    /// Converts a map-space point back to screen coordinates for rendering.
    var toScreenCoords: (CGPoint) -> CGPoint

    /// Screen-space points mirroring the snapped map route, used for rendering only.
    @State private var screenPath: [CGPoint] = []

    /// Minimum map-space advance (in map units) required before a new point is accepted.
    private let minAdvance: CGFloat = 3.0

    var body: some View {
        Canvas { context, _ in
            guard !screenPath.isEmpty else { return }

            // Draw route line
            var pathBuilder = Path()
            pathBuilder.move(to: screenPath[0])
            for point in screenPath.dropFirst() {
                pathBuilder.addLine(to: point)
            }
            context.stroke(pathBuilder, with: .color(.pathBlue), lineWidth: 4)

            // Start marker
            let first = screenPath[0]
            context.fill(
                Circle().path(in: CGRect(x: first.x - 6, y: first.y - 6, width: 12, height: 12)),
                with: .color(.blue)
            )

            // End marker
            if screenPath.count > 1, let last = screenPath.last {
                context.fill(
                    Circle().path(in: CGRect(x: last.x - 5, y: last.y - 5, width: 10, height: 10)),
                    with: .color(.blue.opacity(0.8))
                )
            }
        }
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { value in
                    guard evacuationGame.gamePhase == .planning else { return }

                    let rawMap     = toMapCoords(value.location)
                    let snappedMap = CorridorSnapper.snap(
                        point: rawMap,
                        hallways: evacuationGame.selectedMap.hallways
                    )

                    // Minimum-advance filter (map coordinates)
                    if let lastMap = evacuationGame.drawnRoute.last {
                        let dx = snappedMap.x - lastMap.x
                        let dy = snappedMap.y - lastMap.y
                        guard sqrt(dx * dx + dy * dy) >= minAdvance else { return }
                    }

                    evacuationGame.drawnRoute.append(snappedMap)
                    screenPath.append(toScreenCoords(snappedMap))
                    HapticManager.shared.impact()
                }
        )
        .onReceive(evacuationGame.$drawnRoute) { route in
            // Keep screenPath in sync when drawnRoute is cleared externally
            // (e.g. startGame resets the state).
            if route.isEmpty {
                screenPath = []
            }
        }
    }
}
