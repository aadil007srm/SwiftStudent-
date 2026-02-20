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
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: smoke.radius * 2, height: smoke.radius * 2)
                        .position(scaledPoint(smoke.center, in: geo.size))
                }

                // Exit doors
                ForEach(evacuationGame.exitDoors) { exit in
                    ExitDoorMarker(status: exit.status)
                        .position(scaledPoint(exit.position, in: geo.size))
                }

                // Trapped people
                ForEach(evacuationGame.trappedPeople.filter { !$0.isRescued }) { person in
                    PersonMarker()
                        .position(scaledPoint(person.position, in: geo.size))
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
    private var floorPlanView: some View {
        ZStack {
            Color.evacuationBackground
            
            // Draw rooms
            ForEach(evacuationGame.selectedMap.rooms.indices, id: \.self) { idx in
                let room = evacuationGame.selectedMap.rooms[idx]
                Rectangle()
                    .fill(Color.gray.opacity(0.1))
                    .frame(width: room.frame.width, height: room.frame.height)
                    .position(x: room.frame.midX, y: room.frame.midY)
                    .overlay(
                        Text(room.name)
                            .font(.caption2)
                            .foregroundColor(.secondary)
                            .position(x: room.frame.midX, y: room.frame.midY)
                    )
            }
            
            // Draw hallways
            ForEach(evacuationGame.selectedMap.hallways.indices, id: \.self) { idx in
                let hall = evacuationGame.selectedMap.hallways[idx]
                Rectangle()
                    .fill(Color.gray.opacity(0.05))
                    .frame(width: hall.frame.width, height: hall.frame.height)
                    .position(x: hall.frame.midX, y: hall.frame.midY)
            }
        }
    }

    // MARK: - Controls
    private var controlsView: some View {
        HStack(spacing: 12) {
            Button {
                evacuationGame.validateRoute(drawnPath)
            } label: {
                Text("Validate Route")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(12)
            }
            .disabled(drawnPath.isEmpty)
            
            Button {
                evacuationGame.completeEvacuation()
            } label: {
                Text("Evacuate!")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(12)
            }
            .disabled(drawnPath.isEmpty)
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
    
    var body: some View {
        Image(systemName: "flame.fill")
            .font(intensity == .small ? .body : intensity == .medium ? .title : .largeTitle)
            .foregroundColor(.red)
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
