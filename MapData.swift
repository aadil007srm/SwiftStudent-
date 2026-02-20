import SwiftUI

struct MapLayout: Identifiable {
    let id = UUID()
    let environment: EnvironmentType
    let name: String
    let rooms: [Room]
    let hallways: [Hallway]
    let walls: [Wall]
    let startPosition: CGPoint
    let exitDoors: [ExitDoor]
    let fireStarts: [CGPoint]
    let trappedPeople: [Person]
    let extinguishers: [EvacuationExtinguisher]
    let difficulty: Difficulty
}

// MARK: - Map Data Provider
class MapDataProvider {
    // MARK: Lab Maps (10)
    static let labMaps: [MapLayout] = [
        MapLayout(
            environment: .lab,
            name: "Chemical Spill Emergency",
            rooms: [
                Room(name: "Lab A", frame: CGRect(x: 20, y: 40, width: 110, height: 90), type: .lab),
                Room(name: "Lab B", frame: CGRect(x: 200, y: 40, width: 110, height: 90), type: .lab),
                Room(name: "Storage", frame: CGRect(x: 20, y: 190, width: 80, height: 70), type: .storage)
            ],
            hallways: [Hallway(frame: CGRect(x: 130, y: 40, width: 70, height: 220))],
            walls: [
                Wall(start: CGPoint(x: 20, y: 40), end: CGPoint(x: 310, y: 40)),
                Wall(start: CGPoint(x: 20, y: 40), end: CGPoint(x: 20, y: 310)),
                Wall(start: CGPoint(x: 310, y: 40), end: CGPoint(x: 310, y: 310))
            ],
            startPosition: CGPoint(x: 70, y: 85),
            exitDoors: [
                ExitDoor(position: CGPoint(x: 100, y: 310), status: .safe),
                ExitDoor(position: CGPoint(x: 280, y: 310), status: .safe)
            ],
            fireStarts: [CGPoint(x: 250, y: 75)],
            trappedPeople: [
                Person(position: CGPoint(x: 225, y: 100)),
                Person(position: CGPoint(x: 50, y: 225))
            ],
            extinguishers: [EvacuationExtinguisher(position: CGPoint(x: 165, y: 160))],
            difficulty: .medium
        ),
        MapLayout(
            environment: .lab,
            name: "Gas Leak Response",
            rooms: [
                Room(name: "Main Lab", frame: CGRect(x: 20, y: 40, width: 280, height: 120), type: .lab),
                Room(name: "Chemical Storage", frame: CGRect(x: 20, y: 200, width: 130, height: 90), type: .storage)
            ],
            hallways: [Hallway(frame: CGRect(x: 160, y: 200, width: 140, height: 90))],
            walls: [
                Wall(start: CGPoint(x: 20, y: 40), end: CGPoint(x: 300, y: 40)),
                Wall(start: CGPoint(x: 20, y: 40), end: CGPoint(x: 20, y: 300)),
                Wall(start: CGPoint(x: 300, y: 40), end: CGPoint(x: 300, y: 300))
            ],
            startPosition: CGPoint(x: 160, y: 100),
            exitDoors: [
                ExitDoor(position: CGPoint(x: 50, y: 300), status: .safe),
                ExitDoor(position: CGPoint(x: 270, y: 300), status: .risky)
            ],
            fireStarts: [CGPoint(x: 60, y: 220), CGPoint(x: 90, y: 240)],
            trappedPeople: [Person(position: CGPoint(x: 240, y: 90))],
            extinguishers: [EvacuationExtinguisher(position: CGPoint(x: 280, y: 220))],
            difficulty: .hard
        ),
        MapLayout(
            environment: .lab,
            name: "Equipment Fire",
            rooms: [
                Room(name: "Research Lab", frame: CGRect(x: 20, y: 20, width: 140, height: 140), type: .lab),
                Room(name: "Server Room", frame: CGRect(x: 200, y: 20, width: 100, height: 100), type: .office),
                Room(name: "Corridor", frame: CGRect(x: 160, y: 20, width: 40, height: 280))
            ],
            hallways: [Hallway(frame: CGRect(x: 20, y: 160, width: 140, height: 140))],
            walls: [
                Wall(start: CGPoint(x: 20, y: 20), end: CGPoint(x: 300, y: 20)),
                Wall(start: CGPoint(x: 20, y: 20), end: CGPoint(x: 20, y: 300)),
                Wall(start: CGPoint(x: 300, y: 20), end: CGPoint(x: 300, y: 300))
            ],
            startPosition: CGPoint(x: 90, y: 90),
            exitDoors: [
                ExitDoor(position: CGPoint(x: 20, y: 300), status: .safe),
                ExitDoor(position: CGPoint(x: 260, y: 300), status: .safe)
            ],
            fireStarts: [CGPoint(x: 240, y: 60)],
            trappedPeople: [Person(position: CGPoint(x: 230, y: 50)), Person(position: CGPoint(x: 80, y: 230))],
            extinguishers: [EvacuationExtinguisher(position: CGPoint(x: 180, y: 150))],
            difficulty: .easy
        ),
        MapLayout(
            environment: .lab,
            name: "Multi-Lab Crisis",
            rooms: [
                Room(name: "Lab 1", frame: CGRect(x: 20, y: 20, width: 100, height: 100), type: .lab),
                Room(name: "Lab 2", frame: CGRect(x: 200, y: 20, width: 100, height: 100), type: .lab),
                Room(name: "Lab 3", frame: CGRect(x: 20, y: 200, width: 100, height: 100), type: .lab),
                Room(name: "Lab 4", frame: CGRect(x: 200, y: 200, width: 100, height: 100), type: .lab)
            ],
            hallways: [Hallway(frame: CGRect(x: 120, y: 20, width: 80, height: 280))],
            walls: [
                Wall(start: CGPoint(x: 20, y: 20), end: CGPoint(x: 300, y: 20)),
                Wall(start: CGPoint(x: 20, y: 20), end: CGPoint(x: 20, y: 300)),
                Wall(start: CGPoint(x: 300, y: 20), end: CGPoint(x: 300, y: 300))
            ],
            startPosition: CGPoint(x: 70, y: 70),
            exitDoors: [
                ExitDoor(position: CGPoint(x: 160, y: 300), status: .safe)
            ],
            fireStarts: [CGPoint(x: 240, y: 60), CGPoint(x: 50, y: 240)],
            trappedPeople: [Person(position: CGPoint(x: 240, y: 240))],
            extinguishers: [EvacuationExtinguisher(position: CGPoint(x: 160, y: 160))],
            difficulty: .hard
        ),
        MapLayout(
            environment: .lab,
            name: "Radiation Alert",
            rooms: [
                Room(name: "Safe Zone", frame: CGRect(x: 20, y: 20, width: 100, height: 260), type: .lab),
                Room(name: "Hot Zone", frame: CGRect(x: 200, y: 20, width: 100, height: 260), type: .lab)
            ],
            hallways: [Hallway(frame: CGRect(x: 120, y: 20, width: 80, height: 260))],
            walls: [
                Wall(start: CGPoint(x: 20, y: 20), end: CGPoint(x: 300, y: 20)),
                Wall(start: CGPoint(x: 20, y: 20), end: CGPoint(x: 20, y: 280)),
                Wall(start: CGPoint(x: 300, y: 20), end: CGPoint(x: 300, y: 280))
            ],
            startPosition: CGPoint(x: 70, y: 150),
            exitDoors: [
                ExitDoor(position: CGPoint(x: 70, y: 280), status: .safe),
                ExitDoor(position: CGPoint(x: 250, y: 280), status: .blocked)
            ],
            fireStarts: [CGPoint(x: 240, y: 100), CGPoint(x: 240, y: 200)],
            trappedPeople: [Person(position: CGPoint(x: 250, y: 150))],
            extinguishers: [EvacuationExtinguisher(position: CGPoint(x: 160, y: 80))],
            difficulty: .medium
        ),
        MapLayout(
            environment: .lab,
            name: "Fume Hood Fire",
            rooms: [
                Room(name: "Main Lab", frame: CGRect(x: 20, y: 20, width: 260, height: 160), type: .lab),
                Room(name: "Prep Room", frame: CGRect(x: 20, y: 200, width: 120, height: 80), type: .storage)
            ],
            hallways: [Hallway(frame: CGRect(x: 150, y: 200, width: 130, height: 80))],
            walls: [
                Wall(start: CGPoint(x: 20, y: 20), end: CGPoint(x: 280, y: 20)),
                Wall(start: CGPoint(x: 20, y: 20), end: CGPoint(x: 20, y: 280)),
                Wall(start: CGPoint(x: 280, y: 20), end: CGPoint(x: 280, y: 280))
            ],
            startPosition: CGPoint(x: 150, y: 100),
            exitDoors: [
                ExitDoor(position: CGPoint(x: 80, y: 280), status: .safe),
                ExitDoor(position: CGPoint(x: 230, y: 280), status: .safe)
            ],
            fireStarts: [CGPoint(x: 50, y: 80)],
            trappedPeople: [Person(position: CGPoint(x: 240, y: 100))],
            extinguishers: [EvacuationExtinguisher(position: CGPoint(x: 150, y: 50))],
            difficulty: .easy
        ),
        MapLayout(
            environment: .lab,
            name: "Electrical Short",
            rooms: [
                Room(name: "Test Lab", frame: CGRect(x: 20, y: 20, width: 130, height: 260), type: .lab),
                Room(name: "Control Room", frame: CGRect(x: 180, y: 20, width: 100, height: 120), type: .office)
            ],
            hallways: [Hallway(frame: CGRect(x: 150, y: 20, width: 30, height: 260))],
            walls: [
                Wall(start: CGPoint(x: 20, y: 20), end: CGPoint(x: 280, y: 20)),
                Wall(start: CGPoint(x: 20, y: 20), end: CGPoint(x: 20, y: 280)),
                Wall(start: CGPoint(x: 280, y: 20), end: CGPoint(x: 280, y: 280))
            ],
            startPosition: CGPoint(x: 75, y: 150),
            exitDoors: [
                ExitDoor(position: CGPoint(x: 75, y: 280), status: .safe),
                ExitDoor(position: CGPoint(x: 230, y: 280), status: .risky)
            ],
            fireStarts: [CGPoint(x: 220, y: 60)],
            trappedPeople: [Person(position: CGPoint(x: 220, y: 100)), Person(position: CGPoint(x: 75, y: 240))],
            extinguishers: [EvacuationExtinguisher(position: CGPoint(x: 165, y: 200))],
            difficulty: .medium
        ),
        MapLayout(
            environment: .lab,
            name: "Explosion Risk",
            rooms: [
                Room(name: "Reaction Lab", frame: CGRect(x: 20, y: 20, width: 260, height: 100), type: .lab),
                Room(name: "Storage A", frame: CGRect(x: 20, y: 160, width: 100, height: 120), type: .storage),
                Room(name: "Storage B", frame: CGRect(x: 180, y: 160, width: 100, height: 120), type: .storage)
            ],
            hallways: [Hallway(frame: CGRect(x: 120, y: 120, width: 60, height: 160))],
            walls: [
                Wall(start: CGPoint(x: 20, y: 20), end: CGPoint(x: 280, y: 20)),
                Wall(start: CGPoint(x: 20, y: 20), end: CGPoint(x: 20, y: 280)),
                Wall(start: CGPoint(x: 280, y: 20), end: CGPoint(x: 280, y: 280))
            ],
            startPosition: CGPoint(x: 150, y: 70),
            exitDoors: [
                ExitDoor(position: CGPoint(x: 70, y: 280), status: .safe),
                ExitDoor(position: CGPoint(x: 230, y: 280), status: .safe)
            ],
            fireStarts: [CGPoint(x: 50, y: 70), CGPoint(x: 240, y: 200)],
            trappedPeople: [Person(position: CGPoint(x: 50, y: 200))],
            extinguishers: [EvacuationExtinguisher(position: CGPoint(x: 150, y: 140))],
            difficulty: .hard
        ),
        MapLayout(
            environment: .lab,
            name: "Freezer Room Breach",
            rooms: [
                Room(name: "Cold Lab", frame: CGRect(x: 20, y: 20, width: 120, height: 120), type: .lab),
                Room(name: "Warm Lab", frame: CGRect(x: 180, y: 20, width: 100, height: 120), type: .lab),
                Room(name: "Airlock", frame: CGRect(x: 140, y: 20, width: 40, height: 260))
            ],
            hallways: [Hallway(frame: CGRect(x: 20, y: 160, width: 120, height: 120))],
            walls: [
                Wall(start: CGPoint(x: 20, y: 20), end: CGPoint(x: 280, y: 20)),
                Wall(start: CGPoint(x: 20, y: 20), end: CGPoint(x: 20, y: 280)),
                Wall(start: CGPoint(x: 280, y: 20), end: CGPoint(x: 280, y: 280))
            ],
            startPosition: CGPoint(x: 80, y: 80),
            exitDoors: [
                ExitDoor(position: CGPoint(x: 80, y: 280), status: .safe),
                ExitDoor(position: CGPoint(x: 240, y: 280), status: .risky)
            ],
            fireStarts: [CGPoint(x: 230, y: 70)],
            trappedPeople: [Person(position: CGPoint(x: 240, y: 100)), Person(position: CGPoint(x: 80, y: 240))],
            extinguishers: [EvacuationExtinguisher(position: CGPoint(x: 160, y: 200))],
            difficulty: .medium
        ),
        MapLayout(
            environment: .lab,
            name: "Mass Evacuation Drill",
            rooms: [
                Room(name: "Main Lab", frame: CGRect(x: 20, y: 20, width: 260, height: 80), type: .lab),
                Room(name: "Side Lab", frame: CGRect(x: 20, y: 140, width: 120, height: 140), type: .lab),
                Room(name: "Office", frame: CGRect(x: 180, y: 140, width: 100, height: 80), type: .office)
            ],
            hallways: [Hallway(frame: CGRect(x: 140, y: 100, width: 40, height: 140))],
            walls: [
                Wall(start: CGPoint(x: 20, y: 20), end: CGPoint(x: 280, y: 20)),
                Wall(start: CGPoint(x: 20, y: 20), end: CGPoint(x: 20, y: 280)),
                Wall(start: CGPoint(x: 280, y: 20), end: CGPoint(x: 280, y: 280))
            ],
            startPosition: CGPoint(x: 150, y: 60),
            exitDoors: [
                ExitDoor(position: CGPoint(x: 80, y: 280), status: .safe),
                ExitDoor(position: CGPoint(x: 230, y: 220), status: .safe)
            ],
            fireStarts: [CGPoint(x: 240, y: 50)],
            trappedPeople: [
                Person(position: CGPoint(x: 60, y: 200)),
                Person(position: CGPoint(x: 60, y: 240)),
                Person(position: CGPoint(x: 220, y: 180))
            ],
            extinguishers: [EvacuationExtinguisher(position: CGPoint(x: 160, y: 160))],
            difficulty: .hard
        )
    ]

    // MARK: Office Maps (10)
    static let officeMaps: [MapLayout] = [
        MapLayout(
            environment: .office,
            name: "Server Room Fire",
            rooms: [
                Room(name: "Open Office", frame: CGRect(x: 20, y: 20, width: 260, height: 120), type: .office),
                Room(name: "Server Room", frame: CGRect(x: 200, y: 180, width: 80, height: 100), type: .storage),
                Room(name: "Meeting Room", frame: CGRect(x: 20, y: 180, width: 140, height: 100), type: .conference)
            ],
            hallways: [Hallway(frame: CGRect(x: 160, y: 140, width: 40, height: 40))],
            walls: [
                Wall(start: CGPoint(x: 20, y: 20), end: CGPoint(x: 280, y: 20)),
                Wall(start: CGPoint(x: 20, y: 20), end: CGPoint(x: 20, y: 280)),
                Wall(start: CGPoint(x: 280, y: 20), end: CGPoint(x: 280, y: 280))
            ],
            startPosition: CGPoint(x: 150, y: 80),
            exitDoors: [
                ExitDoor(position: CGPoint(x: 50, y: 280), status: .safe),
                ExitDoor(position: CGPoint(x: 240, y: 280), status: .risky)
            ],
            fireStarts: [CGPoint(x: 240, y: 220)],
            trappedPeople: [Person(position: CGPoint(x: 80, y: 230))],
            extinguishers: [EvacuationExtinguisher(position: CGPoint(x: 180, y: 150))],
            difficulty: .medium
        ),
        MapLayout(
            environment: .office,
            name: "Kitchen Fire Spread",
            rooms: [
                Room(name: "Break Room", frame: CGRect(x: 20, y: 20, width: 100, height: 100), type: .kitchen),
                Room(name: "Cubicles", frame: CGRect(x: 160, y: 20, width: 120, height: 200), type: .office),
                Room(name: "Conference Room", frame: CGRect(x: 20, y: 160, width: 100, height: 120), type: .conference)
            ],
            hallways: [Hallway(frame: CGRect(x: 120, y: 20, width: 40, height: 260))],
            walls: [
                Wall(start: CGPoint(x: 20, y: 20), end: CGPoint(x: 280, y: 20)),
                Wall(start: CGPoint(x: 20, y: 20), end: CGPoint(x: 20, y: 280)),
                Wall(start: CGPoint(x: 280, y: 20), end: CGPoint(x: 280, y: 280))
            ],
            startPosition: CGPoint(x: 220, y: 100),
            exitDoors: [
                ExitDoor(position: CGPoint(x: 70, y: 280), status: .safe),
                ExitDoor(position: CGPoint(x: 220, y: 280), status: .safe)
            ],
            fireStarts: [CGPoint(x: 60, y: 60)],
            trappedPeople: [Person(position: CGPoint(x: 60, y: 220)), Person(position: CGPoint(x: 220, y: 180))],
            extinguishers: [EvacuationExtinguisher(position: CGPoint(x: 140, y: 140))],
            difficulty: .easy
        ),
        MapLayout(
            environment: .office,
            name: "Electrical Panel Blaze",
            rooms: [
                Room(name: "Lobby", frame: CGRect(x: 20, y: 20, width: 260, height: 80), type: .office),
                Room(name: "Office A", frame: CGRect(x: 20, y: 140, width: 100, height: 140), type: .office),
                Room(name: "Office B", frame: CGRect(x: 180, y: 140, width: 100, height: 140), type: .office)
            ],
            hallways: [Hallway(frame: CGRect(x: 120, y: 100, width: 60, height: 40))],
            walls: [
                Wall(start: CGPoint(x: 20, y: 20), end: CGPoint(x: 280, y: 20)),
                Wall(start: CGPoint(x: 20, y: 20), end: CGPoint(x: 20, y: 280)),
                Wall(start: CGPoint(x: 280, y: 20), end: CGPoint(x: 280, y: 280))
            ],
            startPosition: CGPoint(x: 150, y: 60),
            exitDoors: [
                ExitDoor(position: CGPoint(x: 70, y: 280), status: .safe),
                ExitDoor(position: CGPoint(x: 230, y: 280), status: .safe)
            ],
            fireStarts: [CGPoint(x: 240, y: 60)],
            trappedPeople: [Person(position: CGPoint(x: 230, y: 210)), Person(position: CGPoint(x: 70, y: 210))],
            extinguishers: [EvacuationExtinguisher(position: CGPoint(x: 150, y: 120))],
            difficulty: .medium
        ),
        MapLayout(
            environment: .office,
            name: "Multiple Exit Drill",
            rooms: [
                Room(name: "Main Hall", frame: CGRect(x: 20, y: 80, width: 260, height: 140), type: .office),
                Room(name: "Side Office", frame: CGRect(x: 20, y: 20, width: 100, height: 60), type: .office),
                Room(name: "Storage", frame: CGRect(x: 180, y: 20, width: 100, height: 60), type: .storage)
            ],
            hallways: [],
            walls: [
                Wall(start: CGPoint(x: 20, y: 20), end: CGPoint(x: 280, y: 20)),
                Wall(start: CGPoint(x: 20, y: 20), end: CGPoint(x: 20, y: 300)),
                Wall(start: CGPoint(x: 280, y: 20), end: CGPoint(x: 280, y: 300))
            ],
            startPosition: CGPoint(x: 150, y: 150),
            exitDoors: [
                ExitDoor(position: CGPoint(x: 50, y: 300), status: .safe),
                ExitDoor(position: CGPoint(x: 150, y: 300), status: .risky),
                ExitDoor(position: CGPoint(x: 250, y: 300), status: .safe)
            ],
            fireStarts: [CGPoint(x: 140, y: 120)],
            trappedPeople: [Person(position: CGPoint(x: 50, y: 150))],
            extinguishers: [EvacuationExtinguisher(position: CGPoint(x: 230, y: 150))],
            difficulty: .easy
        ),
        MapLayout(
            environment: .office,
            name: "Blocked Corridor",
            rooms: [
                Room(name: "Office Row A", frame: CGRect(x: 20, y: 20, width: 100, height: 260), type: .office),
                Room(name: "Office Row B", frame: CGRect(x: 180, y: 20, width: 100, height: 260), type: .office)
            ],
            hallways: [Hallway(frame: CGRect(x: 120, y: 20, width: 60, height: 260))],
            walls: [
                Wall(start: CGPoint(x: 20, y: 20), end: CGPoint(x: 280, y: 20)),
                Wall(start: CGPoint(x: 20, y: 20), end: CGPoint(x: 20, y: 280)),
                Wall(start: CGPoint(x: 280, y: 20), end: CGPoint(x: 280, y: 280))
            ],
            startPosition: CGPoint(x: 70, y: 50),
            exitDoors: [
                ExitDoor(position: CGPoint(x: 70, y: 280), status: .safe),
                ExitDoor(position: CGPoint(x: 230, y: 280), status: .blocked)
            ],
            fireStarts: [CGPoint(x: 150, y: 150)],
            trappedPeople: [Person(position: CGPoint(x: 230, y: 200)), Person(position: CGPoint(x: 70, y: 200))],
            extinguishers: [EvacuationExtinguisher(position: CGPoint(x: 150, y: 80))],
            difficulty: .hard
        ),
        MapLayout(
            environment: .office,
            name: "Smoke-Filled Lobby",
            rooms: [
                Room(name: "Lobby", frame: CGRect(x: 20, y: 20, width: 260, height: 80), type: .office),
                Room(name: "Office Wing", frame: CGRect(x: 20, y: 140, width: 260, height: 140), type: .office)
            ],
            hallways: [Hallway(frame: CGRect(x: 130, y: 100, width: 40, height: 40))],
            walls: [
                Wall(start: CGPoint(x: 20, y: 20), end: CGPoint(x: 280, y: 20)),
                Wall(start: CGPoint(x: 20, y: 20), end: CGPoint(x: 20, y: 280)),
                Wall(start: CGPoint(x: 280, y: 20), end: CGPoint(x: 280, y: 280))
            ],
            startPosition: CGPoint(x: 150, y: 210),
            exitDoors: [
                ExitDoor(position: CGPoint(x: 60, y: 280), status: .safe),
                ExitDoor(position: CGPoint(x: 240, y: 280), status: .safe)
            ],
            fireStarts: [CGPoint(x: 150, y: 60)],
            trappedPeople: [Person(position: CGPoint(x: 60, y: 200))],
            extinguishers: [EvacuationExtinguisher(position: CGPoint(x: 240, y: 180))],
            difficulty: .medium
        ),
        MapLayout(
            environment: .office,
            name: "Weekend Fire",
            rooms: [
                Room(name: "Open Space", frame: CGRect(x: 20, y: 20, width: 260, height: 260), type: .office)
            ],
            hallways: [],
            walls: [
                Wall(start: CGPoint(x: 20, y: 20), end: CGPoint(x: 280, y: 20)),
                Wall(start: CGPoint(x: 20, y: 20), end: CGPoint(x: 20, y: 280)),
                Wall(start: CGPoint(x: 280, y: 20), end: CGPoint(x: 280, y: 280))
            ],
            startPosition: CGPoint(x: 150, y: 150),
            exitDoors: [
                ExitDoor(position: CGPoint(x: 50, y: 280), status: .safe),
                ExitDoor(position: CGPoint(x: 250, y: 280), status: .safe)
            ],
            fireStarts: [CGPoint(x: 60, y: 60), CGPoint(x: 230, y: 70)],
            trappedPeople: [Person(position: CGPoint(x: 60, y: 240)), Person(position: CGPoint(x: 230, y: 230))],
            extinguishers: [EvacuationExtinguisher(position: CGPoint(x: 150, y: 80))],
            difficulty: .hard
        ),
        MapLayout(
            environment: .office,
            name: "Copy Room Incident",
            rooms: [
                Room(name: "Main Office", frame: CGRect(x: 20, y: 20, width: 180, height: 260), type: .office),
                Room(name: "Copy Room", frame: CGRect(x: 240, y: 20, width: 60, height: 80), type: .storage),
                Room(name: "Break Room", frame: CGRect(x: 240, y: 160, width: 60, height: 120), type: .kitchen)
            ],
            hallways: [Hallway(frame: CGRect(x: 200, y: 20, width: 40, height: 260))],
            walls: [
                Wall(start: CGPoint(x: 20, y: 20), end: CGPoint(x: 300, y: 20)),
                Wall(start: CGPoint(x: 20, y: 20), end: CGPoint(x: 20, y: 280)),
                Wall(start: CGPoint(x: 300, y: 20), end: CGPoint(x: 300, y: 280))
            ],
            startPosition: CGPoint(x: 100, y: 140),
            exitDoors: [
                ExitDoor(position: CGPoint(x: 100, y: 280), status: .safe),
                ExitDoor(position: CGPoint(x: 260, y: 280), status: .risky)
            ],
            fireStarts: [CGPoint(x: 260, y: 60)],
            trappedPeople: [Person(position: CGPoint(x: 260, y: 200))],
            extinguishers: [EvacuationExtinguisher(position: CGPoint(x: 220, y: 140))],
            difficulty: .easy
        ),
        MapLayout(
            environment: .office,
            name: "Night Shift Emergency",
            rooms: [
                Room(name: "Security Booth", frame: CGRect(x: 20, y: 20, width: 80, height: 80), type: .office),
                Room(name: "Main Floor", frame: CGRect(x: 140, y: 20, width: 140, height: 260), type: .office)
            ],
            hallways: [Hallway(frame: CGRect(x: 100, y: 20, width: 40, height: 260))],
            walls: [
                Wall(start: CGPoint(x: 20, y: 20), end: CGPoint(x: 280, y: 20)),
                Wall(start: CGPoint(x: 20, y: 20), end: CGPoint(x: 20, y: 280)),
                Wall(start: CGPoint(x: 280, y: 20), end: CGPoint(x: 280, y: 280))
            ],
            startPosition: CGPoint(x: 60, y: 60),
            exitDoors: [
                ExitDoor(position: CGPoint(x: 60, y: 280), status: .safe),
                ExitDoor(position: CGPoint(x: 210, y: 280), status: .safe)
            ],
            fireStarts: [CGPoint(x: 210, y: 80)],
            trappedPeople: [Person(position: CGPoint(x: 210, y: 200)), Person(position: CGPoint(x: 210, y: 240))],
            extinguishers: [EvacuationExtinguisher(position: CGPoint(x: 120, y: 150))],
            difficulty: .medium
        ),
        MapLayout(
            environment: .office,
            name: "Stairwell Inferno",
            rooms: [
                Room(name: "Office Floor", frame: CGRect(x: 20, y: 20, width: 200, height: 260), type: .office),
                Room(name: "Stairwell", frame: CGRect(x: 240, y: 20, width: 40, height: 260), type: .storage)
            ],
            hallways: [],
            walls: [
                Wall(start: CGPoint(x: 20, y: 20), end: CGPoint(x: 280, y: 20)),
                Wall(start: CGPoint(x: 20, y: 20), end: CGPoint(x: 20, y: 280)),
                Wall(start: CGPoint(x: 280, y: 20), end: CGPoint(x: 280, y: 280))
            ],
            startPosition: CGPoint(x: 100, y: 50),
            exitDoors: [
                ExitDoor(position: CGPoint(x: 100, y: 280), status: .safe),
                ExitDoor(position: CGPoint(x: 260, y: 280), status: .blocked)
            ],
            fireStarts: [CGPoint(x: 260, y: 80), CGPoint(x: 260, y: 180)],
            trappedPeople: [Person(position: CGPoint(x: 100, y: 240))],
            extinguishers: [EvacuationExtinguisher(position: CGPoint(x: 220, y: 150))],
            difficulty: .hard
        )
    ]

    // MARK: Kitchen Maps (10)
    static let kitchenMaps: [MapLayout] = [
        MapLayout(
            environment: .kitchen,
            name: "Grease Fire",
            rooms: [
                Room(name: "Kitchen", frame: CGRect(x: 20, y: 20, width: 260, height: 140), type: .kitchen),
                Room(name: "Dining Area", frame: CGRect(x: 20, y: 200, width: 260, height: 80), type: .conference)
            ],
            hallways: [Hallway(frame: CGRect(x: 120, y: 160, width: 60, height: 40))],
            walls: [
                Wall(start: CGPoint(x: 20, y: 20), end: CGPoint(x: 280, y: 20)),
                Wall(start: CGPoint(x: 20, y: 20), end: CGPoint(x: 20, y: 280)),
                Wall(start: CGPoint(x: 280, y: 20), end: CGPoint(x: 280, y: 280))
            ],
            startPosition: CGPoint(x: 150, y: 240),
            exitDoors: [
                ExitDoor(position: CGPoint(x: 60, y: 280), status: .safe),
                ExitDoor(position: CGPoint(x: 240, y: 280), status: .safe)
            ],
            fireStarts: [CGPoint(x: 150, y: 80)],
            trappedPeople: [Person(position: CGPoint(x: 60, y: 90)), Person(position: CGPoint(x: 240, y: 90))],
            extinguishers: [EvacuationExtinguisher(position: CGPoint(x: 150, y: 170))],
            difficulty: .medium
        ),
        MapLayout(
            environment: .kitchen,
            name: "Gas Leak Ignition",
            rooms: [
                Room(name: "Prep Area", frame: CGRect(x: 20, y: 20, width: 120, height: 260), type: .kitchen),
                Room(name: "Walk-in Fridge", frame: CGRect(x: 200, y: 20, width: 80, height: 100), type: .storage),
                Room(name: "Dish Area", frame: CGRect(x: 200, y: 160, width: 80, height: 120), type: .kitchen)
            ],
            hallways: [Hallway(frame: CGRect(x: 140, y: 20, width: 60, height: 260))],
            walls: [
                Wall(start: CGPoint(x: 20, y: 20), end: CGPoint(x: 280, y: 20)),
                Wall(start: CGPoint(x: 20, y: 20), end: CGPoint(x: 20, y: 280)),
                Wall(start: CGPoint(x: 280, y: 20), end: CGPoint(x: 280, y: 280))
            ],
            startPosition: CGPoint(x: 70, y: 150),
            exitDoors: [
                ExitDoor(position: CGPoint(x: 70, y: 280), status: .safe),
                ExitDoor(position: CGPoint(x: 240, y: 280), status: .risky)
            ],
            fireStarts: [CGPoint(x: 240, y: 200)],
            trappedPeople: [Person(position: CGPoint(x: 240, y: 70))],
            extinguishers: [EvacuationExtinguisher(position: CGPoint(x: 170, y: 150))],
            difficulty: .hard
        ),
        MapLayout(
            environment: .kitchen,
            name: "Oven Overload",
            rooms: [
                Room(name: "Main Kitchen", frame: CGRect(x: 20, y: 20, width: 260, height: 120), type: .kitchen),
                Room(name: "Pantry", frame: CGRect(x: 20, y: 180, width: 80, height: 100), type: .storage),
                Room(name: "Exit Corridor", frame: CGRect(x: 180, y: 180, width: 100, height: 100), type: .conference)
            ],
            hallways: [Hallway(frame: CGRect(x: 100, y: 140, width: 80, height: 40))],
            walls: [
                Wall(start: CGPoint(x: 20, y: 20), end: CGPoint(x: 280, y: 20)),
                Wall(start: CGPoint(x: 20, y: 20), end: CGPoint(x: 20, y: 280)),
                Wall(start: CGPoint(x: 280, y: 20), end: CGPoint(x: 280, y: 280))
            ],
            startPosition: CGPoint(x: 150, y: 80),
            exitDoors: [
                ExitDoor(position: CGPoint(x: 230, y: 280), status: .safe)
            ],
            fireStarts: [CGPoint(x: 50, y: 80)],
            trappedPeople: [Person(position: CGPoint(x: 50, y: 230))],
            extinguishers: [EvacuationExtinguisher(position: CGPoint(x: 140, y: 160))],
            difficulty: .easy
        ),
        MapLayout(
            environment: .kitchen,
            name: "Deep Fryer Blaze",
            rooms: [
                Room(name: "Fry Station", frame: CGRect(x: 20, y: 20, width: 100, height: 100), type: .kitchen),
                Room(name: "Service Area", frame: CGRect(x: 160, y: 20, width: 120, height: 100), type: .conference),
                Room(name: "Kitchen Floor", frame: CGRect(x: 20, y: 160, width: 260, height: 120), type: .kitchen)
            ],
            hallways: [Hallway(frame: CGRect(x: 120, y: 20, width: 40, height: 260))],
            walls: [
                Wall(start: CGPoint(x: 20, y: 20), end: CGPoint(x: 280, y: 20)),
                Wall(start: CGPoint(x: 20, y: 20), end: CGPoint(x: 20, y: 280)),
                Wall(start: CGPoint(x: 280, y: 20), end: CGPoint(x: 280, y: 280))
            ],
            startPosition: CGPoint(x: 220, y: 60),
            exitDoors: [
                ExitDoor(position: CGPoint(x: 80, y: 280), status: .safe),
                ExitDoor(position: CGPoint(x: 220, y: 280), status: .safe)
            ],
            fireStarts: [CGPoint(x: 60, y: 60)],
            trappedPeople: [Person(position: CGPoint(x: 60, y: 220))],
            extinguishers: [EvacuationExtinguisher(position: CGPoint(x: 140, y: 160))],
            difficulty: .medium
        ),
        MapLayout(
            environment: .kitchen,
            name: "Ventilation Fire",
            rooms: [
                Room(name: "Commercial Kitchen", frame: CGRect(x: 20, y: 20, width: 260, height: 260), type: .kitchen)
            ],
            hallways: [],
            walls: [
                Wall(start: CGPoint(x: 20, y: 20), end: CGPoint(x: 280, y: 20)),
                Wall(start: CGPoint(x: 20, y: 20), end: CGPoint(x: 20, y: 280)),
                Wall(start: CGPoint(x: 280, y: 20), end: CGPoint(x: 280, y: 280))
            ],
            startPosition: CGPoint(x: 150, y: 150),
            exitDoors: [
                ExitDoor(position: CGPoint(x: 50, y: 280), status: .safe),
                ExitDoor(position: CGPoint(x: 250, y: 280), status: .risky)
            ],
            fireStarts: [CGPoint(x: 150, y: 30), CGPoint(x: 50, y: 50)],
            trappedPeople: [Person(position: CGPoint(x: 240, y: 50)), Person(position: CGPoint(x: 240, y: 220))],
            extinguishers: [EvacuationExtinguisher(position: CGPoint(x: 150, y: 150))],
            difficulty: .hard
        ),
        MapLayout(
            environment: .kitchen,
            name: "Multiple Stations Fire",
            rooms: [
                Room(name: "Grill Station", frame: CGRect(x: 20, y: 20, width: 80, height: 120), type: .kitchen),
                Room(name: "Prep Station", frame: CGRect(x: 160, y: 20, width: 120, height: 120), type: .kitchen),
                Room(name: "Back Office", frame: CGRect(x: 20, y: 180, width: 100, height: 100), type: .office)
            ],
            hallways: [Hallway(frame: CGRect(x: 100, y: 20, width: 60, height: 260))],
            walls: [
                Wall(start: CGPoint(x: 20, y: 20), end: CGPoint(x: 280, y: 20)),
                Wall(start: CGPoint(x: 20, y: 20), end: CGPoint(x: 20, y: 280)),
                Wall(start: CGPoint(x: 280, y: 20), end: CGPoint(x: 280, y: 280))
            ],
            startPosition: CGPoint(x: 220, y: 80),
            exitDoors: [
                ExitDoor(position: CGPoint(x: 70, y: 280), status: .safe),
                ExitDoor(position: CGPoint(x: 220, y: 280), status: .safe)
            ],
            fireStarts: [CGPoint(x: 60, y: 80), CGPoint(x: 200, y: 80)],
            trappedPeople: [Person(position: CGPoint(x: 60, y: 230))],
            extinguishers: [EvacuationExtinguisher(position: CGPoint(x: 130, y: 150))],
            difficulty: .hard
        ),
        MapLayout(
            environment: .kitchen,
            name: "Dish Room Incident",
            rooms: [
                Room(name: "Dishwashing Area", frame: CGRect(x: 20, y: 20, width: 100, height: 260), type: .kitchen),
                Room(name: "Storage Shelves", frame: CGRect(x: 180, y: 20, width: 100, height: 260), type: .storage)
            ],
            hallways: [Hallway(frame: CGRect(x: 120, y: 20, width: 60, height: 260))],
            walls: [
                Wall(start: CGPoint(x: 20, y: 20), end: CGPoint(x: 280, y: 20)),
                Wall(start: CGPoint(x: 20, y: 20), end: CGPoint(x: 20, y: 280)),
                Wall(start: CGPoint(x: 280, y: 20), end: CGPoint(x: 280, y: 280))
            ],
            startPosition: CGPoint(x: 70, y: 150),
            exitDoors: [
                ExitDoor(position: CGPoint(x: 70, y: 280), status: .safe),
                ExitDoor(position: CGPoint(x: 230, y: 280), status: .safe)
            ],
            fireStarts: [CGPoint(x: 230, y: 80)],
            trappedPeople: [Person(position: CGPoint(x: 230, y: 220))],
            extinguishers: [EvacuationExtinguisher(position: CGPoint(x: 150, y: 150))],
            difficulty: .easy
        ),
        MapLayout(
            environment: .kitchen,
            name: "Delivery Area Fire",
            rooms: [
                Room(name: "Loading Dock", frame: CGRect(x: 20, y: 200, width: 100, height: 80), type: .storage),
                Room(name: "Main Kitchen", frame: CGRect(x: 20, y: 20, width: 260, height: 140), type: .kitchen)
            ],
            hallways: [Hallway(frame: CGRect(x: 120, y: 160, width: 140, height: 40))],
            walls: [
                Wall(start: CGPoint(x: 20, y: 20), end: CGPoint(x: 280, y: 20)),
                Wall(start: CGPoint(x: 20, y: 20), end: CGPoint(x: 20, y: 280)),
                Wall(start: CGPoint(x: 280, y: 20), end: CGPoint(x: 280, y: 280))
            ],
            startPosition: CGPoint(x: 150, y: 80),
            exitDoors: [
                ExitDoor(position: CGPoint(x: 70, y: 280), status: .safe),
                ExitDoor(position: CGPoint(x: 250, y: 280), status: .safe)
            ],
            fireStarts: [CGPoint(x: 50, y: 120)],
            trappedPeople: [Person(position: CGPoint(x: 60, y: 230)), Person(position: CGPoint(x: 250, y: 90))],
            extinguishers: [EvacuationExtinguisher(position: CGPoint(x: 200, y: 200))],
            difficulty: .medium
        ),
        MapLayout(
            environment: .kitchen,
            name: "Cold Storage Crisis",
            rooms: [
                Room(name: "Cold Room", frame: CGRect(x: 20, y: 20, width: 100, height: 120), type: .storage),
                Room(name: "Hot Kitchen", frame: CGRect(x: 180, y: 20, width: 100, height: 120), type: .kitchen),
                Room(name: "Staff Area", frame: CGRect(x: 20, y: 180, width: 260, height: 100), type: .office)
            ],
            hallways: [Hallway(frame: CGRect(x: 120, y: 20, width: 60, height: 260))],
            walls: [
                Wall(start: CGPoint(x: 20, y: 20), end: CGPoint(x: 280, y: 20)),
                Wall(start: CGPoint(x: 20, y: 20), end: CGPoint(x: 20, y: 280)),
                Wall(start: CGPoint(x: 280, y: 20), end: CGPoint(x: 280, y: 280))
            ],
            startPosition: CGPoint(x: 70, y: 70),
            exitDoors: [
                ExitDoor(position: CGPoint(x: 80, y: 280), status: .safe),
                ExitDoor(position: CGPoint(x: 220, y: 280), status: .safe)
            ],
            fireStarts: [CGPoint(x: 230, y: 70)],
            trappedPeople: [Person(position: CGPoint(x: 230, y: 100)), Person(position: CGPoint(x: 150, y: 230))],
            extinguishers: [EvacuationExtinguisher(position: CGPoint(x: 150, y: 80))],
            difficulty: .medium
        ),
        MapLayout(
            environment: .kitchen,
            name: "Service Rush Fire",
            rooms: [
                Room(name: "Hot Station", frame: CGRect(x: 20, y: 20, width: 120, height: 100), type: .kitchen),
                Room(name: "Cold Station", frame: CGRect(x: 160, y: 20, width: 120, height: 100), type: .kitchen),
                Room(name: "Plating Area", frame: CGRect(x: 20, y: 160, width: 260, height: 120), type: .kitchen)
            ],
            hallways: [Hallway(frame: CGRect(x: 120, y: 120, width: 40, height: 40))],
            walls: [
                Wall(start: CGPoint(x: 20, y: 20), end: CGPoint(x: 280, y: 20)),
                Wall(start: CGPoint(x: 20, y: 20), end: CGPoint(x: 20, y: 280)),
                Wall(start: CGPoint(x: 280, y: 20), end: CGPoint(x: 280, y: 280))
            ],
            startPosition: CGPoint(x: 150, y: 220),
            exitDoors: [
                ExitDoor(position: CGPoint(x: 60, y: 280), status: .safe),
                ExitDoor(position: CGPoint(x: 240, y: 280), status: .safe)
            ],
            fireStarts: [CGPoint(x: 80, y: 60), CGPoint(x: 200, y: 60)],
            trappedPeople: [
                Person(position: CGPoint(x: 80, y: 90)),
                Person(position: CGPoint(x: 200, y: 90)),
                Person(position: CGPoint(x: 80, y: 220))
            ],
            extinguishers: [EvacuationExtinguisher(position: CGPoint(x: 140, y: 140))],
            difficulty: .hard
        )
    ]

    // MARK: Factory Maps (10)
    static let factoryMaps: [MapLayout] = [
        MapLayout(
            environment: .factory,
            name: "Machinery Fire",
            rooms: [
                Room(name: "Production Floor", frame: CGRect(x: 20, y: 20, width: 260, height: 180), type: .factory),
                Room(name: "Control Room", frame: CGRect(x: 20, y: 230, width: 100, height: 70), type: .office)
            ],
            hallways: [Hallway(frame: CGRect(x: 160, y: 200, width: 120, height: 30))],
            walls: [
                Wall(start: CGPoint(x: 20, y: 20), end: CGPoint(x: 280, y: 20)),
                Wall(start: CGPoint(x: 20, y: 20), end: CGPoint(x: 20, y: 300)),
                Wall(start: CGPoint(x: 280, y: 20), end: CGPoint(x: 280, y: 300))
            ],
            startPosition: CGPoint(x: 60, y: 260),
            exitDoors: [
                ExitDoor(position: CGPoint(x: 80, y: 300), status: .safe),
                ExitDoor(position: CGPoint(x: 240, y: 300), status: .safe)
            ],
            fireStarts: [CGPoint(x: 200, y: 100)],
            trappedPeople: [Person(position: CGPoint(x: 200, y: 150)), Person(position: CGPoint(x: 100, y: 100))],
            extinguishers: [EvacuationExtinguisher(position: CGPoint(x: 150, y: 210))],
            difficulty: .medium
        ),
        MapLayout(
            environment: .factory,
            name: "Chemical Storage Blaze",
            rooms: [
                Room(name: "Storage Wing", frame: CGRect(x: 20, y: 20, width: 100, height: 260), type: .storage),
                Room(name: "Assembly Line", frame: CGRect(x: 160, y: 20, width: 120, height: 260), type: .factory)
            ],
            hallways: [Hallway(frame: CGRect(x: 120, y: 20, width: 40, height: 260))],
            walls: [
                Wall(start: CGPoint(x: 20, y: 20), end: CGPoint(x: 280, y: 20)),
                Wall(start: CGPoint(x: 20, y: 20), end: CGPoint(x: 20, y: 280)),
                Wall(start: CGPoint(x: 280, y: 20), end: CGPoint(x: 280, y: 280))
            ],
            startPosition: CGPoint(x: 220, y: 150),
            exitDoors: [
                ExitDoor(position: CGPoint(x: 70, y: 280), status: .safe),
                ExitDoor(position: CGPoint(x: 220, y: 280), status: .risky)
            ],
            fireStarts: [CGPoint(x: 60, y: 80), CGPoint(x: 60, y: 200)],
            trappedPeople: [Person(position: CGPoint(x: 60, y: 140))],
            extinguishers: [EvacuationExtinguisher(position: CGPoint(x: 140, y: 100))],
            difficulty: .hard
        ),
        MapLayout(
            environment: .factory,
            name: "Conveyor Belt Incident",
            rooms: [
                Room(name: "Belt Area A", frame: CGRect(x: 20, y: 20, width: 260, height: 80), type: .factory),
                Room(name: "Belt Area B", frame: CGRect(x: 20, y: 160, width: 260, height: 80), type: .factory),
                Room(name: "Maintenance Bay", frame: CGRect(x: 100, y: 100, width: 100, height: 60), type: .factory)
            ],
            hallways: [],
            walls: [
                Wall(start: CGPoint(x: 20, y: 20), end: CGPoint(x: 280, y: 20)),
                Wall(start: CGPoint(x: 20, y: 20), end: CGPoint(x: 20, y: 300)),
                Wall(start: CGPoint(x: 280, y: 20), end: CGPoint(x: 280, y: 300))
            ],
            startPosition: CGPoint(x: 150, y: 60),
            exitDoors: [
                ExitDoor(position: CGPoint(x: 60, y: 300), status: .safe),
                ExitDoor(position: CGPoint(x: 240, y: 300), status: .safe)
            ],
            fireStarts: [CGPoint(x: 60, y: 180)],
            trappedPeople: [Person(position: CGPoint(x: 150, y: 130)), Person(position: CGPoint(x: 240, y: 200))],
            extinguishers: [EvacuationExtinguisher(position: CGPoint(x: 240, y: 60))],
            difficulty: .medium
        ),
        MapLayout(
            environment: .factory,
            name: "Hydraulic Press Fire",
            rooms: [
                Room(name: "Press Zone", frame: CGRect(x: 20, y: 20, width: 140, height: 260), type: .factory),
                Room(name: "Safety Office", frame: CGRect(x: 200, y: 20, width: 80, height: 80), type: .office),
                Room(name: "Break Room", frame: CGRect(x: 200, y: 160, width: 80, height: 120), type: .kitchen)
            ],
            hallways: [Hallway(frame: CGRect(x: 160, y: 20, width: 40, height: 260))],
            walls: [
                Wall(start: CGPoint(x: 20, y: 20), end: CGPoint(x: 280, y: 20)),
                Wall(start: CGPoint(x: 20, y: 20), end: CGPoint(x: 20, y: 280)),
                Wall(start: CGPoint(x: 280, y: 20), end: CGPoint(x: 280, y: 280))
            ],
            startPosition: CGPoint(x: 80, y: 150),
            exitDoors: [
                ExitDoor(position: CGPoint(x: 80, y: 280), status: .safe),
                ExitDoor(position: CGPoint(x: 240, y: 280), status: .safe)
            ],
            fireStarts: [CGPoint(x: 80, y: 60)],
            trappedPeople: [Person(position: CGPoint(x: 240, y: 220)), Person(position: CGPoint(x: 80, y: 240))],
            extinguishers: [EvacuationExtinguisher(position: CGPoint(x: 180, y: 150))],
            difficulty: .easy
        ),
        MapLayout(
            environment: .factory,
            name: "Welding Arc Incident",
            rooms: [
                Room(name: "Welding Bay", frame: CGRect(x: 20, y: 20, width: 120, height: 120), type: .factory),
                Room(name: "Fab Shop", frame: CGRect(x: 160, y: 20, width: 120, height: 120), type: .factory),
                Room(name: "Common Area", frame: CGRect(x: 20, y: 180, width: 260, height: 100), type: .conference)
            ],
            hallways: [Hallway(frame: CGRect(x: 140, y: 20, width: 20, height: 260))],
            walls: [
                Wall(start: CGPoint(x: 20, y: 20), end: CGPoint(x: 280, y: 20)),
                Wall(start: CGPoint(x: 20, y: 20), end: CGPoint(x: 20, y: 280)),
                Wall(start: CGPoint(x: 280, y: 20), end: CGPoint(x: 280, y: 280))
            ],
            startPosition: CGPoint(x: 80, y: 80),
            exitDoors: [
                ExitDoor(position: CGPoint(x: 80, y: 280), status: .safe),
                ExitDoor(position: CGPoint(x: 220, y: 280), status: .safe)
            ],
            fireStarts: [CGPoint(x: 220, y: 80)],
            trappedPeople: [Person(position: CGPoint(x: 220, y: 110)), Person(position: CGPoint(x: 150, y: 230))],
            extinguishers: [EvacuationExtinguisher(position: CGPoint(x: 150, y: 100))],
            difficulty: .medium
        ),
        MapLayout(
            environment: .factory,
            name: "Paint Booth Explosion",
            rooms: [
                Room(name: "Paint Booth", frame: CGRect(x: 20, y: 20, width: 80, height: 260), type: .factory),
                Room(name: "Spray Zone", frame: CGRect(x: 160, y: 20, width: 120, height: 180), type: .factory),
                Room(name: "Drying Area", frame: CGRect(x: 160, y: 200, width: 120, height: 80), type: .factory)
            ],
            hallways: [Hallway(frame: CGRect(x: 100, y: 20, width: 60, height: 260))],
            walls: [
                Wall(start: CGPoint(x: 20, y: 20), end: CGPoint(x: 280, y: 20)),
                Wall(start: CGPoint(x: 20, y: 20), end: CGPoint(x: 20, y: 280)),
                Wall(start: CGPoint(x: 280, y: 20), end: CGPoint(x: 280, y: 280))
            ],
            startPosition: CGPoint(x: 60, y: 150),
            exitDoors: [
                ExitDoor(position: CGPoint(x: 60, y: 280), status: .safe),
                ExitDoor(position: CGPoint(x: 220, y: 280), status: .risky)
            ],
            fireStarts: [CGPoint(x: 60, y: 60), CGPoint(x: 200, y: 100)],
            trappedPeople: [Person(position: CGPoint(x: 220, y: 240))],
            extinguishers: [EvacuationExtinguisher(position: CGPoint(x: 130, y: 200))],
            difficulty: .hard
        ),
        MapLayout(
            environment: .factory,
            name: "Boiler Room Fire",
            rooms: [
                Room(name: "Boiler Room", frame: CGRect(x: 20, y: 200, width: 120, height: 80), type: .factory),
                Room(name: "Factory Floor", frame: CGRect(x: 20, y: 20, width: 260, height: 140), type: .factory)
            ],
            hallways: [Hallway(frame: CGRect(x: 160, y: 160, width: 120, height: 40))],
            walls: [
                Wall(start: CGPoint(x: 20, y: 20), end: CGPoint(x: 280, y: 20)),
                Wall(start: CGPoint(x: 20, y: 20), end: CGPoint(x: 20, y: 300)),
                Wall(start: CGPoint(x: 280, y: 20), end: CGPoint(x: 280, y: 300))
            ],
            startPosition: CGPoint(x: 220, y: 90),
            exitDoors: [
                ExitDoor(position: CGPoint(x: 80, y: 300), status: .safe),
                ExitDoor(position: CGPoint(x: 240, y: 300), status: .safe)
            ],
            fireStarts: [CGPoint(x: 80, y: 240)],
            trappedPeople: [Person(position: CGPoint(x: 80, y: 220)), Person(position: CGPoint(x: 60, y: 80))],
            extinguishers: [EvacuationExtinguisher(position: CGPoint(x: 200, y: 200))],
            difficulty: .medium
        ),
        MapLayout(
            environment: .factory,
            name: "Loading Dock Blaze",
            rooms: [
                Room(name: "Loading Dock", frame: CGRect(x: 20, y: 20, width: 260, height: 100), type: .storage),
                Room(name: "Warehouse", frame: CGRect(x: 20, y: 160, width: 260, height: 140), type: .factory)
            ],
            hallways: [Hallway(frame: CGRect(x: 130, y: 120, width: 40, height: 40))],
            walls: [
                Wall(start: CGPoint(x: 20, y: 20), end: CGPoint(x: 280, y: 20)),
                Wall(start: CGPoint(x: 20, y: 20), end: CGPoint(x: 20, y: 300)),
                Wall(start: CGPoint(x: 280, y: 20), end: CGPoint(x: 280, y: 300))
            ],
            startPosition: CGPoint(x: 150, y: 240),
            exitDoors: [
                ExitDoor(position: CGPoint(x: 80, y: 300), status: .safe),
                ExitDoor(position: CGPoint(x: 220, y: 300), status: .safe)
            ],
            fireStarts: [CGPoint(x: 80, y: 70), CGPoint(x: 230, y: 60)],
            trappedPeople: [Person(position: CGPoint(x: 150, y: 60))],
            extinguishers: [EvacuationExtinguisher(position: CGPoint(x: 150, y: 160))],
            difficulty: .hard
        ),
        MapLayout(
            environment: .factory,
            name: "Assembly Line Breakdown",
            rooms: [
                Room(name: "Line A", frame: CGRect(x: 20, y: 20, width: 260, height: 60), type: .factory),
                Room(name: "Line B", frame: CGRect(x: 20, y: 120, width: 260, height: 60), type: .factory),
                Room(name: "Line C", frame: CGRect(x: 20, y: 220, width: 260, height: 60), type: .factory)
            ],
            hallways: [],
            walls: [
                Wall(start: CGPoint(x: 20, y: 20), end: CGPoint(x: 280, y: 20)),
                Wall(start: CGPoint(x: 20, y: 20), end: CGPoint(x: 20, y: 300)),
                Wall(start: CGPoint(x: 280, y: 20), end: CGPoint(x: 280, y: 300))
            ],
            startPosition: CGPoint(x: 150, y: 150),
            exitDoors: [
                ExitDoor(position: CGPoint(x: 50, y: 300), status: .safe),
                ExitDoor(position: CGPoint(x: 250, y: 300), status: .safe)
            ],
            fireStarts: [CGPoint(x: 80, y: 50), CGPoint(x: 200, y: 240)],
            trappedPeople: [
                Person(position: CGPoint(x: 220, y: 50)),
                Person(position: CGPoint(x: 60, y: 240)),
                Person(position: CGPoint(x: 150, y: 50))
            ],
            extinguishers: [EvacuationExtinguisher(position: CGPoint(x: 150, y: 150))],
            difficulty: .hard
        ),
        MapLayout(
            environment: .factory,
            name: "Emergency Shutdown",
            rooms: [
                Room(name: "Control Center", frame: CGRect(x: 20, y: 20, width: 80, height: 80), type: .office),
                Room(name: "Machine Shop", frame: CGRect(x: 20, y: 160, width: 260, height: 120), type: .factory),
                Room(name: "Parts Store", frame: CGRect(x: 160, y: 20, width: 120, height: 80), type: .storage)
            ],
            hallways: [Hallway(frame: CGRect(x: 100, y: 20, width: 60, height: 260))],
            walls: [
                Wall(start: CGPoint(x: 20, y: 20), end: CGPoint(x: 280, y: 20)),
                Wall(start: CGPoint(x: 20, y: 20), end: CGPoint(x: 20, y: 280)),
                Wall(start: CGPoint(x: 280, y: 20), end: CGPoint(x: 280, y: 280))
            ],
            startPosition: CGPoint(x: 60, y: 60),
            exitDoors: [
                ExitDoor(position: CGPoint(x: 80, y: 280), status: .safe),
                ExitDoor(position: CGPoint(x: 220, y: 280), status: .safe)
            ],
            fireStarts: [CGPoint(x: 220, y: 60)],
            trappedPeople: [Person(position: CGPoint(x: 220, y: 100)), Person(position: CGPoint(x: 150, y: 220))],
            extinguishers: [EvacuationExtinguisher(position: CGPoint(x: 130, y: 80))],
            difficulty: .medium
        )
    ]

    static func getMaps(for environment: EnvironmentType) -> [MapLayout] {
        switch environment {
        case .lab:     return labMaps
        case .office:  return officeMaps
        case .kitchen: return kitchenMaps
        case .factory:  return factoryMaps
        }
    }
}
