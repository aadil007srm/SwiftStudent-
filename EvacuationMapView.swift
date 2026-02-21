import SwiftUI
import EvacuationEngine

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
        VStack(spacing: 4) {
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

            // Feature 2: Extinguisher status row
            if evacuationGame.hasExtinguisher || evacuationGame.extinguishers.contains(where: { !$0.isPickedUp }) {
                HStack(spacing: 8) {
                    Image(systemName: "flame.slash.fill")
                        .foregroundColor(evacuationGame.hasExtinguisher ? .blue : .gray)
                    if evacuationGame.hasExtinguisher {
                        Text("Extinguisher: \(evacuationGame.extinguisherCharge) use\(evacuationGame.extinguisherCharge == 1 ? "" : "s") left")
                            .font(.caption.bold())
                            .foregroundColor(.blue)
                        ForEach(0..<3, id: \.self) { i in
                            Circle()
                                .fill(i < evacuationGame.extinguisherCharge ? Color.blue : Color.gray.opacity(0.3))
                                .frame(width: 8, height: 8)
                        }
                    } else {
                        Text("Extinguisher available – route near it to pick up")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    Spacer()

                    // Feature 4: Heavy smoke warning
                    if evacuationGame.inHeavySmoke {
                        HStack(spacing: 4) {
                            Image(systemName: "smoke.fill")
                                .foregroundColor(.gray)
                            Text("Heavy smoke – slowing down")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .padding(.horizontal)
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
                floorPlanView(geo: geo)

                // Feature 4: Smoke zones with density-based opacity
                ForEach(evacuationGame.smokeZones) { smoke in
                    let opacity: Double = smoke.density == .heavy ? 0.55
                                       : smoke.density == .medium ? 0.35 : 0.18
                    Circle()
                        .fill(Color.gray.opacity(opacity))
                        .frame(width: smoke.radius * 2 * geo.size.width / 320,
                               height: smoke.radius * 2 * geo.size.height / 320)
                        .position(scaledPoint(smoke.center, in: geo.size))
                }

                // Fire hazards
                ForEach(evacuationGame.fireLocations) { fire in
                    FireMarker(intensity: fire.intensity, isSuppressed: fire.isSuppressed)
                        .position(scaledPoint(fire.position, in: geo.size))
                }

                // Exit doors
                ForEach(evacuationGame.exitDoors) { exit in
                    ExitDoorMarker(status: exit.status)
                        .position(scaledPoint(exit.position, in: geo.size))
                }

                // Feature 2: Extinguisher markers (only unpicked)
                ForEach(evacuationGame.extinguishers.filter { !$0.isPickedUp }) { ext in
                    ExtinguisherMarker()
                        .position(scaledPoint(ext.position, in: geo.size))
                }

                // Trapped people (unrescued)
                ForEach(evacuationGame.trappedPeople.filter { !$0.isRescued }) { person in
                    PersonMarker()
                        .position(scaledPoint(person.position, in: geo.size))
                }

                // Feature 3: Followers trailing the player
                ForEach(evacuationGame.followers) { follower in
                    FollowerMarker()
                        .position(scaledPoint(follower.position, in: geo.size))
                }

                // Player position
                Image(systemName: "figure.walk")
                    .font(.title2)
                    .foregroundColor(.blue)
                    .position(scaledPoint(evacuationGame.playerPosition, in: geo.size))

                // Drawn path
                DrawingCanvasView(
                    path: $drawnPath,
                    evacuationGame: evacuationGame,
                    toMapCoords: { screenPoint in
                        CGPoint(
                            x: screenPoint.x * 320 / geo.size.width,
                            y: screenPoint.y * 320 / geo.size.height
                        )
                    }
                )
            }
        }
    }

    // MARK: - Floor Plan
    private func floorPlanView(geo: GeometryProxy) -> some View {
        ZStack {
            Color.evacuationBackground

            // Draw rooms
            ForEach(evacuationGame.selectedMap.rooms.indices, id: \.self) { idx in
                let room = evacuationGame.selectedMap.rooms[idx]
                let scaledFrame = CGRect(
                    x: room.frame.minX * geo.size.width / 320,
                    y: room.frame.minY * geo.size.height / 320,
                    width: room.frame.width * geo.size.width / 320,
                    height: room.frame.height * geo.size.height / 320
                )
                ZStack {
                    Rectangle()
                        .fill(Color.gray.opacity(0.1))
                    Text(room.name)
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
                .frame(width: scaledFrame.width, height: scaledFrame.height)
                .position(x: scaledFrame.midX, y: scaledFrame.midY)
            }

            // Draw hallways
            ForEach(evacuationGame.selectedMap.hallways.indices, id: \.self) { idx in
                let hall = evacuationGame.selectedMap.hallways[idx]
                let scaledFrame = CGRect(
                    x: hall.frame.minX * geo.size.width / 320,
                    y: hall.frame.minY * geo.size.height / 320,
                    width: hall.frame.width * geo.size.width / 320,
                    height: hall.frame.height * geo.size.height / 320
                )
                Rectangle()
                    .fill(Color.gray.opacity(0.05))
                    .frame(width: scaledFrame.width, height: scaledFrame.height)
                    .position(x: scaledFrame.midX, y: scaledFrame.midY)
            }

            // Draw walls
            Canvas { context, _ in
                for wall in evacuationGame.selectedMap.walls {
                    let s = scaledPoint(wall.start, in: geo.size)
                    let e = scaledPoint(wall.end, in: geo.size)
                    var p = Path()
                    p.move(to: s)
                    p.addLine(to: e)
                    context.stroke(p, with: .color(.wallColor), lineWidth: 3)
                }
            }
        }
    }

    // MARK: - Controls
    private var controlsView: some View {
        HStack(spacing: 12) {
            Button {
                // Re-validate using stored map-space route
                if !evacuationGame.drawnRoute.isEmpty {
                    evacuationGame.validateRoute(evacuationGame.drawnRoute)
                }
            } label: {
                Text("Validate Route")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(12)
            }
            .disabled(drawnPath.isEmpty || evacuationGame.gamePhase == .executing)

            Button {
                evacuationGame.startExecution()
            } label: {
                HStack {
                    if evacuationGame.gamePhase == .executing {
                        ProgressView()
                            .tint(.white)
                            .scaleEffect(0.8)
                    }
                    Text(evacuationGame.gamePhase == .executing ? "Evacuating…" : "Evacuate!")
                }
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(evacuationGame.gamePhase == .executing ? Color.gray : Color.green)
                .cornerRadius(12)
            }
            .disabled(drawnPath.isEmpty || evacuationGame.gamePhase == .executing)
        }
        .padding()
    }

    // MARK: - Helper Functions
    private func scaledPoint(_ point: CGPoint, in size: CGSize) -> CGPoint {
        CGPoint(
            x: point.x * size.width / 320,
            y: point.y * size.height / 320
        )
    }
}

// MARK: - Fire Marker
struct FireMarker: View {
    let intensity: FireHazard.FireIntensity
    var isSuppressed: Bool = false

    var body: some View {
        Image(systemName: isSuppressed ? "smoke.fill" : "flame.fill")
            .font(intensity == .small ? .body : intensity == .medium ? .title : .largeTitle)
            .foregroundColor(isSuppressed ? .gray : .red)
            .opacity(isSuppressed ? 0.5 : 1.0)
    }
}

// MARK: - Exit Door Marker
struct ExitDoorMarker: View {
    let status: ExitDoor.DoorStatus

    var body: some View {
        Image(systemName: "door.left.hand.open")
            .font(.title2)
            .foregroundColor(status == .safe ? .green : status == .risky ? .yellow : .red)
    }
}

// MARK: - Person Marker
struct PersonMarker: View {
    var body: some View {
        Image(systemName: "person.fill")
            .font(.title3)
            .foregroundColor(.orange)
    }
}

// MARK: - Follower Marker (Feature 3)
struct FollowerMarker: View {
    var body: some View {
        Image(systemName: "person.fill.checkmark")
            .font(.title3)
            .foregroundColor(.green)
    }
}

// MARK: - Extinguisher Marker (Feature 2)
struct ExtinguisherMarker: View {
    var body: some View {
        Image(systemName: "flame.slash.fill")
            .font(.title3)
            .foregroundColor(.blue)
    }
}
