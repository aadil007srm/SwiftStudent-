import SwiftUI

/// Renders a drawn path on a canvas and handles drag-to-draw gestures.
/// `toMapCoords` converts a screen-space CGPoint to the map coordinate space
/// so hazard checks work correctly regardless of display size.
struct DrawingCanvasView: View {
    @Binding var path: [CGPoint]
    @ObservedObject var evacuationGame: EvacuationGameState
    /// Converts a screen-space point to map coordinates for hazard validation.
    var toMapCoords: (CGPoint) -> CGPoint = { $0 }

    var body: some View {
        Canvas { context, _ in
            // Draw route path
            if !path.isEmpty {
                var pathBuilder = Path()
                pathBuilder.move(to: path[0])
                for point in path.dropFirst() {
                    pathBuilder.addLine(to: point)
                }
                context.stroke(pathBuilder, with: .color(.pathBlue), lineWidth: 4)
            }

            // Draw start marker
            if let first = path.first {
                context.fill(
                    Circle().path(in: CGRect(x: first.x - 6, y: first.y - 6, width: 12, height: 12)),
                    with: .color(.blue)
                )
            }

            // Draw end marker
            if path.count > 1, let last = path.last {
                context.fill(
                    Circle().path(in: CGRect(x: last.x - 5, y: last.y - 5, width: 10, height: 10)),
                    with: .color(.blue.opacity(0.8))
                )
            }
        }
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { value in
                    let screenPoint = value.location
                    // Throttle: only add if moved enough from last point
                    if let last = path.last {
                        let dx = screenPoint.x - last.x
                        let dy = screenPoint.y - last.y
                        guard sqrt(dx * dx + dy * dy) > 8 else { return }
                    }
                    let mapPoint = toMapCoords(screenPoint)
                    if evacuationGame.canDrawAt(mapPoint) {
                        path.append(screenPoint)
                        HapticManager.shared.impact()
                    } else {
                        HapticManager.shared.error()
                    }
                }
                .onEnded { _ in
                    // Convert screen-space points to map-space for scoring
                    let mapPath = path.map { toMapCoords($0) }
                    evacuationGame.validateAndScoreRoute(mapPath)
                }
        )
    }
}
