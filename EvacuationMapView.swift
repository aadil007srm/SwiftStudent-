import SwiftUI

struct EvacuationMapView: View {
    @ObservedObject var gameState: GameState
    @StateObject private var evacuationGame = EvacuationGameState()
    @State private var drawnPath: [CGPoint] = []
    @State private var showTutorial = true

    var body: some View {
        NavigationStack {
            ZStack {
                Color.evacuationBackground.ignoresSafeArea()

                if evacuationGame.gamePhase == .completed {
                    EvacuationResultsView(evacuationGame: evacuationGame, gameState: gameState)
                } else {
                    VStack(spacing: 0) {
                        headerView
                        mapCanvasView
                        controlsView
                    }
                }

                if showTutorial {
                    EvacuationTutorialView(isShowing: $showTutorial)
                }
            }
            .navigationTitle("Evacuation Map")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        gameState.currentScreen = .home
                    } label: {
                        Image(systemName: "chevron.left")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        ForEach(EnvironmentType.allCases) { env in
                            Menu(env.rawValue) {
                                let maps = MapDataProvider.getMaps(for: env)
                                ForEach(maps.indices, id: \.self) { idx in
                                    Button(maps[idx].name) {
                                        evacuationGame.startGame(with: maps[idx])
                                        drawnPath = []
                                    }
                                }
                            }
                        }
                    } label: {
                        Image(systemName: "map")
                    }
                }
            }
        }
        .onAppear {
            evacuationGame.startGame()
        }
    }

    // MARK: - Header
    private var headerView: some View {
        HStack(spacing: 16) {
            // Timer
            HStack(spacing: 6) {
                Image(systemName: "timer")
                    .foregroundColor(evacuationGame.timerColor)
                Text("\(evacuationGame.timeRemaining)s")
                    .font(.title3.bold())
                    .foregroundColor(evacuationGame.timerColor)
                    .monospacedDigit()
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(evacuationGame.timerColor.opacity(0.12))
            .cornerRadius(10)

            Spacer()

            // Rescued people
            HStack(spacing: 4) {
                Image(systemName: "person.2.fill")
                    .foregroundColor(.green)
                Text("\(evacuationGame.rescuedPeople.count)/\(evacuationGame.trappedPeople.count)")
                    .font(.subheadline.bold())
            }

            // Safety score
            HStack(spacing: 4) {
                Image(systemName: "shield.fill")
                    .foregroundColor(.purple)
                Text("\(evacuationGame.routeSafetyScore)%")
                    .font(.subheadline.bold())
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(Color(.secondarySystemBackground))
    }

    // MARK: - Map Canvas
    private var mapCanvasView: some View {
        GeometryReader { geo in
            ZStack {
                // Floor plan background
                floorPlanView

                // Fire hazards
                ForEach(evacuationGame.fireLocations) { fire in
                    FireMarker(intensity: fire.intensity)
                        .position(scaledPoint(fire.position, in: geo.size))
                }

                // Smoke zones
                ForEach(evacuationGame.smokeZones) { smoke in
                    Circle()
                        .fill(Color.smokeGray.opacity(smoke.density.opacity))
                        .frame(width: scaled(smoke.radius * 2, in: geo.size),
                               height: scaled(smoke.radius * 2, in: geo.size))
                        .position(scaledPoint(smoke.center, in: geo.size))
                        .allowsHitTesting(false)
                }

                // Exit doors
                ForEach(evacuationGame.exitDoors) { door in
                    DoorMarker(status: door.status)
                        .position(scaledPoint(door.position, in: geo.size))
                }

                // Extinguishers
                ForEach(evacuationGame.extinguishers) { ext in
                    Image(systemName: ext.isUsed ? "checkmark.circle.fill" : "fireworks")
                        .font(.title2)
                        .foregroundColor(ext.isUsed ? .gray : .red)
                        .position(scaledPoint(ext.position, in: geo.size))
                }

                // Trapped people
                ForEach(evacuationGame.trappedPeople) { person in
                    if !evacuationGame.rescuedPeople.contains(where: { $0.id == person.id }) {
                        Image(systemName: "person.fill.questionmark")
                            .font(.title2)
                            .foregroundColor(.orange)
                            .position(scaledPoint(person.position, in: geo.size))
                    }
                }

                // Rescued people (check marks)
                ForEach(evacuationGame.rescuedPeople) { person in
                    Image(systemName: "person.fill.checkmark")
                        .font(.title2)
                        .foregroundColor(.green)
                        .position(scaledPoint(person.position, in: geo.size))
                }

                // Player start position
                Image(systemName: "figure.walk")
                    .font(.title2)
                    .foregroundColor(.safe60Info)
                    .position(scaledPoint(evacuationGame.playerPosition, in: geo.size))

                // Drawing canvas (on top)
                if evacuationGame.gamePhase == .planning {
                    ScaledDrawingCanvasView(
                        path: $drawnPath,
                        evacuationGame: evacuationGame,
                        mapSize: geo.size
                    )
                }
            }
        }
        .background(Color.hallwayColor)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
    }

    // MARK: - Floor Plan
    private var floorPlanView: some View {
        GeometryReader { geo in
            ZStack(alignment: .topLeading) {
                // Draw rooms
                ForEach(evacuationGame.selectedMap.rooms.indices, id: \.self) { idx in
                    let room = evacuationGame.selectedMap.rooms[idx]
                    let scaled = scaleRect(room.frame, in: geo.size)
                    Rectangle()
                        .fill(roomColor(room.type))
                        .frame(width: scaled.width, height: scaled.height)
                        .overlay(RoundedRectangle(cornerRadius: 2).stroke(Color.wallColor, lineWidth: 1.5))
                        .position(x: scaled.midX, y: scaled.midY)
                }
                // Draw hallways
                ForEach(evacuationGame.selectedMap.hallways.indices, id: \.self) { idx in
                    let hallway = evacuationGame.selectedMap.hallways[idx]
                    let scaled = scaleRect(hallway.frame, in: geo.size)
                    Rectangle()
                        .fill(Color.hallwayColor)
                        .frame(width: scaled.width, height: scaled.height)
                        .position(x: scaled.midX, y: scaled.midY)
                }
            }
        }
    }

    // MARK: - Controls
    private var controlsView: some View {
        HStack(spacing: 16) {
            // Clear route
            Button {
                drawnPath = []
                evacuationGame.validateAndScoreRoute([])
            } label: {
                HStack {
                    Image(systemName: "xmark.circle.fill")
                    Text("Clear")
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(Color(.secondarySystemBackground))
                .foregroundColor(.primary)
                .cornerRadius(12)
            }

            // Confirm evacuation
            Button {
                evacuationGame.finishEvacuation()
            } label: {
                HStack {
                    Image(systemName: "checkmark.circle.fill")
                    Text("Evacuate!")
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(Color.safe60Red)
                .foregroundColor(.white)
                .cornerRadius(12)
            }
            .disabled(drawnPath.count < 2)
            .opacity(drawnPath.count < 2 ? 0.5 : 1)
        }
        .padding()
        .background(Color(.secondarySystemBackground))
    }

    // MARK: - Scaling helpers (map coords → screen)
    private let mapReferenceSize = CGSize(width: 320, height: 320)

    private func scaledPoint(_ point: CGPoint, in size: CGSize) -> CGPoint {
        CGPoint(
            x: point.x * size.width / mapReferenceSize.width,
            y: point.y * size.height / mapReferenceSize.height
        )
    }

    private func scaleRect(_ rect: CGRect, in size: CGSize) -> CGRect {
        CGRect(
            x: rect.origin.x * size.width / mapReferenceSize.width,
            y: rect.origin.y * size.height / mapReferenceSize.height,
            width: rect.width * size.width / mapReferenceSize.width,
            height: rect.height * size.height / mapReferenceSize.height
        )
    }

    private func scaled(_ value: CGFloat, in size: CGSize) -> CGFloat {
        value * min(size.width, size.height) / min(mapReferenceSize.width, mapReferenceSize.height)
    }

    private func roomColor(_ type: RoomType) -> Color {
        switch type {
        case .lab:        return Color.labPurple.opacity(0.15)
        case .office:     return Color.officeBlue.opacity(0.15)
        case .kitchen:    return Color.kitchenRed.opacity(0.15)
        case .factory:    return Color.factoryOrange.opacity(0.15)
        case .storage:    return Color.gray.opacity(0.12)
        case .conference: return Color.safe60Info.opacity(0.12)
        }
    }
}

// MARK: - Scaled Drawing Canvas
/// Wraps DrawingCanvasView to translate between screen and map coordinates.
private struct ScaledDrawingCanvasView: View {
    @Binding var path: [CGPoint]
    @ObservedObject var evacuationGame: EvacuationGameState
    let mapSize: CGSize

    private let mapReferenceSize = CGSize(width: 320, height: 320)

    var body: some View {
        DrawingCanvasView(
            path: $path,
            evacuationGame: evacuationGame,
            toMapCoords: { screenPoint in
                CGPoint(
                    x: screenPoint.x * mapReferenceSize.width / mapSize.width,
                    y: screenPoint.y * mapReferenceSize.height / mapSize.height
                )
            }
        )
        .frame(width: mapSize.width, height: mapSize.height)
    }
}

// MARK: - Fire Marker
private struct FireMarker: View {
    let intensity: FireHazard.FireIntensity
    @State private var animating = false

    var body: some View {
        Image(systemName: "flame.fill")
            .font(.system(size: fontSize))
            .foregroundStyle(
                LinearGradient(colors: [.fireRed, .safe60Orange], startPoint: .top, endPoint: .bottom)
            )
            .scaleEffect(animating ? 1.15 : 0.9)
            .animation(.easeInOut(duration: 0.7).repeatForever(autoreverses: true), value: animating)
            .onAppear { animating = true }
    }

    private var fontSize: CGFloat {
        switch intensity {
        case .small:  return 18
        case .medium: return 24
        case .large:  return 32
        }
    }
}

// MARK: - Door Marker
private struct DoorMarker: View {
    let status: ExitDoor.DoorStatus

    private var statusColor: Color {
        switch status {
        case .safe:    return .exitGreen
        case .risky:   return .exitYellow
        case .blocked: return .exitRed
        }
    }

    var body: some View {
        VStack(spacing: 2) {
            Image(systemName: "door.left.hand.open")
                .font(.title2)
                .foregroundColor(statusColor)
            Text("EXIT")
                .font(.system(size: 8, weight: .bold))
                .foregroundColor(statusColor)
        }
    }
}

#Preview {
    EvacuationMapView(gameState: GameState())
}
