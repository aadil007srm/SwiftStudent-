import Foundation

struct ScenarioData {
    static func scenarios(for environment: EnvironmentType) -> [Scenario] {
        switch environment {
        case .lab: return labScenarios
        case .office: return officeScenarios
        case .kitchen: return kitchenScenarios
        case .factory: return factoryScenarios
        }
    }
    
    static let labScenarios = [
        Scenario(
            title: "Chemical Fire",
            description: "A beaker containing flammable chemicals has caught fire on the workbench.",
            imageIcon: "flame.fill",
            choices: [
                Choice(id: "1", text: "Use water extinguisher", isCorrect: false, explanation: "Water can react dangerously with chemicals"),
                Choice(id: "2", text: "Use CO2 extinguisher", isCorrect: true, explanation: "CO2 is safe for chemical fires"),
                Choice(id: "3", text: "Cover with lab coat", isCorrect: false, explanation: "This won't extinguish a chemical fire"),
                Choice(id: "4", text: "Run away", isCorrect: false, explanation: "You should attempt to control small fires first")
            ],
            environment: .lab,
            hazards: [.flammableLiquid, .heavySmoke]
        ),
        Scenario(
            title: "Gas Leak",
            description: "You smell gas near the storage area.",
            imageIcon: "wind",
            choices: [
                Choice(id: "1", text: "Turn on exhaust fan", isCorrect: false, explanation: "Electrical switches can ignite gas"),
                Choice(id: "2", text: "Open windows and evacuate", isCorrect: true, explanation: "Ventilate and evacuate immediately"),
                Choice(id: "3", text: "Light a match", isCorrect: false, explanation: "This would cause an explosion"),
                Choice(id: "4", text: "Try to fix it", isCorrect: false, explanation: "Leave it to professionals")
            ],
            environment: .lab,
            hazards: [.gas]
        ),
        Scenario(
            title: "Equipment Sparking",
            description: "Lab equipment is sparking and smoking.",
            imageIcon: "bolt.fill",
            choices: [
                Choice(id: "1", text: "Unplug immediately", isCorrect: false, explanation: "Could cause shock"),
                Choice(id: "2", text: "Turn off circuit breaker", isCorrect: true, explanation: "Cut power at the source safely"),
                Choice(id: "3", text: "Pour water on it", isCorrect: false, explanation: "Water conducts electricity"),
                Choice(id: "4", text: "Continue working", isCorrect: false, explanation: "This is extremely dangerous")
            ],
            environment: .lab,
            hazards: [.electrical, .heavySmoke]
        )
    ]
    
    static let officeScenarios = [
        Scenario(
            title: "Monitor Fire",
            description: "A computer monitor is sparking and on fire.",
            imageIcon: "desktopcomputer",
            choices: [
                Choice(id: "1", text: "Unplug the monitor", isCorrect: false, explanation: "Risk of electric shock"),
                Choice(id: "2", text: "Use CO2 extinguisher", isCorrect: true, explanation: "CO2 is safe for electrical fires"),
                Choice(id: "3", text: "Pour coffee on it", isCorrect: false, explanation: "Liquid conducts electricity"),
                Choice(id: "4", text: "Cover with jacket", isCorrect: false, explanation: "Won't extinguish electrical fire")
            ],
            environment: .office,
            hazards: [.electrical]
        ),
        Scenario(
            title: "Printer Smoking",
            description: "The office printer is smoking heavily.",
            imageIcon: "printer.fill",
            choices: [
                Choice(id: "1", text: "Turn off at power strip", isCorrect: true, explanation: "Cut power safely"),
                Choice(id: "2", text: "Open printer", isCorrect: false, explanation: "Could expose you to fire"),
                Choice(id: "3", text: "Keep printing", isCorrect: false, explanation: "Extremely dangerous"),
                Choice(id: "4", text: "Spray air freshener", isCorrect: false, explanation: "This won't help")
            ],
            environment: .office,
            hazards: [.electrical, .heavySmoke]
        )
    ]
    
    static let kitchenScenarios = [
        Scenario(
            title: "Grease Fire",
            description: "Oil in a pan has caught fire.",
            imageIcon: "flame.fill",
            choices: [
                Choice(id: "1", text: "Pour water on it", isCorrect: false, explanation: "Water makes grease fires explode"),
                Choice(id: "2", text: "Cover with metal lid", isCorrect: true, explanation: "Starves the fire of oxygen"),
                Choice(id: "3", text: "Carry pan outside", isCorrect: false, explanation: "You could spill burning oil"),
                Choice(id: "4", text: "Use water extinguisher", isCorrect: false, explanation: "Wrong type for grease")
            ],
            environment: .kitchen,
            hazards: [.flammableLiquid]
        ),
        Scenario(
            title: "Oven Fire",
            description: "The oven is on fire with smoke.",
            imageIcon: "oven.fill",
            choices: [
                Choice(id: "1", text: "Keep door closed, turn off", isCorrect: true, explanation: "Starve fire of oxygen"),
                Choice(id: "2", text: "Open door", isCorrect: false, explanation: "Oxygen will make it worse"),
                Choice(id: "3", text: "Spray water", isCorrect: false, explanation: "Could cause steam explosion"),
                Choice(id: "4", text: "Remove food", isCorrect: false, explanation: "Too dangerous")
            ],
            environment: .kitchen,
            hazards: [.heavySmoke]
        )
    ]
    
    static let factoryScenarios = [
        Scenario(
            title: "Firecracker Material Fire",
            description: "A container of firecracker chemicals is burning with intense flames and sparks.",
            imageIcon: "sparkles",
            choices: [
                Choice(id: "1", text: "Use water to cool it", isCorrect: false, explanation: "Water causes violent explosions with these chemicals"),
                Choice(id: "2", text: "Use dry powder extinguisher", isCorrect: true, explanation: "Only dry powder works on Class D metal fires"),
                Choice(id: "3", text: "Use CO2 extinguisher", isCorrect: false, explanation: "Won't work on metal fires"),
                Choice(id: "4", text: "Wait for it to burn out", isCorrect: false, explanation: "Could spread and cause explosions")
            ],
            environment: .factory,
            hazards: [.flammableLiquid, .heavySmoke],
            consequence: "Using water on firecracker chemicals causes explosions and severe burns"
        ),
        Scenario(
            title: "Electrical Panel Smoking",
            description: "The main electrical panel is smoking with sparks flying.",
            imageIcon: "bolt.fill",
            choices: [
                Choice(id: "1", text: "Open panel to check", isCorrect: false, explanation: "Risk of arc flash and burns"),
                Choice(id: "2", text: "Evacuate and call emergency", isCorrect: true, explanation: "Main panel fires require professional help"),
                Choice(id: "3", text: "Use fire extinguisher", isCorrect: false, explanation: "Too dangerous without cutting power"),
                Choice(id: "4", text: "Try to turn off breaker", isCorrect: false, explanation: "Risk of electrocution")
            ],
            environment: .factory,
            hazards: [.electrical, .heavySmoke],
            consequence: "Electrical panel fires can cause arc flash, severe burns, and explosions"
        ),
        Scenario(
            title: "Chemical Storage Fire",
            description: "Flammable chemicals stored near the assembly line have caught fire.",
            imageIcon: "flame.fill",
            choices: [
                Choice(id: "1", text: "Hit emergency stop, use foam", isCorrect: true, explanation: "Stop operations and use appropriate extinguisher"),
                Choice(id: "2", text: "Use water hose", isCorrect: false, explanation: "Water spreads chemical fires"),
                Choice(id: "3", text: "Move containers away", isCorrect: false, explanation: "Too dangerous to approach"),
                Choice(id: "4", text: "Continue working", isCorrect: false, explanation: "Could cause explosion")
            ],
            environment: .factory,
            hazards: [.flammableLiquid, .heavySmoke],
            consequence: "Chemical fires spread rapidly and can cause toxic fumes and explosions"
        ),
        Scenario(
            title: "Machine Fuel Leak Fire",
            description: "A machine has a fuel leak and has caught fire near workers.",
            imageIcon: "flame.fill",
            choices: [
                Choice(id: "1", text: "Alert workers and evacuate area", isCorrect: true, explanation: "Safety first - get everyone away"),
                Choice(id: "2", text: "Try to fix the leak", isCorrect: false, explanation: "Too dangerous with fire present"),
                Choice(id: "3", text: "Use water to cool", isCorrect: false, explanation: "Water spreads fuel fires"),
                Choice(id: "4", text: "Turn off lights to see better", isCorrect: false, explanation: "Need visibility for evacuation")
            ],
            environment: .factory,
            hazards: [.flammableLiquid, .heavySmoke],
            consequence: "Fuel fires can spread extremely fast and cause severe burns"
        )
    ]
}
