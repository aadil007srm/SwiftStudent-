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
                Choice(id: "1", text: "Use water extinguisher", isCorrect: false),
                Choice(id: "2", text: "Use CO2 extinguisher", isCorrect: true),
                Choice(id: "3", text: "Cover with lab coat", isCorrect: false),
                Choice(id: "4", text: "Run away", isCorrect: false)
            ]
        ),
        Scenario(
            title: "Gas Leak",
            description: "You smell gas near the storage area.",
            imageIcon: "wind",
            choices: [
                Choice(id: "1", text: "Turn on exhaust fan", isCorrect: false),
                Choice(id: "2", text: "Open windows and evacuate", isCorrect: true),
                Choice(id: "3", text: "Light a match", isCorrect: false),
                Choice(id: "4", text: "Try to fix it", isCorrect: false)
            ]
        ),
        Scenario(
            title: "Equipment Sparking",
            description: "Lab equipment is sparking and smoking.",
            imageIcon: "bolt.fill",
            choices: [
                Choice(id: "1", text: "Unplug immediately", isCorrect: false),
                Choice(id: "2", text: "Turn off circuit breaker", isCorrect: true),
                Choice(id: "3", text: "Pour water on it", isCorrect: false),
                Choice(id: "4", text: "Continue working", isCorrect: false)
            ]
        )
    ]
    
    static let officeScenarios = [
        Scenario(
            title: "Monitor Fire",
            description: "A computer monitor is sparking and on fire.",
            imageIcon: "desktopcomputer",
            choices: [
                Choice(id: "1", text: "Unplug the monitor", isCorrect: false),
                Choice(id: "2", text: "Use CO2 extinguisher", isCorrect: true),
                Choice(id: "3", text: "Pour coffee on it", isCorrect: false),
                Choice(id: "4", text: "Cover with jacket", isCorrect: false)
            ]
        ),
        Scenario(
            title: "Printer Smoking",
            description: "The office printer is smoking heavily.",
            imageIcon: "printer.fill",
            choices: [
                Choice(id: "1", text: "Turn off at power strip", isCorrect: true),
                Choice(id: "2", text: "Open printer", isCorrect: false),
                Choice(id: "3", text: "Keep printing", isCorrect: false),
                Choice(id: "4", text: "Spray air freshener", isCorrect: false)
            ]
        )
    ]
    
    static let kitchenScenarios = [
        Scenario(
            title: "Grease Fire",
            description: "Oil in a pan has caught fire.",
            imageIcon: "flame.fill",
            choices: [
                Choice(id: "1", text: "Pour water on it", isCorrect: false),
                Choice(id: "2", text: "Cover with metal lid", isCorrect: true),
                Choice(id: "3", text: "Carry pan outside", isCorrect: false),
                Choice(id: "4", text: "Use extinguisher", isCorrect: false)
            ]
        ),
        Scenario(
            title: "Oven Fire",
            description: "The oven is on fire with smoke.",
            imageIcon: "oven.fill",
            choices: [
                Choice(id: "1", text: "Keep door closed, turn off", isCorrect: true),
                Choice(id: "2", text: "Open door", isCorrect: false),
                Choice(id: "3", text: "Spray water", isCorrect: false),
                Choice(id: "4", text: "Remove food", isCorrect: false)
            ]
        )
    ]
    
    static let factoryScenarios = [
        Scenario(
            title: "Machine Fire",
            description: "A machine is on fire with fuel leaking.",
            imageIcon: "flame.fill",
            choices: [
                Choice(id: "1", text: "Hit emergency stop, use foam", isCorrect: true),
                Choice(id: "2", text: "Use water hose", isCorrect: false),
                Choice(id: "3", text: "Move machine", isCorrect: false),
                Choice(id: "4", text: "Wait for help", isCorrect: false)
            ]
        ),
        Scenario(
            title: "Electrical Panel Smoking",
            description: "The electrical panel is smoking.",
            imageIcon: "bolt.fill",
            choices: [
                Choice(id: "1", text: "Open panel", isCorrect: false),
                Choice(id: "2", text: "Call electrician, evacuate", isCorrect: true),
                Choice(id: "3", text: "Use extinguisher", isCorrect: false),
                Choice(id: "4", text: "Turn off breaker", isCorrect: false)
            ]
        )
    ]
}
