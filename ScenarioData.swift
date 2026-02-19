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
        // Existing scenarios with updated properties
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
            hazards: [.flammableLiquid, .heavySmoke],
            visualStyle: .chemicalFire,
            category: .chemical,
            difficulty: .intermediate,
            hazardLevel: .high
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
            hazards: [.gas],
            visualStyle: .gasLeak,
            category: .chemical,
            difficulty: .intermediate,
            hazardLevel: .critical
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
            hazards: [.electrical, .heavySmoke],
            visualStyle: .electricalFire,
            category: .electrical,
            difficulty: .intermediate,
            hazardLevel: .high
        ),
        // NEW SCENARIOS - Adding 7 more for total of 10
        Scenario(
            title: "Acid Spill",
            description: "Sulfuric acid has spilled on the floor and is spreading.",
            imageIcon: "drop.triangle.fill",
            choices: [
                Choice(id: "1", text: "Neutralize with water", isCorrect: false, explanation: "Water can cause violent reactions with concentrated acid"),
                Choice(id: "2", text: "Use neutralizing agent and evacuate", isCorrect: true, explanation: "Proper neutralization and safety first"),
                Choice(id: "3", text: "Mop it up quickly", isCorrect: false, explanation: "Direct contact is extremely dangerous"),
                Choice(id: "4", text: "Call for help and wait", isCorrect: false, explanation: "Should contain spill while getting help")
            ],
            environment: .lab,
            hazards: [.flammableLiquid],
            visualStyle: .chemicalFire,
            category: .chemical,
            difficulty: .advanced,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Fume Hood Fire",
            description: "A small fire has started inside the fume hood.",
            imageIcon: "wind.circle.fill",
            choices: [
                Choice(id: "1", text: "Close hood sash and turn off gas", isCorrect: true, explanation: "Contain and cut fuel source"),
                Choice(id: "2", text: "Open hood fully", isCorrect: false, explanation: "Provides oxygen, makes fire worse"),
                Choice(id: "3", text: "Use water extinguisher", isCorrect: false, explanation: "Water may spread chemical fire"),
                Choice(id: "4", text: "Remove materials from hood", isCorrect: false, explanation: "Too dangerous to reach into fire")
            ],
            environment: .lab,
            hazards: [.heavySmoke],
            visualStyle: .chemicalFire,
            category: .fire,
            difficulty: .intermediate,
            hazardLevel: .high
        ),
        Scenario(
            title: "Reaction Overheating",
            description: "Your chemical reaction is heating rapidly and smoking.",
            imageIcon: "thermometer.high",
            choices: [
                Choice(id: "1", text: "Add ice to cool it", isCorrect: false, explanation: "Rapid cooling can cause explosion"),
                Choice(id: "2", text: "Turn off heat source and evacuate area", isCorrect: true, explanation: "Remove energy source and prioritize safety"),
                Choice(id: "3", text: "Add more solvent", isCorrect: false, explanation: "Adding material to runaway reaction is dangerous"),
                Choice(id: "4", text: "Stir vigorously", isCorrect: false, explanation: "Agitation can accelerate dangerous reaction")
            ],
            environment: .lab,
            hazards: [.heavySmoke],
            timeLimit: 45,
            visualStyle: .chemicalFire,
            category: .chemical,
            difficulty: .advanced,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Mercury Spill",
            description: "A mercury thermometer broke, spilling mercury on the bench.",
            imageIcon: "drop.circle.fill",
            choices: [
                Choice(id: "1", text: "Vacuum it up", isCorrect: false, explanation: "Vacuum spreads toxic mercury vapor"),
                Choice(id: "2", text: "Use mercury spill kit and ventilate", isCorrect: true, explanation: "Proper kit prevents vapor exposure"),
                Choice(id: "3", text: "Wipe with paper towel", isCorrect: false, explanation: "Direct contact and incomplete cleanup"),
                Choice(id: "4", text: "Wash down drain", isCorrect: false, explanation: "Environmental contamination and illegal")
            ],
            environment: .lab,
            hazards: [],
            visualStyle: .chemicalFire,
            category: .chemical,
            difficulty: .intermediate,
            hazardLevel: .high
        ),
        Scenario(
            title: "Unattended Flame",
            description: "You notice a Bunsen burner left on with papers nearby.",
            imageIcon: "flame.circle.fill",
            choices: [
                Choice(id: "1", text: "Turn off burner and remove papers", isCorrect: true, explanation: "Eliminate ignition source and fuel"),
                Choice(id: "2", text: "Pour water on burner", isCorrect: false, explanation: "Gas burner needs to be turned off first"),
                Choice(id: "3", text: "Leave it, someone's using it", isCorrect: false, explanation: "Never leave open flame unattended"),
                Choice(id: "4", text: "Blow out the flame", isCorrect: false, explanation: "Gas continues flowing, creating explosion risk")
            ],
            environment: .lab,
            hazards: [],
            visualStyle: .burn,
            category: .fire,
            difficulty: .beginner,
            hazardLevel: .medium
        ),
        Scenario(
            title: "Chemical on Skin",
            description: "Concentrated acid splashed on your coworker's arm.",
            imageIcon: "figure.stand",
            choices: [
                Choice(id: "1", text: "Wipe with cloth", isCorrect: false, explanation: "Spreads acid and causes more damage"),
                Choice(id: "2", text: "Use safety shower for 15+ minutes", isCorrect: true, explanation: "Continuous flushing removes acid completely"),
                Choice(id: "3", text: "Apply burn cream", isCorrect: false, explanation: "Must flush first, cream can trap acid"),
                Choice(id: "4", text: "Rinse briefly with tap water", isCorrect: false, explanation: "15+ minutes needed for chemical burns")
            ],
            environment: .lab,
            hazards: [],
            visualStyle: .chemicalFire,
            category: .firstAid,
            difficulty: .intermediate,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Gas Cylinder Leak",
            description: "You hear hissing from a compressed gas cylinder.",
            imageIcon: "cylinder.fill",
            choices: [
                Choice(id: "1", text: "Try to tighten connections", isCorrect: false, explanation: "Risk of spark or increased leak"),
                Choice(id: "2", text: "Evacuate and call emergency", isCorrect: true, explanation: "Compressed gas leaks require professional response"),
                Choice(id: "3", text: "Move cylinder outside", isCorrect: false, explanation: "Moving pressurized cylinder is extremely dangerous"),
                Choice(id: "4", text: "Spray water on it", isCorrect: false, explanation: "Water doesn't stop gas leak")
            ],
            environment: .lab,
            hazards: [.gas],
            visualStyle: .gasLeak,
            category: .chemical,
            difficulty: .intermediate,
            hazardLevel: .critical
        )
    ]
    
    static let officeScenarios = [
        // Existing scenarios with updated properties
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
            hazards: [.electrical],
            visualStyle: .electricalFire,
            category: .electrical,
            difficulty: .intermediate,
            hazardLevel: .high
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
            hazards: [.electrical, .heavySmoke],
            visualStyle: .electricalFire,
            category: .electrical,
            difficulty: .beginner,
            hazardLevel: .medium
        ),
        // NEW SCENARIOS - Adding 8 more for total of 10
        Scenario(
            title: "Overloaded Power Strip",
            description: "A power strip with multiple devices is smoking and hot to touch.",
            imageIcon: "powerplug.fill",
            choices: [
                Choice(id: "1", text: "Unplug devices one by one", isCorrect: false, explanation: "Strip may spark during unplugging"),
                Choice(id: "2", text: "Turn off circuit breaker first", isCorrect: true, explanation: "Cut power at source before handling"),
                Choice(id: "3", text: "Pour water to cool it", isCorrect: false, explanation: "Water conducts electricity"),
                Choice(id: "4", text: "Just unplug the power strip", isCorrect: false, explanation: "Hot plug can cause shock or spark")
            ],
            environment: .office,
            hazards: [.electrical],
            visualStyle: .electricalFire,
            category: .electrical,
            difficulty: .intermediate,
            hazardLevel: .high
        ),
        Scenario(
            title: "Coffee Maker Fire",
            description: "The office coffee maker is on fire with flames visible.",
            imageIcon: "cup.and.saucer.fill",
            choices: [
                Choice(id: "1", text: "Throw water on it", isCorrect: false, explanation: "Electrical fire - water conducts electricity"),
                Choice(id: "2", text: "Use CO2 extinguisher after unplugging", isCorrect: true, explanation: "Cut power safely, then extinguish"),
                Choice(id: "3", text: "Move it to sink", isCorrect: false, explanation: "Don't handle burning electrical device"),
                Choice(id: "4", text: "Cover with towel", isCorrect: false, explanation: "Towel can catch fire, doesn't cut electricity")
            ],
            environment: .office,
            hazards: [.electrical],
            visualStyle: .electricalFire,
            category: .fire,
            difficulty: .intermediate,
            hazardLevel: .high
        ),
        Scenario(
            title: "Microwave Fire",
            description: "Someone microwaved food in foil and it's on fire inside.",
            imageIcon: "microwave.fill",
            choices: [
                Choice(id: "1", text: "Open door immediately", isCorrect: false, explanation: "Oxygen will make fire worse"),
                Choice(id: "2", text: "Keep door closed, turn off and unplug", isCorrect: true, explanation: "Starve fire of oxygen, cut power"),
                Choice(id: "3", text: "Spray water through vents", isCorrect: false, explanation: "Water and electricity don't mix"),
                Choice(id: "4", text: "Press cancel button", isCorrect: false, explanation: "Must unplug to fully cut power")
            ],
            environment: .office,
            hazards: [.electrical, .heavySmoke],
            visualStyle: .electricalFire,
            category: .fire,
            difficulty: .intermediate,
            hazardLevel: .medium
        ),
        Scenario(
            title: "Paper Shredder Smoking",
            description: "The paper shredder is jammed, smoking and smells like burning plastic.",
            imageIcon: "doc.badge.gearshape.fill",
            choices: [
                Choice(id: "1", text: "Try to clear the jam", isCorrect: false, explanation: "Could get shocked or burned"),
                Choice(id: "2", text: "Unplug immediately and let it cool", isCorrect: true, explanation: "Cut power and prevent fire"),
                Choice(id: "3", text: "Add oil to lubricate", isCorrect: false, explanation: "Oil is flammable, makes it worse"),
                Choice(id: "4", text: "Run it in reverse", isCorrect: false, explanation: "Keeps power on, increases fire risk")
            ],
            environment: .office,
            hazards: [.electrical, .heavySmoke],
            visualStyle: .electricalFire,
            category: .electrical,
            difficulty: .beginner,
            hazardLevel: .medium
        ),
        Scenario(
            title: "Space Heater Near Curtains",
            description: "A space heater is too close to curtains which are starting to smoke.",
            imageIcon: "heater.vertical.fill",
            choices: [
                Choice(id: "1", text: "Move heater away immediately", isCorrect: false, explanation: "Hot heater can burn you or tip over"),
                Choice(id: "2", text: "Unplug heater, then move curtains", isCorrect: true, explanation: "Cut power first for safety"),
                Choice(id: "3", text: "Open window for ventilation", isCorrect: false, explanation: "Doesn't address the fire hazard"),
                Choice(id: "4", text: "Turn heater to low", isCorrect: false, explanation: "Still hot enough to ignite fabric")
            ],
            environment: .office,
            hazards: [],
            visualStyle: .burn,
            category: .fire,
            difficulty: .beginner,
            hazardLevel: .medium
        ),
        Scenario(
            title: "Water Leak Near Outlets",
            description: "Water is leaking from ceiling directly onto electrical outlets.",
            imageIcon: "drop.fill",
            choices: [
                Choice(id: "1", text: "Wipe water with towel", isCorrect: false, explanation: "Risk of electrocution from wet outlet"),
                Choice(id: "2", text: "Turn off circuit breaker for that area", isCorrect: true, explanation: "Cut power before dealing with water"),
                Choice(id: "3", text: "Plug in wet/dry vacuum", isCorrect: false, explanation: "Never use electricity near water leak"),
                Choice(id: "4", text: "Cover outlets with plastic", isCorrect: false, explanation: "Doesn't cut power, still dangerous")
            ],
            environment: .office,
            hazards: [.electrical],
            visualStyle: .electricalFire,
            category: .electrical,
            difficulty: .intermediate,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Laptop Battery Swelling",
            description: "A laptop battery is visibly swollen and the device is very hot.",
            imageIcon: "laptopcomputer",
            choices: [
                Choice(id: "1", text: "Continue using but watch it", isCorrect: false, explanation: "Swollen battery can explode or catch fire"),
                Choice(id: "2", text: "Unplug, shut down, evacuate area", isCorrect: true, explanation: "Battery failure is imminent, prioritize safety"),
                Choice(id: "3", text: "Put in refrigerator to cool", isCorrect: false, explanation: "Extreme temperature change can cause explosion"),
                Choice(id: "4", text: "Press on battery to flatten it", isCorrect: false, explanation: "Can puncture battery causing fire/explosion")
            ],
            environment: .office,
            hazards: [.electrical],
            timeLimit: 45,
            visualStyle: .explosion,
            category: .electrical,
            difficulty: .advanced,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Charging Cable Sparking",
            description: "A phone charging cable is sparking where it connects to the wall.",
            imageIcon: "cable.connector",
            choices: [
                Choice(id: "1", text: "Wiggle it to fix connection", isCorrect: false, explanation: "Can cause shock or worsen short circuit"),
                Choice(id: "2", text: "Turn off breaker, then remove cable", isCorrect: true, explanation: "Cut power before handling damaged cable"),
                Choice(id: "3", text: "Pour water on sparks", isCorrect: false, explanation: "Water conducts electricity"),
                Choice(id: "4", text: "Wrap in electrical tape", isCorrect: false, explanation: "Doesn't fix short circuit, still dangerous")
            ],
            environment: .office,
            hazards: [.electrical],
            visualStyle: .electricalFire,
            category: .electrical,
            difficulty: .intermediate,
            hazardLevel: .high
        )
    ]
    
    static let kitchenScenarios = [
        // Existing scenarios with updated properties
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
            hazards: [.flammableLiquid],
            visualStyle: .burn,
            category: .fire,
            difficulty: .intermediate,
            hazardLevel: .high
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
            hazards: [.heavySmoke],
            visualStyle: .burn,
            category: .fire,
            difficulty: .intermediate,
            hazardLevel: .medium
        ),
        // NEW SCENARIOS - Adding 8 more for total of 10
        Scenario(
            title: "Deep Fryer Overheating",
            description: "The deep fryer oil is smoking heavily and temperature is rising rapidly.",
            imageIcon: "thermometer.sun.fill",
            choices: [
                Choice(id: "1", text: "Add cold oil to cool it", isCorrect: false, explanation: "Cold oil hitting hot oil causes violent splashing"),
                Choice(id: "2", text: "Turn off heat immediately", isCorrect: true, explanation: "Remove heat source before oil ignites"),
                Choice(id: "3", text: "Add frozen food to cool", isCorrect: false, explanation: "Ice causes explosive oil reaction"),
                Choice(id: "4", text: "Stir the oil", isCorrect: false, explanation: "Agitation increases fire risk")
            ],
            environment: .kitchen,
            hazards: [.flammableLiquid],
            timeLimit: 45,
            visualStyle: .burn,
            category: .fire,
            difficulty: .intermediate,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Toaster Fire",
            description: "The toaster is on fire with flames coming out the top.",
            imageIcon: "circle.grid.2x1.fill",
            choices: [
                Choice(id: "1", text: "Pour water on it", isCorrect: false, explanation: "Electrical fire - water conducts electricity"),
                Choice(id: "2", text: "Unplug and smother with baking soda", isCorrect: true, explanation: "Cut power, use Class C fire suppressant"),
                Choice(id: "3", text: "Shake out the burning bread", isCorrect: false, explanation: "Spreads fire and you could get burned"),
                Choice(id: "4", text: "Blow on flames", isCorrect: false, explanation: "Provides oxygen, makes fire worse")
            ],
            environment: .kitchen,
            hazards: [.electrical],
            visualStyle: .electricalFire,
            category: .electrical,
            difficulty: .intermediate,
            hazardLevel: .medium
        ),
        Scenario(
            title: "Dish Towel Fire",
            description: "A dish towel has caught fire on the stove.",
            imageIcon: "square.fill",
            choices: [
                Choice(id: "1", text: "Pick it up and throw in sink", isCorrect: false, explanation: "Fire can spread to you and surroundings"),
                Choice(id: "2", text: "Smother with wet towel or pot lid", isCorrect: true, explanation: "Cut oxygen supply safely"),
                Choice(id: "3", text: "Fan it to blow out", isCorrect: false, explanation: "Oxygen makes fire grow"),
                Choice(id: "4", text: "Spray with cooking spray", isCorrect: false, explanation: "Cooking spray is flammable!")
            ],
            environment: .kitchen,
            hazards: [],
            visualStyle: .burn,
            category: .fire,
            difficulty: .beginner,
            hazardLevel: .medium
        ),
        Scenario(
            title: "Microwave Metal Fire",
            description: "Someone put aluminum foil in microwave and sparks are flying.",
            imageIcon: "sparkles",
            choices: [
                Choice(id: "1", text: "Open door to check", isCorrect: false, explanation: "Keep door closed to contain fire"),
                Choice(id: "2", text: "Press stop and unplug microwave", isCorrect: true, explanation: "Stop operation and cut power"),
                Choice(id: "3", text: "Pour water through vents", isCorrect: false, explanation: "Water + electricity = shock hazard"),
                Choice(id: "4", text: "Let it finish cycle", isCorrect: false, explanation: "Arcing can start a fire")
            ],
            environment: .kitchen,
            hazards: [.electrical],
            visualStyle: .electricalFire,
            category: .electrical,
            difficulty: .beginner,
            hazardLevel: .high
        ),
        Scenario(
            title: "Gas Stove Won't Turn Off",
            description: "The gas stove knob is stuck and flame won't turn off.",
            imageIcon: "flame.circle.fill",
            choices: [
                Choice(id: "1", text: "Force the knob", isCorrect: false, explanation: "Could break valve and cause gas leak"),
                Choice(id: "2", text: "Turn off gas supply valve", isCorrect: true, explanation: "Cut gas at main source"),
                Choice(id: "3", text: "Pour water on flame", isCorrect: false, explanation: "Doesn't stop gas flow, creates hazard"),
                Choice(id: "4", text: "Cover burner with pot", isCorrect: false, explanation: "Gas continues flowing, explosion risk")
            ],
            environment: .kitchen,
            hazards: [.gas],
            visualStyle: .burn,
            category: .fire,
            difficulty: .intermediate,
            hazardLevel: .high
        ),
        Scenario(
            title: "Pressure Cooker Malfunction",
            description: "Pressure cooker is hissing loudly and valve appears stuck.",
            imageIcon: "exclamationmark.triangle.fill",
            choices: [
                Choice(id: "1", text: "Try to open the lid", isCorrect: false, explanation: "Can cause explosive release of steam and contents"),
                Choice(id: "2", text: "Turn off heat and evacuate area", isCorrect: true, explanation: "Remove heat source and prioritize safety"),
                Choice(id: "3", text: "Force open the valve", isCorrect: false, explanation: "Violent steam release can cause severe burns"),
                Choice(id: "4", text: "Add cold water to cool", isCorrect: false, explanation: "Temperature shock can cause explosion")
            ],
            environment: .kitchen,
            hazards: [],
            timeLimit: 30,
            visualStyle: .explosion,
            category: .mechanical,
            difficulty: .advanced,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Electric Mixer Fire",
            description: "An electric mixer motor is smoking and has small flames.",
            imageIcon: "bolt.horizontal.fill",
            choices: [
                Choice(id: "1", text: "Splash water on it", isCorrect: false, explanation: "Water conducts electricity"),
                Choice(id: "2", text: "Unplug immediately and use baking soda", isCorrect: true, explanation: "Cut power then use safe fire suppressant"),
                Choice(id: "3", text: "Turn off and keep using", isCorrect: false, explanation: "Fire will reignite, device is damaged"),
                Choice(id: "4", text: "Spray with fire extinguisher while plugged in", isCorrect: false, explanation: "Should unplug first for safety")
            ],
            environment: .kitchen,
            hazards: [.electrical],
            visualStyle: .electricalFire,
            category: .electrical,
            difficulty: .intermediate,
            hazardLevel: .high
        ),
        Scenario(
            title: "Stovetop Grease Fire Spreading",
            description: "A grease fire on the stovetop is spreading to nearby items.",
            imageIcon: "flame.fill",
            choices: [
                Choice(id: "1", text: "Use Class B extinguisher", isCorrect: true, explanation: "Proper extinguisher for grease fires"),
                Choice(id: "2", text: "Pour water to stop spread", isCorrect: false, explanation: "Water causes grease explosion"),
                Choice(id: "3", text: "Try to move burning items", isCorrect: false, explanation: "Risk of spreading fire and burns"),
                Choice(id: "4", text: "Open windows for ventilation", isCorrect: false, explanation: "Doesn't extinguish fire, wastes time")
            ],
            environment: .kitchen,
            hazards: [.flammableLiquid, .heavySmoke],
            timeLimit: 45,
            visualStyle: .burn,
            category: .fire,
            difficulty: .advanced,
            hazardLevel: .critical
        )
    ]
    
    static let factoryScenarios = [
        // Existing scenarios with updated properties
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
            consequence: "Using water on firecracker chemicals causes explosions and severe burns",
            visualStyle: .explosion,
            category: .chemical,
            difficulty: .expert,
            hazardLevel: .critical
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
            consequence: "Electrical panel fires can cause arc flash, severe burns, and explosions",
            visualStyle: .electricalFire,
            category: .electrical,
            difficulty: .advanced,
            hazardLevel: .critical
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
            consequence: "Chemical fires spread rapidly and can cause toxic fumes and explosions",
            visualStyle: .chemicalFire,
            category: .chemical,
            difficulty: .advanced,
            hazardLevel: .critical
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
            consequence: "Fuel fires can spread extremely fast and cause severe burns",
            visualStyle: .burn,
            category: .fire,
            difficulty: .intermediate,
            hazardLevel: .critical
        ),
        // NEW SCENARIOS - Adding 6 more for total of 10
        Scenario(
            title: "Chemical Mixing Error",
            description: "Two incompatible chemicals were mixed accidentally, producing toxic smoke.",
            imageIcon: "exclamationmark.triangle.fill",
            choices: [
                Choice(id: "1", text: "Try to neutralize immediately", isCorrect: false, explanation: "Unknown reaction - could make it worse"),
                Choice(id: "2", text: "Activate alarm, evacuate, ventilate", isCorrect: true, explanation: "Alert others, get out, let professionals handle"),
                Choice(id: "3", text: "Add water to dilute", isCorrect: false, explanation: "Water may cause violent reaction"),
                Choice(id: "4", text: "Cover with lid to contain", isCorrect: false, explanation: "Pressure buildup can cause explosion")
            ],
            environment: .factory,
            hazards: [.heavySmoke, .gas],
            timeLimit: 30,
            visualStyle: .chemicalFire,
            category: .chemical,
            difficulty: .expert,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Conveyor Belt Motor Fire",
            description: "The conveyor belt motor is on fire with smoke filling the area.",
            imageIcon: "gearshape.fill",
            choices: [
                Choice(id: "1", text: "Pour water on motor", isCorrect: false, explanation: "Electrical fire - water conducts electricity"),
                Choice(id: "2", text: "Hit emergency stop, use CO2 extinguisher", isCorrect: true, explanation: "Cut power first, then use proper extinguisher"),
                Choice(id: "3", text: "Let it burn while evacuating product", isCorrect: false, explanation: "Product is replaceable, safety isn't"),
                Choice(id: "4", text: "Spray with oil to lubricate", isCorrect: false, explanation: "Oil is flammable!")
            ],
            environment: .factory,
            hazards: [.electrical, .heavySmoke],
            visualStyle: .mechanicalFire,
            category: .electrical,
            difficulty: .intermediate,
            hazardLevel: .high
        ),
        Scenario(
            title: "Welding Sparks Ignition",
            description: "Welding sparks have ignited nearby cardboard boxes and materials.",
            imageIcon: "flame.fill",
            choices: [
                Choice(id: "1", text: "Continue welding, it's just cardboard", isCorrect: false, explanation: "Fire can spread rapidly to entire facility"),
                Choice(id: "2", text: "Stop welding, use water extinguisher on boxes", isCorrect: true, explanation: "Water works on ordinary combustibles"),
                Choice(id: "3", text: "Use CO2 on cardboard", isCorrect: false, explanation: "CO2 not ideal for Class A fires"),
                Choice(id: "4", text: "Move burning boxes outside", isCorrect: false, explanation: "Risk of spreading fire and burns")
            ],
            environment: .factory,
            hazards: [.heavySmoke],
            visualStyle: .burn,
            category: .fire,
            difficulty: .beginner,
            hazardLevel: .medium
        ),
        Scenario(
            title: "Hydraulic Fluid Leak Near Heat",
            description: "Hydraulic fluid is leaking near a hot machine, starting to smoke.",
            imageIcon: "drop.triangle.fill",
            choices: [
                Choice(id: "1", text: "Shut down machine and contain leak", isCorrect: true, explanation: "Remove heat source, prevent fire spread"),
                Choice(id: "2", text: "Spray water to cool the fluid", isCorrect: false, explanation: "Spreads petroleum-based fluid"),
                Choice(id: "3", text: "Keep machine running to finish job", isCorrect: false, explanation: "Fluid will ignite, causing major fire"),
                Choice(id: "4", text: "Increase ventilation", isCorrect: false, explanation: "Doesn't address ignition source")
            ],
            environment: .factory,
            hazards: [.flammableLiquid],
            timeLimit: 45,
            visualStyle: .mechanicalFire,
            category: .mechanical,
            difficulty: .intermediate,
            hazardLevel: .high
        ),
        Scenario(
            title: "Dust Explosion Risk",
            description: "Metal dust has accumulated heavily and you see a small spark near it.",
            imageIcon: "cloud.fill",
            choices: [
                Choice(id: "1", text: "Sweep up dust immediately", isCorrect: false, explanation: "Sweeping creates dust cloud, increasing explosion risk"),
                Choice(id: "2", text: "Evacuate area and call fire team", isCorrect: true, explanation: "Metal dust explosions are extremely dangerous"),
                Choice(id: "3", text: "Use compressed air to blow away", isCorrect: false, explanation: "Creates explosive dust cloud"),
                Choice(id: "4", text: "Spray water to settle dust", isCorrect: false, explanation: "Metal dust + water can ignite")
            ],
            environment: .factory,
            hazards: [],
            timeLimit: 30,
            visualStyle: .explosion,
            category: .fire,
            difficulty: .expert,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Coworker Clothes on Fire",
            description: "A coworker's clothing has caught fire from a spark.",
            imageIcon: "figure.wave",
            choices: [
                Choice(id: "1", text: "Tell them to run for help", isCorrect: false, explanation: "Running makes fire worse"),
                Choice(id: "2", text: "Stop, drop, and roll them, use safety shower", isCorrect: true, explanation: "Smother flames, then rinse burns"),
                Choice(id: "3", text: "Use fire extinguisher on them", isCorrect: false, explanation: "Extinguisher can injure, use blanket instead"),
                Choice(id: "4", text: "Pour water from bottle", isCorrect: false, explanation: "Not enough water, use safety shower")
            ],
            environment: .factory,
            hazards: [],
            timeLimit: 20,
            visualStyle: .burn,
            category: .firstAid,
            difficulty: .advanced,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Battery Charging Station Fire",
            description: "Forklift batteries on charge are smoking and one is on fire.",
            imageIcon: "battery.100.bolt",
            choices: [
                Choice(id: "1", text: "Disconnect charger, use Class D extinguisher", isCorrect: true, explanation: "Cut power, use extinguisher for metal fires"),
                Choice(id: "2", text: "Pour water on burning battery", isCorrect: false, explanation: "Water + battery acid = explosion risk"),
                Choice(id: "3", text: "Move other batteries away", isCorrect: false, explanation: "Too dangerous, fire can chain-react"),
                Choice(id: "4", text: "Use CO2 extinguisher", isCorrect: false, explanation: "CO2 not effective on battery fires")
            ],
            environment: .factory,
            hazards: [.electrical, .flammableLiquid],
            timeLimit: 45,
            visualStyle: .electricalFire,
            category: .electrical,
            difficulty: .advanced,
            hazardLevel: .critical
        )
    ]
}
