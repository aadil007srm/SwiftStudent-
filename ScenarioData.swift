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
        ),
        Scenario(
            title: "Ventilation Failure",
            description: "The lab ventilation system has shut down while volatile chemicals are being used.",
            imageIcon: "wind.circle",
            choices: [
                Choice(id: "1", text: "Continue working quickly", isCorrect: false, explanation: "Toxic fumes will accumulate rapidly without ventilation"),
                Choice(id: "2", text: "Stop work, cap chemicals, evacuate lab", isCorrect: true, explanation: "Remove exposure risk and ventilation hazard immediately"),
                Choice(id: "3", text: "Open lab door for airflow", isCorrect: false, explanation: "Contaminated air may spread to other areas"),
                Choice(id: "4", text: "Turn on portable fan", isCorrect: false, explanation: "Fan may spread fumes without proper exhaust")
            ],
            environment: .lab,
            hazards: [.gas, .heavySmoke],
            visualStyle: .chemicalFire,
            category: .chemical,
            difficulty: .intermediate,
            hazardLevel: .high
        ),
        Scenario(
            title: "Biohazard Spill",
            description: "A culture flask containing infectious material has shattered on the floor.",
            imageIcon: "cross.circle.fill",
            choices: [
                Choice(id: "1", text: "Wipe up immediately with paper towels", isCorrect: false, explanation: "Direct contact without PPE risks infection"),
                Choice(id: "2", text: "Alert others, don PPE, use biohazard spill kit", isCorrect: true, explanation: "Proper containment prevents biological exposure"),
                Choice(id: "3", text: "Pour bleach directly on broken glass", isCorrect: false, explanation: "Should not handle broken glass without proper tools"),
                Choice(id: "4", text: "Leave and let it dry naturally", isCorrect: false, explanation: "Infectious material remains viable and spreads")
            ],
            environment: .lab,
            hazards: [],
            visualStyle: .chemicalFire,
            category: .chemical,
            difficulty: .advanced,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Cryogenic Spill",
            description: "Liquid nitrogen has spilled on the floor of the lab, producing large clouds of vapor.",
            imageIcon: "snowflake",
            choices: [
                Choice(id: "1", text: "Mop it up immediately", isCorrect: false, explanation: "Contact with liquid nitrogen causes severe cryogenic burns"),
                Choice(id: "2", text: "Evacuate the area and allow it to evaporate", isCorrect: true, explanation: "Nitrogen displaces oxygen; evacuate and ventilate"),
                Choice(id: "3", text: "Use fire extinguisher to disperse vapor", isCorrect: false, explanation: "Extinguisher cannot help and may spread the hazard"),
                Choice(id: "4", text: "Throw absorbent material on it", isCorrect: false, explanation: "Cryogenic liquid cannot be absorbed safely this way")
            ],
            environment: .lab,
            hazards: [],
            visualStyle: .general,
            category: .chemical,
            difficulty: .advanced,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Autoclave Malfunction",
            description: "The autoclave is beeping with an error code and steam is escaping around the door.",
            imageIcon: "cylinder.split.1x2.fill",
            choices: [
                Choice(id: "1", text: "Open the door to check contents", isCorrect: false, explanation: "High pressure steam can cause severe burns"),
                Choice(id: "2", text: "Press emergency stop and call maintenance", isCorrect: true, explanation: "Cut power and get professional help for pressurized equipment"),
                Choice(id: "3", text: "Add more water and restart", isCorrect: false, explanation: "Do not restart malfunctioning pressurized equipment"),
                Choice(id: "4", text: "Ignore it, it will stop on its own", isCorrect: false, explanation: "Pressure buildup can cause explosion")
            ],
            environment: .lab,
            hazards: [],
            timeLimit: 30,
            visualStyle: .explosion,
            category: .mechanical,
            difficulty: .intermediate,
            hazardLevel: .high
        ),
        Scenario(
            title: "Laser Safety Hazard",
            description: "A class IV laser is operating without the required safety enclosure in place.",
            imageIcon: "eye.slash.fill",
            choices: [
                Choice(id: "1", text: "Look at the beam to check alignment", isCorrect: false, explanation: "Class IV laser can permanently blind you instantly"),
                Choice(id: "2", text: "Stop laser, replace enclosure before restarting", isCorrect: true, explanation: "Never operate high-power laser without safety enclosure"),
                Choice(id: "3", text: "Put on sunglasses and continue", isCorrect: false, explanation: "Regular sunglasses do not protect against laser radiation"),
                Choice(id: "4", text: "Turn off room lights to see the beam better", isCorrect: false, explanation: "Darkness makes laser exposure even more dangerous")
            ],
            environment: .lab,
            hazards: [],
            visualStyle: .general,
            category: .electrical,
            difficulty: .intermediate,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Chemical Eye Exposure",
            description: "A splash of corrosive chemical has entered a researcher's eyes.",
            imageIcon: "eye.fill",
            choices: [
                Choice(id: "1", text: "Apply eye drops and rest", isCorrect: false, explanation: "Eye drops are insufficient for chemical exposure"),
                Choice(id: "2", text: "Go to eyewash station and flush 15+ minutes", isCorrect: true, explanation: "Continuous flushing for 15+ minutes is the required first aid"),
                Choice(id: "3", text: "Rub eyes to remove chemical", isCorrect: false, explanation: "Rubbing spreads the chemical and causes more damage"),
                Choice(id: "4", text: "Rinse briefly then call doctor", isCorrect: false, explanation: "Brief rinse is not sufficient; must flush continuously")
            ],
            environment: .lab,
            hazards: [],
            timeLimit: 20,
            visualStyle: .chemicalFire,
            category: .firstAid,
            difficulty: .intermediate,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Centrifuge Imbalance",
            description: "The centrifuge is shaking violently and making loud banging noises.",
            imageIcon: "circle.dashed",
            choices: [
                Choice(id: "1", text: "Open lid to check the rotor", isCorrect: false, explanation: "Opening during operation can cause rotor ejection and serious injury"),
                Choice(id: "2", text: "Press stop and stand back until it slows", isCorrect: true, explanation: "Use emergency stop and keep clear of the equipment"),
                Choice(id: "3", text: "Hold it down to stabilize", isCorrect: false, explanation: "Never manually hold vibrating centrifuge"),
                Choice(id: "4", text: "Turn up speed to balance itself", isCorrect: false, explanation: "Increasing speed worsens the imbalance and risk of explosion")
            ],
            environment: .lab,
            hazards: [],
            visualStyle: .mechanicalFire,
            category: .mechanical,
            difficulty: .intermediate,
            hazardLevel: .high
        ),
        Scenario(
            title: "Toxic Fume Inhalation",
            description: "A colleague has collapsed near an open container of toxic solvent.",
            imageIcon: "person.fill.xmark",
            choices: [
                Choice(id: "1", text: "Shake them to wake up", isCorrect: false, explanation: "Do not enter the hazard area without protection"),
                Choice(id: "2", text: "Hold breath, drag to fresh air, call 911", isCorrect: true, explanation: "Rescue from toxic atmosphere, then summon emergency help"),
                Choice(id: "3", text: "Provide mouth-to-mouth in the lab", isCorrect: false, explanation: "CPR in toxic environment risks the rescuer"),
                Choice(id: "4", text: "Open windows then help them", isCorrect: false, explanation: "First remove victim from toxic area")
            ],
            environment: .lab,
            hazards: [.gas],
            timeLimit: 20,
            visualStyle: .chemicalFire,
            category: .firstAid,
            difficulty: .advanced,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Ethanol Fire",
            description: "Spilled ethanol on the workbench has ignited from a nearby Bunsen burner.",
            imageIcon: "flame.circle.fill",
            choices: [
                Choice(id: "1", text: "Blow out the flame", isCorrect: false, explanation: "Blowing spreads ethanol vapor and worsens the fire"),
                Choice(id: "2", text: "Use CO2 extinguisher immediately", isCorrect: true, explanation: "CO2 extinguishes alcohol fires without spreading them"),
                Choice(id: "3", text: "Pour water on it", isCorrect: false, explanation: "Water spreads burning ethanol across the bench"),
                Choice(id: "4", text: "Cover with lab coat", isCorrect: false, explanation: "Lab coat will ignite, putting you at risk")
            ],
            environment: .lab,
            hazards: [.flammableLiquid],
            timeLimit: 30,
            visualStyle: .chemicalFire,
            category: .fire,
            difficulty: .intermediate,
            hazardLevel: .high
        ),
        Scenario(
            title: "Liquid Nitrogen Dewar Pressure",
            description: "The liquid nitrogen Dewar is making a loud hissing sound and appears overpressurized.",
            imageIcon: "cylinder.fill",
            choices: [
                Choice(id: "1", text: "Remove the pressure relief valve", isCorrect: false, explanation: "This could cause catastrophic pressure release"),
                Choice(id: "2", text: "Move everyone back and contact safety officer", isCorrect: true, explanation: "Overpressurized cryogenic vessels can explode; keep clear"),
                Choice(id: "3", text: "Place in a larger container with ice", isCorrect: false, explanation: "Do not approach or move an overpressurized Dewar"),
                Choice(id: "4", text: "Lay it on its side to release pressure", isCorrect: false, explanation: "This can cause rapid cryogenic spill and pressure explosion")
            ],
            environment: .lab,
            hazards: [],
            visualStyle: .explosion,
            category: .chemical,
            difficulty: .advanced,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Sharps Injury",
            description: "You accidentally stuck yourself with a needle that was used on biological samples.",
            imageIcon: "staple",
            choices: [
                Choice(id: "1", text: "Ignore it and continue working", isCorrect: false, explanation: "Needlestick with biological material requires immediate response"),
                Choice(id: "2", text: "Wash wound, report immediately, seek medical evaluation", isCorrect: true, explanation: "Proper first aid and incident reporting for potential exposure"),
                Choice(id: "3", text: "Apply a bandage and keep working", isCorrect: false, explanation: "Biological exposure requires medical evaluation, not just a bandage"),
                Choice(id: "4", text: "Squeeze to make it bleed more", isCorrect: false, explanation: "Squeezing can introduce bacteria; wash with soap and water")
            ],
            environment: .lab,
            hazards: [],
            timeLimit: 30,
            visualStyle: .general,
            category: .firstAid,
            difficulty: .intermediate,
            hazardLevel: .high
        ),
        Scenario(
            title: "Chemical Spill on Skin",
            description: "A corrosive chemical has splashed onto your gloved hand and forearm.",
            imageIcon: "hand.raised.fill",
            choices: [
                Choice(id: "1", text: "Remove glove carefully and neutralize with baking soda", isCorrect: false, explanation: "Should flush first; neutralization is secondary"),
                Choice(id: "2", text: "Remove contaminated clothing and flush under water for 15 min", isCorrect: true, explanation: "Copious water flushing is the first treatment for chemical skin contact"),
                Choice(id: "3", text: "Apply burn ointment immediately", isCorrect: false, explanation: "Flush first; ointment can trap chemical against skin"),
                Choice(id: "4", text: "Wipe off with dry cloth then rinse briefly", isCorrect: false, explanation: "Wiping can spread chemical; flush immediately and continuously")
            ],
            environment: .lab,
            hazards: [],
            visualStyle: .chemicalFire,
            category: .firstAid,
            difficulty: .intermediate,
            hazardLevel: .high
        ),
        Scenario(
            title: "Flammable Storage Near Heat",
            description: "Flammable solvent bottles are stored next to a hot plate that was accidentally left on.",
            imageIcon: "flame.fill",
            choices: [
                Choice(id: "1", text: "Move the solvents quickly away", isCorrect: false, explanation: "Moving containers near active heat source can ignite vapors"),
                Choice(id: "2", text: "Turn off hot plate then move solvents when cool", isCorrect: true, explanation: "Remove ignition source first before moving flammables"),
                Choice(id: "3", text: "Turn on fume hood to ventilate", isCorrect: false, explanation: "Does not eliminate the ignition source"),
                Choice(id: "4", text: "Leave it, there's no fire yet", isCorrect: false, explanation: "Preventable fire hazard must be addressed immediately")
            ],
            environment: .lab,
            hazards: [.flammableLiquid],
            visualStyle: .chemicalFire,
            category: .fire,
            difficulty: .beginner,
            hazardLevel: .high
        ),
        Scenario(
            title: "Power Failure Mid-Experiment",
            description: "Power has cut out while a sensitive reaction requiring cooling is underway.",
            imageIcon: "bolt.slash.fill",
            choices: [
                Choice(id: "1", text: "Wait for power to return and hope for the best", isCorrect: false, explanation: "Uncontrolled reactions can overheat and explode without power"),
                Choice(id: "2", text: "Manually terminate reaction and document state", isCorrect: true, explanation: "Safely stop reaction to prevent uncontrolled escalation"),
                Choice(id: "3", text: "Use backup generator for lights only", isCorrect: false, explanation: "Cooling system must be restored, not just lights"),
                Choice(id: "4", text: "Leave the lab immediately", isCorrect: false, explanation: "Abandoned running reactions can become hazardous")
            ],
            environment: .lab,
            hazards: [.heavySmoke],
            visualStyle: .explosion,
            category: .chemical,
            difficulty: .advanced,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Hot Plate Left Unattended",
            description: "You discover a hot plate has been left on overnight with a dry beaker on it.",
            imageIcon: "thermometer.medium",
            choices: [
                Choice(id: "1", text: "Touch the beaker to check temperature", isCorrect: false, explanation: "Unknown temperature could cause burns"),
                Choice(id: "2", text: "Turn off hot plate and use tongs to move beaker if needed", isCorrect: true, explanation: "Eliminate heat source safely without direct contact"),
                Choice(id: "3", text: "Pour water on it to cool it quickly", isCorrect: false, explanation: "Thermal shock to hot glassware can cause it to shatter"),
                Choice(id: "4", text: "Leave it on, someone may be using it", isCorrect: false, explanation: "Unattended heating equipment is a fire hazard")
            ],
            environment: .lab,
            hazards: [],
            visualStyle: .burn,
            category: .fire,
            difficulty: .beginner,
            hazardLevel: .medium
        ),
        Scenario(
            title: "Chemical Odor from Drain",
            description: "A strong chemical smell is coming from the lab drain, getting stronger.",
            imageIcon: "arrow.up.circle.fill",
            choices: [
                Choice(id: "1", text: "Pour bleach down drain to neutralize", isCorrect: false, explanation: "Bleach can react violently with many chemicals in drains"),
                Choice(id: "2", text: "Evacuate lab and report to safety officer", isCorrect: true, explanation: "Unknown chemical from drain may indicate dangerous gas release"),
                Choice(id: "3", text: "Run more water to dilute it", isCorrect: false, explanation: "May worsen chemical reaction or increase gas release"),
                Choice(id: "4", text: "Investigate by looking into drain", isCorrect: false, explanation: "Direct exposure to unknown chemical fumes is dangerous")
            ],
            environment: .lab,
            hazards: [.gas],
            visualStyle: .chemicalFire,
            category: .chemical,
            difficulty: .intermediate,
            hazardLevel: .high
        ),
        Scenario(
            title: "Fire Alarm Activation",
            description: "The fire alarm is sounding in the lab building during an experiment.",
            imageIcon: "alarm.fill",
            choices: [
                Choice(id: "1", text: "Ignore it, probably a false alarm", isCorrect: false, explanation: "All fire alarms must be treated as real emergencies"),
                Choice(id: "2", text: "Secure experiment, turn off equipment, evacuate", isCorrect: true, explanation: "Make experiment safe, then follow evacuation protocol"),
                Choice(id: "3", text: "Stay and watch the experiment", isCorrect: false, explanation: "Personal safety takes priority over experiments"),
                Choice(id: "4", text: "Search for the fire before evacuating", isCorrect: false, explanation: "Never search for fire yourself; evacuate and let fire services respond")
            ],
            environment: .lab,
            hazards: [],
            visualStyle: .burn,
            category: .evacuation,
            difficulty: .beginner,
            hazardLevel: .high
        ),
        Scenario(
            title: "Broken Glass Injury",
            description: "A researcher has cut their hand on broken lab glassware.",
            imageIcon: "cross.fill",
            choices: [
                Choice(id: "1", text: "Remove glass fragments with bare hands", isCorrect: false, explanation: "Further injury from additional lacerations"),
                Choice(id: "2", text: "Apply pressure with clean cloth and seek first aid", isCorrect: true, explanation: "Control bleeding with pressure and get medical assessment"),
                Choice(id: "3", text: "Rinse wound with chemical-containing water from lab sink", isCorrect: false, explanation: "Lab sinks may have chemical contamination"),
                Choice(id: "4", text: "Continue working and treat later", isCorrect: false, explanation: "Glass wounds require immediate first aid")
            ],
            environment: .lab,
            hazards: [],
            timeLimit: 30,
            visualStyle: .general,
            category: .firstAid,
            difficulty: .beginner,
            hazardLevel: .medium
        ),
        Scenario(
            title: "UV Light Exposure",
            description: "A UV transilluminator was left on without a protective cover.",
            imageIcon: "sun.max.fill",
            choices: [
                Choice(id: "1", text: "Look directly at the light to confirm it's UV", isCorrect: false, explanation: "UV light causes irreversible eye and skin damage"),
                Choice(id: "2", text: "Turn off UV lamp and report exposure", isCorrect: true, explanation: "Stop exposure immediately and report for medical evaluation"),
                Choice(id: "3", text: "Close your eyes and replace the cover", isCorrect: false, explanation: "Skin is also vulnerable to UV burns"),
                Choice(id: "4", text: "Put sunscreen on exposed skin and continue", isCorrect: false, explanation: "Regular sunscreen is not designed for lab UV wavelengths")
            ],
            environment: .lab,
            hazards: [],
            visualStyle: .general,
            category: .electrical,
            difficulty: .intermediate,
            hazardLevel: .high
        ),
        Scenario(
            title: "Carbon Monoxide Alert",
            description: "The CO detector in the lab is alarming persistently.",
            imageIcon: "exclamationmark.shield.fill",
            choices: [
                Choice(id: "1", text: "Reset the detector and continue working", isCorrect: false, explanation: "Carbon monoxide is odorless and lethal; evacuate immediately"),
                Choice(id: "2", text: "Evacuate immediately and call emergency services", isCorrect: true, explanation: "CO is life-threatening; get fresh air and emergency help"),
                Choice(id: "3", text: "Open a window and return to work", isCorrect: false, explanation: "Source of CO must be identified; do not re-enter"),
                Choice(id: "4", text: "Fan out the room then investigate", isCorrect: false, explanation: "Do not re-enter without emergency clearance")
            ],
            environment: .lab,
            hazards: [.gas],
            timeLimit: 20,
            visualStyle: .gasLeak,
            category: .chemical,
            difficulty: .beginner,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Chemical Waste Disposal Error",
            description: "Someone poured oxidizer waste into the organic solvent waste container.",
            imageIcon: "xmark.bin.fill",
            choices: [
                Choice(id: "1", text: "Mix thoroughly to dilute the oxidizer", isCorrect: false, explanation: "Oxidizer with organic solvent can ignite or explode"),
                Choice(id: "2", text: "Do not disturb container, evacuate, call hazmat", isCorrect: true, explanation: "Incompatible waste mixture is explosive; treat as emergency"),
                Choice(id: "3", text: "Add water to dilute the reaction", isCorrect: false, explanation: "Water can cause violent reaction with some oxidizers"),
                Choice(id: "4", text: "Pour into sink to separate them", isCorrect: false, explanation: "Pouring can cause ignition and contaminate water supply")
            ],
            environment: .lab,
            hazards: [.flammableLiquid],
            timeLimit: 30,
            visualStyle: .explosion,
            category: .chemical,
            difficulty: .expert,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Dewar Flask Explosion Risk",
            description: "A sealed glass Dewar has been in storage unsealed and is developing frost cracks.",
            imageIcon: "snowflake.circle.fill",
            choices: [
                Choice(id: "1", text: "Shake the Dewar to mix contents", isCorrect: false, explanation: "Vibration can cause sudden pressure release or explosion"),
                Choice(id: "2", text: "Clear the area and contact safety officer", isCorrect: true, explanation: "Compromised cryogenic vessels can fail catastrophically"),
                Choice(id: "3", text: "Warm it up to relieve pressure", isCorrect: false, explanation: "Rapid warming increases pressure and explosion risk"),
                Choice(id: "4", text: "Continue using it with extra care", isCorrect: false, explanation: "Cracked cryogenic vessels must never be used")
            ],
            environment: .lab,
            hazards: [],
            visualStyle: .explosion,
            category: .chemical,
            difficulty: .advanced,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Biosafety Cabinet Alarm",
            description: "The biosafety cabinet alarm is sounding while infectious materials are inside.",
            imageIcon: "shield.lefthalf.filled",
            choices: [
                Choice(id: "1", text: "Open the sash to investigate", isCorrect: false, explanation: "Opening sash during alarm compromises containment"),
                Choice(id: "2", text: "Stop work, leave materials inside, report to safety officer", isCorrect: true, explanation: "Keep containment, stop work, and get expert assessment"),
                Choice(id: "3", text: "Reset the alarm and continue working", isCorrect: false, explanation: "Cabinet failure with infectious materials requires expert response"),
                Choice(id: "4", text: "Remove materials and transfer to another cabinet", isCorrect: false, explanation: "Moving contaminated materials during failure increases risk")
            ],
            environment: .lab,
            hazards: [],
            visualStyle: .general,
            category: .chemical,
            difficulty: .advanced,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Gas Cylinder Tip",
            description: "An unsecured gas cylinder has fallen and the regulator appears damaged.",
            imageIcon: "cylinder.fill",
            choices: [
                Choice(id: "1", text: "Pick it up and inspect the damage", isCorrect: false, explanation: "Damaged regulator can release high-pressure gas violently"),
                Choice(id: "2", text: "Evacuate area and call emergency services", isCorrect: true, explanation: "Damaged compressed gas cylinders are extremely dangerous"),
                Choice(id: "3", text: "Turn on ventilation and then approach", isCorrect: false, explanation: "Do not approach a damaged compressed gas cylinder"),
                Choice(id: "4", text: "Tape the damaged regulator shut", isCorrect: false, explanation: "Tape cannot contain high-pressure gas")
            ],
            environment: .lab,
            hazards: [.gas],
            timeLimit: 20,
            visualStyle: .explosion,
            category: .chemical,
            difficulty: .intermediate,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Acid Drain Backup",
            description: "Acid waste is backing up from the drain onto the lab floor.",
            imageIcon: "arrow.up.bin.fill",
            choices: [
                Choice(id: "1", text: "Mop it up immediately", isCorrect: false, explanation: "Direct contact with acid waste without PPE is dangerous"),
                Choice(id: "2", text: "Don PPE, spread neutralizing absorbent, call facilities", isCorrect: true, explanation: "Proper PPE and neutralization before containment"),
                Choice(id: "3", text: "Flush with large amounts of water", isCorrect: false, explanation: "May spread acid and overwhelm drain capacity"),
                Choice(id: "4", text: "Evacuate and leave the acid to drain", isCorrect: false, explanation: "Acid must be neutralized and cleaned up properly")
            ],
            environment: .lab,
            hazards: [],
            visualStyle: .chemicalFire,
            category: .chemical,
            difficulty: .intermediate,
            hazardLevel: .high
        ),
        Scenario(
            title: "Chlorine Gas Release",
            description: "You accidentally mixed bleach and ammonia cleaner, producing yellow-green gas.",
            imageIcon: "smoke.fill",
            choices: [
                Choice(id: "1", text: "Stay and try to stop the reaction", isCorrect: false, explanation: "Chlorine gas is acutely toxic; do not stay in the area"),
                Choice(id: "2", text: "Hold breath, leave immediately, call emergency services", isCorrect: true, explanation: "Get to fresh air immediately; chlorine gas is life-threatening"),
                Choice(id: "3", text: "Open a window and continue", isCorrect: false, explanation: "Window alone is insufficient; evacuate the space entirely"),
                Choice(id: "4", text: "Use the fume hood to ventilate", isCorrect: false, explanation: "Do not waste time; exit the area immediately")
            ],
            environment: .lab,
            hazards: [.gas],
            timeLimit: 15,
            visualStyle: .gasLeak,
            category: .chemical,
            difficulty: .advanced,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Electrical Short in Equipment",
            description: "Lab equipment gives you a small shock and then sparks when touched.",
            imageIcon: "bolt.fill",
            choices: [
                Choice(id: "1", text: "Keep working with gloves on", isCorrect: false, explanation: "Equipment with electrical fault must be taken out of service"),
                Choice(id: "2", text: "Unplug at wall socket, tag out, report to maintenance", isCorrect: true, explanation: "Remove from service and follow lockout/tagout protocol"),
                Choice(id: "3", text: "Wrap in electrical tape and continue", isCorrect: false, explanation: "Tape does not fix an internal short circuit"),
                Choice(id: "4", text: "Pour water on it to dissipate static", isCorrect: false, explanation: "Water + electricity is a lethal combination")
            ],
            environment: .lab,
            hazards: [.electrical],
            visualStyle: .electricalFire,
            category: .electrical,
            difficulty: .intermediate,
            hazardLevel: .high
        ),
        Scenario(
            title: "Compressed Air Hose Failure",
            description: "A compressed air line has ruptured and is blowing air violently in the lab.",
            imageIcon: "wind",
            choices: [
                Choice(id: "1", text: "Grab the hose to direct it away", isCorrect: false, explanation: "High pressure air can inject under skin and cause fatal injury"),
                Choice(id: "2", text: "Shut off compressed air valve at source", isCorrect: true, explanation: "Cut supply at source to stop the dangerous release"),
                Choice(id: "3", text: "Try to crimp the hose", isCorrect: false, explanation: "Cannot safely crimp high-pressure line by hand"),
                Choice(id: "4", text: "Continue work while avoiding the hose", isCorrect: false, explanation: "Uncontrolled high-pressure air is extremely dangerous")
            ],
            environment: .lab,
            hazards: [],
            visualStyle: .general,
            category: .mechanical,
            difficulty: .intermediate,
            hazardLevel: .high
        ),
        Scenario(
            title: "Acetone Spill Near Ignition",
            description: "A large acetone spill has occurred near an operating hot plate.",
            imageIcon: "drop.fill",
            choices: [
                Choice(id: "1", text: "Wipe up with paper towels quickly", isCorrect: false, explanation: "Approaching with paper towels near ignition source risks flash fire"),
                Choice(id: "2", text: "Turn off hot plate remotely, evacuate, ventilate", isCorrect: true, explanation: "Eliminate ignition source from a distance, then evacuate"),
                Choice(id: "3", text: "Throw sand on the spill", isCorrect: false, explanation: "Sand won't prevent ignition from nearby hot plate"),
                Choice(id: "4", text: "Use fire extinguisher to knock away hot plate", isCorrect: false, explanation: "Do not approach; shut off power remotely if possible")
            ],
            environment: .lab,
            hazards: [.flammableLiquid],
            timeLimit: 30,
            visualStyle: .chemicalFire,
            category: .fire,
            difficulty: .advanced,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Eye Wash Station Blocked",
            description: "A chemical has splashed in someone's eyes and the nearest eyewash is blocked by equipment.",
            imageIcon: "eye.circle.fill",
            choices: [
                Choice(id: "1", text: "Wait until equipment is moved before treatment", isCorrect: false, explanation: "Every second counts with chemical eye exposure"),
                Choice(id: "2", text: "Use any available water source immediately", isCorrect: true, explanation: "Immediate flushing with any clean water is critical"),
                Choice(id: "3", text: "Apply eye drops as an alternative", isCorrect: false, explanation: "Eye drops are inadequate for chemical exposure"),
                Choice(id: "4", text: "Call poison control before treatment", isCorrect: false, explanation: "Begin flushing immediately; call for help simultaneously")
            ],
            environment: .lab,
            hazards: [],
            timeLimit: 15,
            visualStyle: .general,
            category: .firstAid,
            difficulty: .advanced,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Radiation Source Alert",
            description: "A radiation detector starts alarming near a storage cabinet in the radioisotope lab.",
            imageIcon: "waveform.path.ecg",
            choices: [
                Choice(id: "1", text: "Open the cabinet to investigate the source", isCorrect: false, explanation: "Opening increases radiation exposure risk"),
                Choice(id: "2", text: "Evacuate area and contact radiation safety officer", isCorrect: true, explanation: "Only trained personnel with proper equipment should investigate"),
                Choice(id: "3", text: "Stand further away and continue working", isCorrect: false, explanation: "The source of radiation must be identified before re-entry"),
                Choice(id: "4", text: "Use lead apron to investigate", isCorrect: false, explanation: "Proper radiation incident response requires trained safety officer")
            ],
            environment: .lab,
            hazards: [],
            visualStyle: .general,
            category: .chemical,
            difficulty: .advanced,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Smoke from Refrigerator",
            description: "Smoke is coming from the chemical storage refrigerator.",
            imageIcon: "refrigerator.fill",
            choices: [
                Choice(id: "1", text: "Open fridge to see what's burning", isCorrect: false, explanation: "Opening provides oxygen and may expose flammable chemicals"),
                Choice(id: "2", text: "Unplug refrigerator and evacuate lab", isCorrect: true, explanation: "Cut power and evacuate; fridge may contain flammables"),
                Choice(id: "3", text: "Use fire extinguisher through closed door vent", isCorrect: false, explanation: "Cannot safely deliver extinguisher this way"),
                Choice(id: "4", text: "Remove chemicals from fridge first", isCorrect: false, explanation: "Too dangerous to open; cut power and evacuate")
            ],
            environment: .lab,
            hazards: [.flammableLiquid, .electrical],
            visualStyle: .chemicalFire,
            category: .fire,
            difficulty: .intermediate,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Chemical Splash on Clothing",
            description: "A large volume of unknown chemical has splashed onto your clothing and skin.",
            imageIcon: "figure.arms.open",
            choices: [
                Choice(id: "1", text: "Wipe off with paper towels and continue", isCorrect: false, explanation: "Chemical may penetrate clothing and continue burning skin"),
                Choice(id: "2", text: "Remove clothing immediately, use safety shower for 15 min", isCorrect: true, explanation: "Remove exposure source and flush continuously"),
                Choice(id: "3", text: "Apply neutralizing chemical to clothing", isCorrect: false, explanation: "Do not apply neutralizers to skin; flush with water first"),
                Choice(id: "4", text: "Go to break room to rinse in sink", isCorrect: false, explanation: "Use the nearest safety shower; do not travel far with chemical exposure")
            ],
            environment: .lab,
            hazards: [],
            timeLimit: 20,
            visualStyle: .chemicalFire,
            category: .firstAid,
            difficulty: .intermediate,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Overpressure in Reaction Flask",
            description: "Your sealed reaction flask is bulging and showing signs of pressure buildup.",
            imageIcon: "exclamationmark.circle.fill",
            choices: [
                Choice(id: "1", text: "Try to open the flask slowly", isCorrect: false, explanation: "Pressurized flask can explode violently when opened"),
                Choice(id: "2", text: "Move away from flask and shield yourself", isCorrect: true, explanation: "Keep clear of potential explosion; do not approach"),
                Choice(id: "3", text: "Cool it quickly with ice bath", isCorrect: false, explanation: "Do not approach an overpressurized vessel"),
                Choice(id: "4", text: "Place in fume hood to contain any explosion", isCorrect: false, explanation: "Do not transport overpressurized flask")
            ],
            environment: .lab,
            hazards: [],
            timeLimit: 15,
            visualStyle: .explosion,
            category: .chemical,
            difficulty: .advanced,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Glove Failure with Acid",
            description: "You feel burning sensation on your hand while working with concentrated acid through gloves.",
            imageIcon: "hand.raised.slash.fill",
            choices: [
                Choice(id: "1", text: "Finish the task before removing gloves", isCorrect: false, explanation: "Immediate glove removal is essential to prevent worsening burns"),
                Choice(id: "2", text: "Remove gloves, flush hand for 15+ minutes", isCorrect: true, explanation: "Immediate decontamination prevents deeper tissue damage"),
                Choice(id: "3", text: "Add another glove over the damaged one", isCorrect: false, explanation: "Does nothing to stop acid that has already reached skin"),
                Choice(id: "4", text: "Apply burn gel immediately", isCorrect: false, explanation: "Must flush acid off first before any topical treatment")
            ],
            environment: .lab,
            hazards: [],
            timeLimit: 20,
            visualStyle: .chemicalFire,
            category: .firstAid,
            difficulty: .intermediate,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Water Leak on Electrical Panel",
            description: "Water is dripping from the ceiling directly onto the lab's electrical panel.",
            imageIcon: "drop.degreesign.fill",
            choices: [
                Choice(id: "1", text: "Wipe water away from the panel", isCorrect: false, explanation: "Risk of electrocution; do not touch wet electrical equipment"),
                Choice(id: "2", text: "Shut down circuit breaker remotely, call facilities", isCorrect: true, explanation: "Cut power without touching wet equipment"),
                Choice(id: "3", text: "Put a bucket under the drip", isCorrect: false, explanation: "Does not address the electrical hazard; panel may already be compromised"),
                Choice(id: "4", text: "Use hair dryer to dry panel", isCorrect: false, explanation: "Using electrical appliance near water is dangerous")
            ],
            environment: .lab,
            hazards: [.electrical],
            visualStyle: .electricalFire,
            category: .electrical,
            difficulty: .intermediate,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Solvent Vapor Buildup",
            description: "You enter the lab and detect a strong solvent smell. The ventilation is off.",
            imageIcon: "aqi.high",
            choices: [
                Choice(id: "1", text: "Turn on the light switch to see better", isCorrect: false, explanation: "Electrical switch spark can ignite solvent vapors"),
                Choice(id: "2", text: "Leave immediately, prop door open, report to safety", isCorrect: true, explanation: "No ignition sources; allow ventilation and report hazard"),
                Choice(id: "3", text: "Open windows from inside quickly", isCorrect: false, explanation: "Entering and moving around may cause static ignition"),
                Choice(id: "4", text: "Call from inside the lab", isCorrect: false, explanation: "Cell phone spark can ignite concentrated vapor")
            ],
            environment: .lab,
            hazards: [.flammableLiquid, .gas],
            visualStyle: .gasLeak,
            category: .fire,
            difficulty: .expert,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Lab Earthquake Response",
            description: "An earthquake begins while you are working with chemicals in the lab.",
            imageIcon: "waveform",
            choices: [
                Choice(id: "1", text: "Run outside immediately", isCorrect: false, explanation: "Running during earthquake risks injury from falling debris"),
                Choice(id: "2", text: "Duck under desk, hold on, turn off heat if near you", isCorrect: true, explanation: "Drop, cover, hold on; eliminate ignition sources if safely reachable"),
                Choice(id: "3", text: "Try to save your experiment", isCorrect: false, explanation: "Personal safety is the priority during an earthquake"),
                Choice(id: "4", text: "Stand in doorway", isCorrect: false, explanation: "Modern safety guidance recommends duck and cover, not doorway")
            ],
            environment: .lab,
            hazards: [],
            timeLimit: 15,
            visualStyle: .general,
            category: .evacuation,
            difficulty: .intermediate,
            hazardLevel: .high
        ),
        Scenario(
            title: "PPE Contamination",
            description: "Your lab coat and gloves are heavily contaminated with an unknown chemical.",
            imageIcon: "tshirt.fill",
            choices: [
                Choice(id: "1", text: "Keep working and change after finishing", isCorrect: false, explanation: "Contaminated PPE continues to expose you to chemical hazard"),
                Choice(id: "2", text: "Remove PPE carefully in decontamination area and report", isCorrect: true, explanation: "Remove contaminated PPE using proper protocol to prevent spread"),
                Choice(id: "3", text: "Rinse coat in regular sink", isCorrect: false, explanation: "Contaminated PPE should not be rinsed in regular sink"),
                Choice(id: "4", text: "Put additional gloves over contaminated ones", isCorrect: false, explanation: "Does not address existing contamination on lab coat")
            ],
            environment: .lab,
            hazards: [],
            visualStyle: .chemicalFire,
            category: .chemical,
            difficulty: .intermediate,
            hazardLevel: .high
        ),
        Scenario(
            title: "Peroxide Formation in Ether",
            description: "You find old ether solvent that has yellow crystals visible in the container.",
            imageIcon: "exclamationmark.octagon.fill",
            choices: [
                Choice(id: "1", text: "Open the container to see if it smells off", isCorrect: false, explanation: "Peroxide-containing ethers can detonate upon opening or agitation"),
                Choice(id: "2", text: "Do not touch it, contact safety officer immediately", isCorrect: true, explanation: "Peroxide crystals are explosive; requires expert disposal"),
                Choice(id: "3", text: "Add water to dilute the peroxides", isCorrect: false, explanation: "Do not open or disturb the container"),
                Choice(id: "4", text: "Move container to fume hood for ventilation", isCorrect: false, explanation: "Do not move potentially explosive material")
            ],
            environment: .lab,
            hazards: [.flammableLiquid],
            visualStyle: .explosion,
            category: .chemical,
            difficulty: .expert,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Hydrogen Gas Leak",
            description: "The hydrogen gas supply line is showing a leak near the gas chromatograph.",
            imageIcon: "cloud.fog.fill",
            choices: [
                Choice(id: "1", text: "Light a match to detect the leak location", isCorrect: false, explanation: "Hydrogen is highly flammable; any spark can cause explosion"),
                Choice(id: "2", text: "Close cylinder valve, ventilate, no ignition sources", isCorrect: true, explanation: "Cut fuel source, ventilate area, keep all ignition sources away"),
                Choice(id: "3", text: "Turn on fume hood fan", isCorrect: false, explanation: "Electrical fan motor can spark and ignite hydrogen"),
                Choice(id: "4", text: "Wrap leak with electrical tape", isCorrect: false, explanation: "Tape cannot seal pressurized gas leak safely")
            ],
            environment: .lab,
            hazards: [.gas, .flammableLiquid],
            visualStyle: .gasLeak,
            category: .chemical,
            difficulty: .advanced,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Centrifuge Tube Leak",
            description: "A centrifuge tube containing biological sample has leaked inside the sealed rotor.",
            imageIcon: "circle.dotted.circle.fill",
            choices: [
                Choice(id: "1", text: "Open rotor immediately to clean spill", isCorrect: false, explanation: "Aerosolized biological material must be handled with full PPE in BSC"),
                Choice(id: "2", text: "Keep rotor sealed, move to BSC, clean with disinfectant", isCorrect: true, explanation: "Contain aerosol contamination and decontaminate properly"),
                Choice(id: "3", text: "Run rotor at low speed to dry the leak", isCorrect: false, explanation: "Further spinning spreads contamination throughout rotor"),
                Choice(id: "4", text: "Ignore it, biological sample is from a healthy donor", isCorrect: false, explanation: "All biological materials require proper containment")
            ],
            environment: .lab,
            hazards: [],
            visualStyle: .general,
            category: .chemical,
            difficulty: .advanced,
            hazardLevel: .high
        ),
        Scenario(
            title: "Ammonia Smell in Lab",
            description: "A strong ammonia odor is detected near the biochemistry lab storage area.",
            imageIcon: "nose.fill",
            choices: [
                Choice(id: "1", text: "Continue working but breathe through mouth", isCorrect: false, explanation: "Ammonia causes respiratory damage regardless of breathing technique"),
                Choice(id: "2", text: "Evacuate, ventilate, locate and close ammonia source", isCorrect: true, explanation: "Remove from exposure and find the leak source"),
                Choice(id: "3", text: "Sniff to determine exact source", isCorrect: false, explanation: "Concentrated ammonia causes serious respiratory injury"),
                Choice(id: "4", text: "Use fan to blow smell away", isCorrect: false, explanation: "Fan may spread ammonia without eliminating the source")
            ],
            environment: .lab,
            hazards: [.gas],
            visualStyle: .gasLeak,
            category: .chemical,
            difficulty: .intermediate,
            hazardLevel: .high
        ),
        Scenario(
            title: "Chemical Ingestion Accident",
            description: "A lab worker accidentally swallowed a small amount of chemical from a contaminated pipette.",
            imageIcon: "drop.circle.fill",
            choices: [
                Choice(id: "1", text: "Induce vomiting immediately", isCorrect: false, explanation: "Vomiting can cause chemical burns during re-exposure to esophagus"),
                Choice(id: "2", text: "Rinse mouth, call poison control, seek emergency care", isCorrect: true, explanation: "Do not induce vomiting; get medical help and follow poison control advice"),
                Choice(id: "3", text: "Drink milk to neutralize the chemical", isCorrect: false, explanation: "Do not eat or drink without medical advice"),
                Choice(id: "4", text: "Continue working and monitor symptoms", isCorrect: false, explanation: "Chemical ingestion requires immediate medical evaluation")
            ],
            environment: .lab,
            hazards: [],
            timeLimit: 20,
            visualStyle: .general,
            category: .firstAid,
            difficulty: .advanced,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Fume Hood Sash Failure",
            description: "The fume hood sash has become stuck in the fully raised position while working with volatile chemicals.",
            imageIcon: "arrow.up.and.line.horizontal.and.arrow.down",
            choices: [
                Choice(id: "1", text: "Continue working since the hood is still on", isCorrect: false, explanation: "Without the sash barrier, chemical splash protection is lost"),
                Choice(id: "2", text: "Stop work, close containers, report malfunction", isCorrect: true, explanation: "Fume hood without sash provides no splash protection; stop work"),
                Choice(id: "3", text: "Lower sash by force", isCorrect: false, explanation: "Forcing damaged sash may break it and release glass"),
                Choice(id: "4", text: "Work from the side to avoid front exposure", isCorrect: false, explanation: "Side access does not restore full fume hood protection")
            ],
            environment: .lab,
            hazards: [],
            visualStyle: .chemicalFire,
            category: .chemical,
            difficulty: .beginner,
            hazardLevel: .medium
        ),
        Scenario(
            title: "Lab Flooding",
            description: "A water supply pipe has burst and water is flooding the lab floor.",
            imageIcon: "water.waves",
            choices: [
                Choice(id: "1", text: "Try to save chemical containers from the floor", isCorrect: false, explanation: "Risk of slipping, electrical hazard from flooded floor"),
                Choice(id: "2", text: "Turn off power, shut water valve, evacuate", isCorrect: true, explanation: "Electricity and water are lethal; cut power first"),
                Choice(id: "3", text: "Mop up water while power is on", isCorrect: false, explanation: "Standing water with live electrical equipment is fatal"),
                Choice(id: "4", text: "Open drains to remove water quickly", isCorrect: false, explanation: "Chemical-contaminated water must not go to drain")
            ],
            environment: .lab,
            hazards: [.electrical],
            visualStyle: .electricalFire,
            category: .electrical,
            difficulty: .intermediate,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Chemical Odor in Hallway",
            description: "A strong, unidentified chemical odor is noticeable throughout the lab hallway.",
            imageIcon: "wind.snow",
            choices: [
                Choice(id: "1", text: "Try to identify source by following the smell", isCorrect: false, explanation: "Walking into unknown chemical exposure is dangerous"),
                Choice(id: "2", text: "Activate alarm, evacuate building, call hazmat", isCorrect: true, explanation: "Unknown chemical exposure requires evacuation and emergency response"),
                Choice(id: "3", text: "Hold your breath and quickly check each lab", isCorrect: false, explanation: "Brief breath-holding doesn't protect from skin absorption"),
                Choice(id: "4", text: "Open windows for ventilation", isCorrect: false, explanation: "Must evacuate first; ventilation alone is insufficient")
            ],
            environment: .lab,
            hazards: [.gas],
            visualStyle: .gasLeak,
            category: .evacuation,
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
        ),
        Scenario(
            title: "Smoke Alarm Activates",
            description: "The office smoke alarm activates during a busy workday.",
            imageIcon: "alarm.fill",
            choices: [
                Choice(id: "1", text: "Ignore it and finish your work", isCorrect: false, explanation: "All smoke alarms must be treated as real emergencies"),
                Choice(id: "2", text: "Alert everyone and evacuate via stairs", isCorrect: true, explanation: "Follow evacuation procedure immediately; never use elevators"),
                Choice(id: "3", text: "Take the elevator to get out faster", isCorrect: false, explanation: "Never use elevators during fire emergency"),
                Choice(id: "4", text: "Search the office for the source first", isCorrect: false, explanation: "Do not waste time; evacuate immediately")
            ],
            environment: .office,
            hazards: [],
            timeLimit: 30,
            visualStyle: .burn,
            category: .evacuation,
            difficulty: .beginner,
            hazardLevel: .high
        ),
        Scenario(
            title: "Blocked Emergency Exit",
            description: "You notice stacked boxes are completely blocking the fire exit door.",
            imageIcon: "door.left.hand.closed",
            choices: [
                Choice(id: "1", text: "Leave it, someone else will move them", isCorrect: false, explanation: "Blocked exits are a serious safety violation requiring immediate action"),
                Choice(id: "2", text: "Move boxes immediately and report to safety officer", isCorrect: true, explanation: "Emergency exits must always remain clear and unobstructed"),
                Choice(id: "3", text: "Put a note on the boxes asking for them to be moved", isCorrect: false, explanation: "This must be addressed immediately, not through notes"),
                Choice(id: "4", text: "Add more boxes so people notice it needs clearing", isCorrect: false, explanation: "Adding more obstruction increases the hazard")
            ],
            environment: .office,
            hazards: [],
            visualStyle: .general,
            category: .evacuation,
            difficulty: .beginner,
            hazardLevel: .high
        ),
        Scenario(
            title: "Server Room Fire",
            description: "You detect smoke coming from under the server room door.",
            imageIcon: "server.rack",
            choices: [
                Choice(id: "1", text: "Open door and use water extinguisher", isCorrect: false, explanation: "Water damages servers and conducts electricity"),
                Choice(id: "2", text: "Do not open door, activate alarm, call fire services", isCorrect: true, explanation: "Keep door closed to contain fire; call professionals"),
                Choice(id: "3", text: "Open door to let smoke out", isCorrect: false, explanation: "Opening provides oxygen and spreads the fire"),
                Choice(id: "4", text: "Use CO2 extinguisher by propping door open", isCorrect: false, explanation: "Do not open door; CO2 suppression systems are built in")
            ],
            environment: .office,
            hazards: [.electrical, .heavySmoke],
            visualStyle: .electricalFire,
            category: .fire,
            difficulty: .advanced,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Colleague Collapsed",
            description: "A coworker has suddenly collapsed and is unresponsive at their desk.",
            imageIcon: "person.fill.xmark",
            choices: [
                Choice(id: "1", text: "Wait to see if they wake up on their own", isCorrect: false, explanation: "Unresponsive person needs immediate help"),
                Choice(id: "2", text: "Call 911 and begin CPR if trained", isCorrect: true, explanation: "Cardiac emergency requires immediate professional help and CPR"),
                Choice(id: "3", text: "Give them water and check their pulse", isCorrect: false, explanation: "Unresponsive person cannot safely drink water; call 911"),
                Choice(id: "4", text: "Put them in their chair and loosen clothing only", isCorrect: false, explanation: "Call 911 immediately for unresponsive colleague")
            ],
            environment: .office,
            hazards: [],
            timeLimit: 20,
            visualStyle: .general,
            category: .firstAid,
            difficulty: .intermediate,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Earthquake in Office",
            description: "The building begins shaking during an earthquake while you are at your desk.",
            imageIcon: "waveform",
            choices: [
                Choice(id: "1", text: "Run to the window to look outside", isCorrect: false, explanation: "Windows can shatter; stay away from them"),
                Choice(id: "2", text: "Drop, cover under desk, hold on until shaking stops", isCorrect: true, explanation: "Drop, Cover, and Hold On protects from falling objects"),
                Choice(id: "3", text: "Run outside immediately", isCorrect: false, explanation: "Running during shaking risks falling; shelter in place first"),
                Choice(id: "4", text: "Stand in doorway", isCorrect: false, explanation: "Modern guidance recommends desk cover, not doorway")
            ],
            environment: .office,
            hazards: [],
            timeLimit: 15,
            visualStyle: .general,
            category: .evacuation,
            difficulty: .intermediate,
            hazardLevel: .high
        ),
        Scenario(
            title: "Carbon Monoxide Alert",
            description: "The office CO detector starts alarming repeatedly.",
            imageIcon: "exclamationmark.shield.fill",
            choices: [
                Choice(id: "1", text: "Reset the alarm and check if it sounds again", isCorrect: false, explanation: "CO is odorless and lethal; treat every alarm as real"),
                Choice(id: "2", text: "Immediately evacuate the building and call 911", isCorrect: true, explanation: "CO poisoning can be fatal; evacuate and call emergency services"),
                Choice(id: "3", text: "Open windows and stay at your desk", isCorrect: false, explanation: "Source of CO must be found; evacuate the building"),
                Choice(id: "4", text: "Look for the source before evacuating", isCorrect: false, explanation: "Do not search for CO source; evacuate immediately")
            ],
            environment: .office,
            hazards: [.gas],
            timeLimit: 20,
            visualStyle: .gasLeak,
            category: .evacuation,
            difficulty: .beginner,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Choking Coworker",
            description: "A colleague at the lunch table is clutching their throat and cannot speak.",
            imageIcon: "person.fill.questionmark",
            choices: [
                Choice(id: "1", text: "Give them water to wash it down", isCorrect: false, explanation: "Water cannot help if airway is completely obstructed"),
                Choice(id: "2", text: "Perform Heimlich maneuver and call 911", isCorrect: true, explanation: "Abdominal thrusts can dislodge obstruction; call for help"),
                Choice(id: "3", text: "Tell them to cough harder", isCorrect: false, explanation: "If they cannot speak or cough effectively, act immediately"),
                Choice(id: "4", text: "Wait a moment to see if it clears", isCorrect: false, explanation: "Complete airway obstruction is a life-threatening emergency")
            ],
            environment: .office,
            hazards: [],
            timeLimit: 20,
            visualStyle: .general,
            category: .firstAid,
            difficulty: .intermediate,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Suspicious Package",
            description: "An unfamiliar package with no return address is delivered to the office and is leaking powder.",
            imageIcon: "shippingbox.fill",
            choices: [
                Choice(id: "1", text: "Open it to see what's inside", isCorrect: false, explanation: "Unknown powder from suspicious package may be hazardous or toxic"),
                Choice(id: "2", text: "Do not touch, leave area, wash hands, call 911", isCorrect: true, explanation: "Suspected hazardous material requires emergency response"),
                Choice(id: "3", text: "Shake it to see if anything rattles", isCorrect: false, explanation: "Handling suspicious package spreads potential contamination"),
                Choice(id: "4", text: "Put it in the trash immediately", isCorrect: false, explanation: "Do not handle suspected hazardous package")
            ],
            environment: .office,
            hazards: [],
            visualStyle: .general,
            category: .chemical,
            difficulty: .intermediate,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Trash Can Fire",
            description: "A trash can in the office is smoldering and starting to produce smoke.",
            imageIcon: "trash.fill",
            choices: [
                Choice(id: "1", text: "Stomp out the fire with your foot", isCorrect: false, explanation: "Spreads burning material and risks burns to feet"),
                Choice(id: "2", text: "Use nearby fire extinguisher and pull fire alarm", isCorrect: true, explanation: "Extinguish small fire and activate alarm for safety"),
                Choice(id: "3", text: "Fan the smoke away and ignore it", isCorrect: false, explanation: "Smoldering waste can reignite into major fire"),
                Choice(id: "4", text: "Pour coffee on it", isCorrect: false, explanation: "Insufficient liquid and electrical hazard if near power strips")
            ],
            environment: .office,
            hazards: [.heavySmoke],
            visualStyle: .burn,
            category: .fire,
            difficulty: .beginner,
            hazardLevel: .medium
        ),
        Scenario(
            title: "Allergic Reaction",
            description: "A coworker who ate from a shared lunch is developing hives and having trouble breathing.",
            imageIcon: "cross.case.fill",
            choices: [
                Choice(id: "1", text: "Give antihistamine tablet and wait 20 minutes", isCorrect: false, explanation: "Breathing difficulty suggests anaphylaxis; requires epinephrine and 911"),
                Choice(id: "2", text: "Call 911 immediately; use EpiPen if available", isCorrect: true, explanation: "Anaphylaxis is life-threatening; epinephrine and emergency services needed"),
                Choice(id: "3", text: "Have them lie down and rest", isCorrect: false, explanation: "Lying down can worsen breathing difficulty; call 911 immediately"),
                Choice(id: "4", text: "Take them to the bathroom to splash cold water", isCorrect: false, explanation: "Call 911 immediately; do not delay with home remedies")
            ],
            environment: .office,
            hazards: [],
            timeLimit: 20,
            visualStyle: .general,
            category: .firstAid,
            difficulty: .advanced,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Smoke Under Door",
            description: "You see smoke coming under your office door during a fire alarm.",
            imageIcon: "smoke.fill",
            choices: [
                Choice(id: "1", text: "Open the door quickly and run through smoke", isCorrect: false, explanation: "Smoke-filled corridor is immediately dangerous to life"),
                Choice(id: "2", text: "Feel door for heat, if hot stay and signal for help", isCorrect: true, explanation: "Hot door means fire nearby; stay in room and signal from window"),
                Choice(id: "3", text: "Open door slowly to let smoke settle", isCorrect: false, explanation: "Opening releases more smoke and exposes you to fire"),
                Choice(id: "4", text: "Hide under desk until fire passes", isCorrect: false, explanation: "Smoke is toxic; signal from window and call 911")
            ],
            environment: .office,
            hazards: [.heavySmoke],
            timeLimit: 30,
            visualStyle: .burn,
            category: .evacuation,
            difficulty: .advanced,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Chemical Smell from HVAC",
            description: "A chemical smell is being distributed through the office HVAC system.",
            imageIcon: "air.purifier.fill",
            choices: [
                Choice(id: "1", text: "Adjust your own vent to reduce the smell", isCorrect: false, explanation: "Source must be found and eliminated; adjusting vent doesn't help"),
                Choice(id: "2", text: "Turn off HVAC, evacuate, investigate source", isCorrect: true, explanation: "Stop distribution of chemical through HVAC and evacuate"),
                Choice(id: "3", text: "Light a candle to mask the smell", isCorrect: false, explanation: "Open flame with unknown chemical is an ignition hazard"),
                Choice(id: "4", text: "Open windows to dilute the smell", isCorrect: false, explanation: "Must stop HVAC distribution of chemical first")
            ],
            environment: .office,
            hazards: [.gas],
            visualStyle: .gasLeak,
            category: .chemical,
            difficulty: .intermediate,
            hazardLevel: .high
        ),
        Scenario(
            title: "Severe Bleeding Injury",
            description: "A coworker has a deep laceration from a broken glass door and is bleeding heavily.",
            imageIcon: "bandage.fill",
            choices: [
                Choice(id: "1", text: "Have them sit quietly and wait for ambulance", isCorrect: false, explanation: "Severe bleeding requires immediate pressure to control"),
                Choice(id: "2", text: "Apply firm direct pressure and call 911", isCorrect: true, explanation: "Control bleeding with pressure immediately while calling for help"),
                Choice(id: "3", text: "Apply a tourniquet to their arm as a precaution", isCorrect: false, explanation: "Tourniquets are last resort; start with direct pressure"),
                Choice(id: "4", text: "Clean the wound thoroughly before stopping bleeding", isCorrect: false, explanation: "Stop bleeding first; cleaning comes after hemorrhage control")
            ],
            environment: .office,
            hazards: [],
            timeLimit: 20,
            visualStyle: .general,
            category: .firstAid,
            difficulty: .intermediate,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Power Outage Response",
            description: "Total power outage affects the entire office building with no backup lighting.",
            imageIcon: "bolt.slash.fill",
            choices: [
                Choice(id: "1", text: "Continue working using phone flashlight", isCorrect: false, explanation: "Should follow outage protocol and wait for official guidance"),
                Choice(id: "2", text: "Stay calm, use emergency lighting if available, follow exit signs", isCorrect: true, explanation: "Emergency lighting exists for this; follow marked evacuation routes"),
                Choice(id: "3", text: "Light candles for illumination", isCorrect: false, explanation: "Candles are fire hazards during an emergency"),
                Choice(id: "4", text: "Try to reset all the circuit breakers yourself", isCorrect: false, explanation: "Building electrical systems require licensed personnel")
            ],
            environment: .office,
            hazards: [],
            visualStyle: .general,
            category: .evacuation,
            difficulty: .beginner,
            hazardLevel: .medium
        ),
        Scenario(
            title: "Gas Smell in Office",
            description: "A strong natural gas smell is detected in the open office area.",
            imageIcon: "cloud.fog.fill",
            choices: [
                Choice(id: "1", text: "Turn on fans to disperse the gas", isCorrect: false, explanation: "Electrical fans can spark and ignite gas"),
                Choice(id: "2", text: "Avoid switches, evacuate building, call gas company", isCorrect: true, explanation: "No electrical switching; evacuate and call professionals"),
                Choice(id: "3", text: "Identify the leak source before evacuating", isCorrect: false, explanation: "Do not search for gas leak; evacuate immediately"),
                Choice(id: "4", text: "Open windows then continue working", isCorrect: false, explanation: "Must evacuate entirely; gas accumulation is explosive")
            ],
            environment: .office,
            hazards: [.gas],
            timeLimit: 20,
            visualStyle: .gasLeak,
            category: .evacuation,
            difficulty: .intermediate,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Electrical Fire in Break Room",
            description: "A small electrical fire has started behind the break room refrigerator.",
            imageIcon: "refrigerator.fill",
            choices: [
                Choice(id: "1", text: "Pour water on the fire", isCorrect: false, explanation: "Water conducts electricity; never use on electrical fires"),
                Choice(id: "2", text: "Use CO2 extinguisher after cutting power at breaker", isCorrect: true, explanation: "Cut power first, then use appropriate extinguisher"),
                Choice(id: "3", text: "Pull refrigerator away to access fire", isCorrect: false, explanation: "Moving electrical appliance during fire risks shock and spread"),
                Choice(id: "4", text: "Put damp towel on fire to smother it", isCorrect: false, explanation: "Wet materials near electrical fire are dangerous")
            ],
            environment: .office,
            hazards: [.electrical],
            visualStyle: .electricalFire,
            category: .fire,
            difficulty: .intermediate,
            hazardLevel: .high
        ),
        Scenario(
            title: "Asthma Attack",
            description: "A colleague is having a severe asthma attack and their inhaler isn't working.",
            imageIcon: "lungs.fill",
            choices: [
                Choice(id: "1", text: "Give them coffee or a caffeinated drink", isCorrect: false, explanation: "Caffeine is not a treatment for severe asthma attack"),
                Choice(id: "2", text: "Call 911; have them sit upright and stay calm", isCorrect: true, explanation: "Severe asthma unresponsive to inhaler requires emergency care"),
                Choice(id: "3", text: "Have them lie flat to rest", isCorrect: false, explanation: "Lying flat makes breathing harder; keep them upright"),
                Choice(id: "4", text: "Take them outside for fresh air", isCorrect: false, explanation: "Fresh air alone won't treat severe asthma; call 911")
            ],
            environment: .office,
            hazards: [],
            timeLimit: 20,
            visualStyle: .general,
            category: .firstAid,
            difficulty: .intermediate,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Office Flood",
            description: "A pipe has burst and water is rapidly filling the ground floor office.",
            imageIcon: "water.waves",
            choices: [
                Choice(id: "1", text: "Try to save computers and documents first", isCorrect: false, explanation: "Electrical equipment in flood water is lethal"),
                Choice(id: "2", text: "Turn off power, evacuate to higher floor, call facilities", isCorrect: true, explanation: "Electricity and flood water together are fatal; evacuate"),
                Choice(id: "3", text: "Start mopping up immediately", isCorrect: false, explanation: "With power on, flood water in office is electrocution risk"),
                Choice(id: "4", text: "Block doorways with furniture to redirect water", isCorrect: false, explanation: "Do not stay in electrically hazardous environment")
            ],
            environment: .office,
            hazards: [.electrical],
            visualStyle: .electricalFire,
            category: .evacuation,
            difficulty: .intermediate,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Active Fire During Evacuation",
            description: "While evacuating, you find flames blocking your designated exit route.",
            imageIcon: "flame.fill",
            choices: [
                Choice(id: "1", text: "Push through the flames quickly", isCorrect: false, explanation: "Running through flames will cause severe burns and may be fatal"),
                Choice(id: "2", text: "Use alternate exit route; notify warden of blocked route", isCorrect: true, explanation: "Use alternate exit and inform emergency personnel of blocked route"),
                Choice(id: "3", text: "Go back to your desk and call for help", isCorrect: false, explanation: "Look for alternate exits before retreating"),
                Choice(id: "4", text: "Fight the fire to clear the path", isCorrect: false, explanation: "Never fight fire in your evacuation path; find alternate route")
            ],
            environment: .office,
            hazards: [.heavySmoke],
            timeLimit: 30,
            visualStyle: .burn,
            category: .evacuation,
            difficulty: .intermediate,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Printer Toner Fire",
            description: "A laser printer is smoking and smells like burning toner.",
            imageIcon: "printer.dotmatrix.fill",
            choices: [
                Choice(id: "1", text: "Blow into the printer to cool it down", isCorrect: false, explanation: "Toner powder is flammable; blowing spreads combustible dust"),
                Choice(id: "2", text: "Unplug printer and let it cool down in open area", isCorrect: true, explanation: "Cut power and allow cooling away from other materials"),
                Choice(id: "3", text: "Open printer to see what's burning", isCorrect: false, explanation: "Opening provides oxygen to smoldering materials"),
                Choice(id: "4", text: "Keep printing to see if it clears up", isCorrect: false, explanation: "Continuing to operate a smoking printer is dangerous")
            ],
            environment: .office,
            hazards: [.electrical, .heavySmoke],
            visualStyle: .electricalFire,
            category: .electrical,
            difficulty: .beginner,
            hazardLevel: .medium
        ),
        Scenario(
            title: "Fainting Employee",
            description: "A coworker suddenly faints and collapses in the hallway.",
            imageIcon: "person.fill.xmark",
            choices: [
                Choice(id: "1", text: "Prop them sitting against the wall", isCorrect: false, explanation: "Fainted person should lie flat to restore blood flow to brain"),
                Choice(id: "2", text: "Lay flat, elevate legs, loosen clothing, call for help", isCorrect: true, explanation: "Proper recovery position helps blood flow; monitor and seek help"),
                Choice(id: "3", text: "Give them strong coffee to revive them", isCorrect: false, explanation: "Unconscious person cannot safely swallow anything"),
                Choice(id: "4", text: "Shake them vigorously to wake them up", isCorrect: false, explanation: "Vigorous shaking can injure someone who has fainted")
            ],
            environment: .office,
            hazards: [],
            visualStyle: .general,
            category: .firstAid,
            difficulty: .beginner,
            hazardLevel: .medium
        ),
        Scenario(
            title: "Extension Cord Overload",
            description: "An extension cord running multiple high-powered devices is very hot to touch.",
            imageIcon: "cable.connector.horizontal",
            choices: [
                Choice(id: "1", text: "Add a power strip to the extension cord", isCorrect: false, explanation: "Daisy-chaining extension cords increases fire risk"),
                Choice(id: "2", text: "Unplug all devices and let cord cool, report to facilities", isCorrect: true, explanation: "Hot extension cord is a fire hazard; reduce load and report"),
                Choice(id: "3", text: "Continue using it carefully", isCorrect: false, explanation: "Overloaded hot cord can start a fire at any time"),
                Choice(id: "4", text: "Wrap in electrical tape to insulate the heat", isCorrect: false, explanation: "Tape doesn't fix overload; reduces heat dissipation making it worse")
            ],
            environment: .office,
            hazards: [.electrical],
            visualStyle: .electricalFire,
            category: .electrical,
            difficulty: .beginner,
            hazardLevel: .high
        ),
        Scenario(
            title: "Eye Injury from Chemical",
            description: "A cleaning product has splashed into a janitor's eyes in the office restroom.",
            imageIcon: "eye.fill",
            choices: [
                Choice(id: "1", text: "Apply eye drops and cover with patch", isCorrect: false, explanation: "Chemical eye exposure requires flushing, not patching"),
                Choice(id: "2", text: "Flush eyes at sink for 15+ minutes and seek medical care", isCorrect: true, explanation: "Continuous water flushing is essential for chemical eye exposure"),
                Choice(id: "3", text: "Rub eyes to remove irritant", isCorrect: false, explanation: "Rubbing spreads chemical and increases corneal damage"),
                Choice(id: "4", text: "Apply eye drops every 5 minutes and rest", isCorrect: false, explanation: "Eye drops are insufficient; must flush continuously for 15 minutes")
            ],
            environment: .office,
            hazards: [],
            timeLimit: 20,
            visualStyle: .general,
            category: .firstAid,
            difficulty: .intermediate,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Conference Room Fire",
            description: "A projector in the conference room catches fire during a meeting.",
            imageIcon: "tv.fill",
            choices: [
                Choice(id: "1", text: "Use water from a nearby pitcher to extinguish", isCorrect: false, explanation: "Electrical fire cannot be fought with water"),
                Choice(id: "2", text: "Evacuate room, pull alarm, use CO2 extinguisher", isCorrect: true, explanation: "Get people out first, then use appropriate extinguisher"),
                Choice(id: "3", text: "Cover with a tablecloth to smother flames", isCorrect: false, explanation: "Tablecloth may ignite; use proper CO2 extinguisher"),
                Choice(id: "4", text: "Continue meeting in another corner away from fire", isCorrect: false, explanation: "Evacuate the room immediately; fire can spread quickly")
            ],
            environment: .office,
            hazards: [.electrical, .heavySmoke],
            visualStyle: .electricalFire,
            category: .fire,
            difficulty: .intermediate,
            hazardLevel: .high
        ),
        Scenario(
            title: "Slippery Floor Injury",
            description: "A coworker has slipped on a wet floor and is lying on the ground in pain.",
            imageIcon: "figure.fall",
            choices: [
                Choice(id: "1", text: "Help them stand up immediately", isCorrect: false, explanation: "Moving someone who may have a back injury can worsen it"),
                Choice(id: "2", text: "Keep them still, call for first aid, warn others of hazard", isCorrect: true, explanation: "Stabilize patient, get help, and prevent additional injuries"),
                Choice(id: "3", text: "Give them pain medication from first aid kit", isCorrect: false, explanation: "Do not give medication without medical authority"),
                Choice(id: "4", text: "Have them walk it off carefully", isCorrect: false, explanation: "Potential fracture or spinal injury requires professional assessment")
            ],
            environment: .office,
            hazards: [],
            visualStyle: .general,
            category: .firstAid,
            difficulty: .beginner,
            hazardLevel: .medium
        ),
        Scenario(
            title: "Coworker Heart Attack Signs",
            description: "A colleague is clutching their chest, sweating, and complaining of jaw pain.",
            imageIcon: "heart.fill",
            choices: [
                Choice(id: "1", text: "Have them walk to the car for a hospital trip", isCorrect: false, explanation: "Physical exertion worsens heart attack; call 911 immediately"),
                Choice(id: "2", text: "Call 911 immediately, keep them calm and still", isCorrect: true, explanation: "Heart attack requires emergency services; minimize exertion"),
                Choice(id: "3", text: "Give them aspirin from the first aid kit", isCorrect: false, explanation: "Without confirmed diagnosis and medical direction, do not give medication"),
                Choice(id: "4", text: "Lie them flat and elevate their legs", isCorrect: false, explanation: "Heart attack patients do better sitting up; call 911 first")
            ],
            environment: .office,
            hazards: [],
            timeLimit: 20,
            visualStyle: .general,
            category: .firstAid,
            difficulty: .advanced,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Falling Object from Shelf",
            description: "An overloaded storage shelf is tilting and heavy items are about to fall.",
            imageIcon: "square.stack.fill",
            choices: [
                Choice(id: "1", text: "Try to catch the falling items", isCorrect: false, explanation: "Heavy falling objects can cause serious crush injuries"),
                Choice(id: "2", text: "Clear the area immediately and warn others", isCorrect: true, explanation: "Prevent crush injuries by keeping people away from falling zone"),
                Choice(id: "3", text: "Push the shelf back against the wall", isCorrect: false, explanation: "Approaching unstable shelf risks being hit by falling items"),
                Choice(id: "4", text: "Remove items one at a time to lighten it", isCorrect: false, explanation: "Do not approach unstable shelf; clear the area first")
            ],
            environment: .office,
            hazards: [],
            visualStyle: .general,
            category: .mechanical,
            difficulty: .beginner,
            hazardLevel: .medium
        ),
        Scenario(
            title: "Air Conditioner Unit Fire",
            description: "A window air conditioning unit is producing smoke and sparks.",
            imageIcon: "air.conditioner.horizontal.fill",
            choices: [
                Choice(id: "1", text: "Spray water on the unit from outside", isCorrect: false, explanation: "Electrical fire + water = electrocution risk"),
                Choice(id: "2", text: "Turn off circuit breaker for AC and evacuate area", isCorrect: true, explanation: "Cut power at breaker before using extinguisher on electrical fire"),
                Choice(id: "3", text: "Pull the unit out of the window", isCorrect: false, explanation: "Moving electrical fire risks spreading it and causing injury"),
                Choice(id: "4", text: "Open windows near the unit for ventilation", isCorrect: false, explanation: "Opening windows near electrical fire provides oxygen")
            ],
            environment: .office,
            hazards: [.electrical, .heavySmoke],
            visualStyle: .electricalFire,
            category: .electrical,
            difficulty: .intermediate,
            hazardLevel: .high
        ),
        Scenario(
            title: "Sprinkler System Activation",
            description: "The office sprinkler system has activated in one section of the office.",
            imageIcon: "drop.fill",
            choices: [
                Choice(id: "1", text: "Try to stop the sprinklers to save equipment", isCorrect: false, explanation: "Sprinklers activated for a reason; do not interfere"),
                Choice(id: "2", text: "Evacuate the building and investigate from outside", isCorrect: true, explanation: "Sprinkler activation indicates fire; evacuate immediately"),
                Choice(id: "3", text: "Cover computers with chairs to protect them", isCorrect: false, explanation: "Get yourself out; do not risk injury protecting equipment"),
                Choice(id: "4", text: "Stand under dry areas of ceiling and keep working", isCorrect: false, explanation: "Sprinkler activation means evacuate; fire may be nearby")
            ],
            environment: .office,
            hazards: [],
            timeLimit: 30,
            visualStyle: .burn,
            category: .evacuation,
            difficulty: .beginner,
            hazardLevel: .high
        ),
        Scenario(
            title: "Diabetic Emergency",
            description: "A coworker with known diabetes is confused, sweating, and trembling.",
            imageIcon: "medical.thermometer.fill",
            choices: [
                Choice(id: "1", text: "Give them insulin from the first aid kit", isCorrect: false, explanation: "Insulin given to someone with low blood sugar would be dangerous"),
                Choice(id: "2", text: "Give sugar or juice if conscious, call 911 if worsening", isCorrect: true, explanation: "Low blood sugar symptoms improve with glucose; monitor and call 911"),
                Choice(id: "3", text: "Have them lie down and rest quietly", isCorrect: false, explanation: "Low blood sugar requires glucose, not just rest"),
                Choice(id: "4", text: "Give strong black coffee for the sugar", isCorrect: false, explanation: "Coffee's sugar amount is insufficient; use juice or glucose tablets")
            ],
            environment: .office,
            hazards: [],
            timeLimit: 30,
            visualStyle: .general,
            category: .firstAid,
            difficulty: .advanced,
            hazardLevel: .high
        ),
        Scenario(
            title: "Building Lockdown",
            description: "An announcement states there is an active security threat in the building.",
            imageIcon: "lock.fill",
            choices: [
                Choice(id: "1", text: "Look out windows to see what's happening", isCorrect: false, explanation: "Stay away from windows during security threat"),
                Choice(id: "2", text: "Lock doors, turn off lights, silence phones, shelter in place", isCorrect: true, explanation: "Secure your location and remain hidden during lockdown"),
                Choice(id: "3", text: "Run outside to evacuate the building", isCorrect: false, explanation: "Active threat outside means shelter in place is often safer"),
                Choice(id: "4", text: "Go to hallway to see what is happening", isCorrect: false, explanation: "Hallways expose you; secure a room and shelter in place")
            ],
            environment: .office,
            hazards: [],
            timeLimit: 20,
            visualStyle: .general,
            category: .evacuation,
            difficulty: .advanced,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Fire Extinguisher Discharge",
            description: "Knowing a small trash can fire has started, you grab the nearest fire extinguisher.",
            imageIcon: "cylinder.fill",
            choices: [
                Choice(id: "1", text: "Aim at the flames and spray", isCorrect: false, explanation: "Must aim at the base of the fire, not at the flames"),
                Choice(id: "2", text: "Use PASS: Pull pin, Aim at base, Squeeze, Sweep", isCorrect: true, explanation: "PASS technique is correct fire extinguisher operation"),
                Choice(id: "3", text: "Spray in circular motions around fire", isCorrect: false, explanation: "Sweeping at base of fire, not circular motions"),
                Choice(id: "4", text: "Hold extinguisher upside down to empty it faster", isCorrect: false, explanation: "Most extinguishers do not work upside down")
            ],
            environment: .office,
            hazards: [],
            visualStyle: .burn,
            category: .fire,
            difficulty: .beginner,
            hazardLevel: .medium
        ),
        Scenario(
            title: "Stuck in Elevator",
            description: "The elevator stops between floors and smells like burning rubber.",
            imageIcon: "arrow.up.and.down.square.fill",
            choices: [
                Choice(id: "1", text: "Try to pry open the elevator doors", isCorrect: false, explanation: "Prying elevator doors can cause fall down shaft"),
                Choice(id: "2", text: "Press emergency button, call for help, do not force doors", isCorrect: true, explanation: "Use emergency communication; wait for trained rescue"),
                Choice(id: "3", text: "Jump up and down to reset the elevator", isCorrect: false, explanation: "This does not work and could damage elevator further"),
                Choice(id: "4", text: "Force ceiling hatch open and climb out", isCorrect: false, explanation: "Climbing on elevator equipment is extremely dangerous")
            ],
            environment: .office,
            hazards: [.electrical],
            visualStyle: .mechanicalFire,
            category: .evacuation,
            difficulty: .intermediate,
            hazardLevel: .high
        ),
        Scenario(
            title: "Injury from Broken Office Chair",
            description: "The hydraulic mechanism in an office chair has failed explosively, injuring a coworker.",
            imageIcon: "chair.fill",
            choices: [
                Choice(id: "1", text: "Give them painkillers from the first aid kit", isCorrect: false, explanation: "Do not give medication; perform proper first aid and call for help"),
                Choice(id: "2", text: "Keep them still, call for first aid, call 911 for severe injuries", isCorrect: true, explanation: "Stabilize and get proper medical help for explosive mechanism injury"),
                Choice(id: "3", text: "Have them sit in another chair to rest", isCorrect: false, explanation: "Unknown injuries require professional assessment"),
                Choice(id: "4", text: "Try to remove any embedded debris yourself", isCorrect: false, explanation: "Do not remove embedded objects; stabilize and get medical help")
            ],
            environment: .office,
            hazards: [],
            timeLimit: 30,
            visualStyle: .general,
            category: .firstAid,
            difficulty: .intermediate,
            hazardLevel: .high
        ),
        Scenario(
            title: "Chemical Spill in Supply Room",
            description: "Cleaning chemicals have been knocked over and are mixing on the supply room floor.",
            imageIcon: "flask.fill",
            choices: [
                Choice(id: "1", text: "Mop them up quickly before they spread", isCorrect: false, explanation: "Mixed cleaning chemicals can produce toxic chlorine gas"),
                Choice(id: "2", text: "Close the door, do not enter, call hazmat or facilities", isCorrect: true, explanation: "Mixed cleaning chemicals are potentially toxic; treat as hazmat"),
                Choice(id: "3", text: "Pour water on them to dilute the chemicals", isCorrect: false, explanation: "Water can cause violent reactions with some cleaning chemicals"),
                Choice(id: "4", text: "Open windows and fan the fumes out", isCorrect: false, explanation: "Do not enter the room; evacuate and call for help")
            ],
            environment: .office,
            hazards: [.gas],
            visualStyle: .chemicalFire,
            category: .chemical,
            difficulty: .intermediate,
            hazardLevel: .high
        ),
        Scenario(
            title: "AED Emergency",
            description: "A coworker has had a cardiac arrest and you have access to an AED.",
            imageIcon: "waveform.path.ecg.rectangle.fill",
            choices: [
                Choice(id: "1", text: "Wait for paramedics to use the AED", isCorrect: false, explanation: "Every minute without defibrillation reduces survival by 10%"),
                Choice(id: "2", text: "Turn on AED, follow its instructions, begin use immediately", isCorrect: true, explanation: "AEDs are designed for lay people; use immediately while calling 911"),
                Choice(id: "3", text: "Avoid AED as you are not trained", isCorrect: false, explanation: "AEDs have voice instructions; use it, any use is better than none"),
                Choice(id: "4", text: "Do CPR for 10 minutes before using AED", isCorrect: false, explanation: "AED should be used as soon as possible; do CPR only while AED prepares")
            ],
            environment: .office,
            hazards: [],
            timeLimit: 20,
            visualStyle: .general,
            category: .firstAid,
            difficulty: .advanced,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Photocopier Fire",
            description: "The photocopier jams and catches fire inside the housing.",
            imageIcon: "doc.fill",
            choices: [
                Choice(id: "1", text: "Open copier to access the fire", isCorrect: false, explanation: "Opening provides oxygen and exposes you to fire"),
                Choice(id: "2", text: "Unplug immediately, pull fire alarm, use extinguisher if small", isCorrect: true, explanation: "Cut power, activate alarm, use correct extinguisher type"),
                Choice(id: "3", text: "Try pressing cancel on the copier panel", isCorrect: false, explanation: "Must cut power completely, not just cancel the job"),
                Choice(id: "4", text: "Pour water into paper tray to reach fire", isCorrect: false, explanation: "Water into electrical device causes electrocution risk")
            ],
            environment: .office,
            hazards: [.electrical, .heavySmoke],
            visualStyle: .electricalFire,
            category: .fire,
            difficulty: .intermediate,
            hazardLevel: .high
        ),
        Scenario(
            title: "Lightning Strike Nearby",
            description: "A lightning strike has hit near the building and electronics are surging.",
            imageIcon: "cloud.bolt.fill",
            choices: [
                Choice(id: "1", text: "Continue working, lightning rods protect the building", isCorrect: false, explanation: "Power surges can damage equipment and start fires"),
                Choice(id: "2", text: "Shut down computers, unplug sensitive equipment", isCorrect: true, explanation: "Protect equipment from power surges during electrical storm"),
                Choice(id: "3", text: "Hold up metal rulers to ground the surge", isCorrect: false, explanation: "Never hold metal objects during lightning storm"),
                Choice(id: "4", text: "Stand near windows to assess storm severity", isCorrect: false, explanation: "Windows are dangerous during lightning storm")
            ],
            environment: .office,
            hazards: [.electrical],
            visualStyle: .electricalFire,
            category: .electrical,
            difficulty: .beginner,
            hazardLevel: .medium
        ),
        Scenario(
            title: "Filing Cabinet Tip-Over",
            description: "A tall metal filing cabinet with multiple drawers open is leaning dangerously.",
            imageIcon: "cabinet.fill",
            choices: [
                Choice(id: "1", text: "Try to push it back upright", isCorrect: false, explanation: "A full filing cabinet can weigh hundreds of pounds and crush you"),
                Choice(id: "2", text: "Clear area below it and call facilities for help", isCorrect: true, explanation: "Prevent crush injuries; let trained personnel handle heavy furniture"),
                Choice(id: "3", text: "Close all drawers quickly to reduce weight", isCorrect: false, explanation: "Approaching an unstable heavy cabinet is dangerous"),
                Choice(id: "4", text: "Tie it to the wall with a phone charger cable", isCorrect: false, explanation: "Insufficient strength; proper straps and anchors are needed")
            ],
            environment: .office,
            hazards: [],
            visualStyle: .general,
            category: .mechanical,
            difficulty: .beginner,
            hazardLevel: .medium
        ),
        Scenario(
            title: "UPS Battery Fire",
            description: "The UPS (battery backup) unit in the server room is on fire.",
            imageIcon: "battery.100.bolt",
            choices: [
                Choice(id: "1", text: "Pour water on the UPS battery fire", isCorrect: false, explanation: "Battery fires involve electrical and chemical hazards; water dangerous"),
                Choice(id: "2", text: "Evacuate, cut power, call fire services", isCorrect: true, explanation: "Battery fires require professional response; evacuate immediately"),
                Choice(id: "3", text: "Move UPS outside to contain the fire", isCorrect: false, explanation: "Do not handle burning battery equipment"),
                Choice(id: "4", text: "Use CO2 extinguisher on the UPS", isCorrect: false, explanation: "CO2 is not fully effective on lithium battery fires; evacuate")
            ],
            environment: .office,
            hazards: [.electrical],
            timeLimit: 30,
            visualStyle: .electricalFire,
            category: .electrical,
            difficulty: .advanced,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Hazardous Mail Substance",
            description: "While opening mail, you find a letter that releases an oily substance on your hands.",
            imageIcon: "envelope.open.fill",
            choices: [
                Choice(id: "1", text: "Wash hands quickly and go back to work", isCorrect: false, explanation: "Unknown substance on skin requires full decontamination and reporting"),
                Choice(id: "2", text: "Do not touch face, wash hands thoroughly, call 911 and security", isCorrect: true, explanation: "Unknown substance is potential hazmat; report immediately"),
                Choice(id: "3", text: "Shake the letter to see if more falls out", isCorrect: false, explanation: "Do not handle suspected hazardous mail further"),
                Choice(id: "4", text: "Seal the letter in a new envelope and send to HR", isCorrect: false, explanation: "Suspected hazmat material requires emergency services, not HR")
            ],
            environment: .office,
            hazards: [],
            visualStyle: .general,
            category: .chemical,
            difficulty: .advanced,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Seizure in Office",
            description: "A coworker suddenly has a seizure and falls from their chair to the floor.",
            imageIcon: "brain.fill",
            choices: [
                Choice(id: "1", text: "Hold them down to stop the convulsions", isCorrect: false, explanation: "Do not restrain someone having a seizure; risk of injury"),
                Choice(id: "2", text: "Clear space around them, protect head, time the seizure", isCorrect: true, explanation: "Prevent injury from surrounding objects; monitor duration and call 911"),
                Choice(id: "3", text: "Put something in their mouth to prevent biting", isCorrect: false, explanation: "Never put anything in mouth of someone having seizure"),
                Choice(id: "4", text: "Give them water when the shaking stops", isCorrect: false, explanation: "Do not give food/drink until fully conscious and alert")
            ],
            environment: .office,
            hazards: [],
            timeLimit: 20,
            visualStyle: .general,
            category: .firstAid,
            difficulty: .intermediate,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Elevator Fire Alarm",
            description: "The fire alarm activates while you are waiting for the elevator.",
            imageIcon: "arrow.up.and.down.circle.fill",
            choices: [
                Choice(id: "1", text: "Take the elevator to get to ground floor faster", isCorrect: false, explanation: "Never use elevator during fire alarm; use stairs"),
                Choice(id: "2", text: "Use the stairs and follow evacuation procedure", isCorrect: true, explanation: "Stairs are always the correct evacuation route during fire"),
                Choice(id: "3", text: "Wait for elevator but hold the door", isCorrect: false, explanation: "Elevators become death traps in fires; use stairs"),
                Choice(id: "4", text: "Go back to desk to get belongings then evacuate", isCorrect: false, explanation: "Leave immediately; belongings are not worth risking your life")
            ],
            environment: .office,
            hazards: [],
            timeLimit: 30,
            visualStyle: .burn,
            category: .evacuation,
            difficulty: .beginner,
            hazardLevel: .high
        ),
        Scenario(
            title: "Chemical Burn from Cleaning",
            description: "A facilities worker has chemical burns from an industrial cleaner.",
            imageIcon: "bandage.fill",
            choices: [
                Choice(id: "1", text: "Apply butter or lotion to soothe the burn", isCorrect: false, explanation: "Oils and butter trap heat and chemical, worsening injury"),
                Choice(id: "2", text: "Flush with cool water for 20 minutes and seek medical care", isCorrect: true, explanation: "Continuous flushing removes chemical; medical assessment required"),
                Choice(id: "3", text: "Wrap in dry bandage immediately", isCorrect: false, explanation: "Must flush chemical off before bandaging"),
                Choice(id: "4", text: "Apply ice to reduce burning sensation", isCorrect: false, explanation: "Ice constricts blood vessels and increases chemical injury")
            ],
            environment: .office,
            hazards: [],
            timeLimit: 20,
            visualStyle: .general,
            category: .firstAid,
            difficulty: .intermediate,
            hazardLevel: .high
        ),
        Scenario(
            title: "Window Breaking from Pressure",
            description: "A large office window cracks loudly and appears about to fail.",
            imageIcon: "rectangle.inset.filled",
            choices: [
                Choice(id: "1", text: "Tape the window to hold it together", isCorrect: false, explanation: "Tape cannot hold failing structural glass"),
                Choice(id: "2", text: "Move everyone away from the window immediately", isCorrect: true, explanation: "Failing glass is a serious injury hazard; clear the area"),
                Choice(id: "3", text: "Touch the window to check if it's structurally sound", isCorrect: false, explanation: "Touching a cracked window can cause it to shatter"),
                Choice(id: "4", text: "Continue working away from the window in same room", isCorrect: false, explanation: "Should leave the room if window is about to fail")
            ],
            environment: .office,
            hazards: [],
            visualStyle: .general,
            category: .mechanical,
            difficulty: .beginner,
            hazardLevel: .medium
        ),
        Scenario(
            title: "Elevator Door Malfunction",
            description: "You are inside an elevator when the doors won't open and it shows no movement.",
            imageIcon: "door.sliding.right.hand.closed",
            choices: [
                Choice(id: "1", text: "Pry the doors open with an umbrella", isCorrect: false, explanation: "Prying elevator doors risks fall down the shaft"),
                Choice(id: "2", text: "Press door open button, then alarm button, call for help", isCorrect: true, explanation: "Use built-in emergency communication to get professional help"),
                Choice(id: "3", text: "Jump repeatedly to trigger sensors", isCorrect: false, explanation: "Jumping can damage elevator mechanisms"),
                Choice(id: "4", text: "Force emergency stop button repeatedly", isCorrect: false, explanation: "Emergency communication, not forcing buttons, is correct approach")
            ],
            environment: .office,
            hazards: [],
            visualStyle: .general,
            category: .evacuation,
            difficulty: .beginner,
            hazardLevel: .medium
        ),
        Scenario(
            title: "Nausea from Chemical Fumes",
            description: "Several coworkers are feeling dizzy and nauseous at the same time.",
            imageIcon: "person.2.fill",
            choices: [
                Choice(id: "1", text: "Have everyone rest at their desks", isCorrect: false, explanation: "Simultaneous symptoms suggest environmental hazard; evacuate"),
                Choice(id: "2", text: "Evacuate building and investigate cause externally", isCorrect: true, explanation: "Multiple sick people suggest toxic exposure; evacuate and investigate"),
                Choice(id: "3", text: "Open office windows and continue working", isCorrect: false, explanation: "Source of symptoms must be identified; do not stay in building"),
                Choice(id: "4", text: "Turn up HVAC to improve air circulation", isCorrect: false, explanation: "If HVAC is source of contamination, increasing output worsens problem")
            ],
            environment: .office,
            hazards: [.gas],
            visualStyle: .gasLeak,
            category: .evacuation,
            difficulty: .intermediate,
            hazardLevel: .critical
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
        ),
        Scenario(
            title: "Knife Cut First Aid",
            description: "A chef has a deep cut on their hand from a kitchen knife.",
            imageIcon: "cross.fill",
            choices: [
                Choice(id: "1", text: "Rinse with warm water and keep working", isCorrect: false, explanation: "Deep cut requires proper first aid and may need medical attention"),
                Choice(id: "2", text: "Apply direct pressure, elevate hand, get first aid", isCorrect: true, explanation: "Control bleeding with pressure and get professional assessment"),
                Choice(id: "3", text: "Wrap tightly with rubber band tourniquet", isCorrect: false, explanation: "Rubber band tourniquet on fingers restricts blood flow dangerously"),
                Choice(id: "4", text: "Apply ointment immediately and cover with cloth", isCorrect: false, explanation: "Stop bleeding first with direct pressure")
            ],
            environment: .kitchen,
            hazards: [],
            timeLimit: 30,
            visualStyle: .general,
            category: .firstAid,
            difficulty: .beginner,
            hazardLevel: .medium
        ),
        Scenario(
            title: "Hot Oil Burn",
            description: "A cook has splashed hot oil on their forearm causing a burn.",
            imageIcon: "bandage.fill",
            choices: [
                Choice(id: "1", text: "Apply butter to soothe the burn", isCorrect: false, explanation: "Butter traps heat and can cause infection"),
                Choice(id: "2", text: "Cool with cool running water for 20 minutes", isCorrect: true, explanation: "Cool water reduces tissue damage and relieves pain"),
                Choice(id: "3", text: "Pop any blisters that form", isCorrect: false, explanation: "Blisters protect wound; popping increases infection risk"),
                Choice(id: "4", text: "Apply ice directly to the burn", isCorrect: false, explanation: "Ice causes frostbite and increases tissue damage")
            ],
            environment: .kitchen,
            hazards: [],
            timeLimit: 30,
            visualStyle: .burn,
            category: .firstAid,
            difficulty: .beginner,
            hazardLevel: .medium
        ),
        Scenario(
            title: "Gas Leak Detection",
            description: "The kitchen smells strongly of gas even though no burners are on.",
            imageIcon: "cloud.fog.fill",
            choices: [
                Choice(id: "1", text: "Light a match to find the source", isCorrect: false, explanation: "Open flame will ignite gas and cause explosion"),
                Choice(id: "2", text: "Turn off gas supply, open doors, evacuate, call gas company", isCorrect: true, explanation: "Shut off gas source, ventilate, evacuate, call professionals"),
                Choice(id: "3", text: "Turn on kitchen exhaust fan", isCorrect: false, explanation: "Exhaust fan electrical switch can spark and ignite gas"),
                Choice(id: "4", text: "Spray air freshener to mask the smell", isCorrect: false, explanation: "Does not address gas leak and aerosol spray can ignite")
            ],
            environment: .kitchen,
            hazards: [.gas],
            timeLimit: 20,
            visualStyle: .gasLeak,
            category: .chemical,
            difficulty: .intermediate,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Kitchen Flooding",
            description: "The kitchen is flooding from a broken pipe with water reaching electrical outlets.",
            imageIcon: "water.waves",
            choices: [
                Choice(id: "1", text: "Continue cooking while avoiding flooded areas", isCorrect: false, explanation: "Electricity and water are lethal; stop all operations"),
                Choice(id: "2", text: "Turn off power, close water valve, evacuate kitchen", isCorrect: true, explanation: "Electrical safety first; then stop water source"),
                Choice(id: "3", text: "Use mop to remove water quickly", isCorrect: false, explanation: "Must turn off power first before approaching flooded area"),
                Choice(id: "4", text: "Put down rubber mats to insulate from water", isCorrect: false, explanation: "Mats are insufficient electrical protection; cut power first")
            ],
            environment: .kitchen,
            hazards: [.electrical],
            visualStyle: .electricalFire,
            category: .electrical,
            difficulty: .intermediate,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Food Poisoning Outbreak",
            description: "Multiple customers report illness after eating from the same dish.",
            imageIcon: "person.2.fill",
            choices: [
                Choice(id: "1", text: "Continue serving that dish until confirmed", isCorrect: false, explanation: "Suspected food poisoning requires immediate removal from service"),
                Choice(id: "2", text: "Remove dish, preserve sample, call health authority", isCorrect: true, explanation: "Preserve evidence, protect customers, notify health officials"),
                Choice(id: "3", text: "Add more seasoning to mask any spoilage", isCorrect: false, explanation: "Masking contaminated food is dangerous and illegal"),
                Choice(id: "4", text: "Reheat the dish to kill any bacteria", isCorrect: false, explanation: "Toxins from bacteria may not be destroyed by reheating")
            ],
            environment: .kitchen,
            hazards: [],
            visualStyle: .general,
            category: .chemical,
            difficulty: .advanced,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Refrigerator Fire",
            description: "Smoke is coming from behind the commercial refrigerator unit.",
            imageIcon: "refrigerator.fill",
            choices: [
                Choice(id: "1", text: "Open refrigerator to check inside for fire", isCorrect: false, explanation: "Fire is behind the unit in motor components"),
                Choice(id: "2", text: "Unplug refrigerator and use CO2 extinguisher", isCorrect: true, explanation: "Cut electrical power then use appropriate extinguisher"),
                Choice(id: "3", text: "Pour water behind unit to extinguish", isCorrect: false, explanation: "Water near electrical components causes electrocution"),
                Choice(id: "4", text: "Move refrigerator away from wall to see fire better", isCorrect: false, explanation: "Do not move burning electrical appliance")
            ],
            environment: .kitchen,
            hazards: [.electrical, .heavySmoke],
            visualStyle: .electricalFire,
            category: .electrical,
            difficulty: .intermediate,
            hazardLevel: .high
        ),
        Scenario(
            title: "Hood Vent Grease Fire",
            description: "Grease has ignited inside the kitchen exhaust hood vent.",
            imageIcon: "wind.circle.fill",
            choices: [
                Choice(id: "1", text: "Spray water into the vent", isCorrect: false, explanation: "Water on grease fire causes explosive spread"),
                Choice(id: "2", text: "Activate hood suppression system, evacuate kitchen", isCorrect: true, explanation: "Built-in suppression system is designed for this; evacuate staff"),
                Choice(id: "3", text: "Turn on fan to blow out flames", isCorrect: false, explanation: "More airflow increases the fire's intensity"),
                Choice(id: "4", text: "Climb up to manually access the vent", isCorrect: false, explanation: "Do not attempt to fight vent fire manually")
            ],
            environment: .kitchen,
            hazards: [.flammableLiquid, .heavySmoke],
            timeLimit: 30,
            visualStyle: .burn,
            category: .fire,
            difficulty: .advanced,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Slip on Kitchen Floor",
            description: "A staff member has slipped on a grease spill and cannot get up.",
            imageIcon: "figure.fall",
            choices: [
                Choice(id: "1", text: "Help them stand up immediately", isCorrect: false, explanation: "Moving someone with unknown injuries can worsen them"),
                Choice(id: "2", text: "Keep them still, secure area, call for first aid", isCorrect: true, explanation: "Stabilize patient and prevent others from slipping too"),
                Choice(id: "3", text: "Drag them out of the kitchen", isCorrect: false, explanation: "Dragging can worsen spinal or limb injuries"),
                Choice(id: "4", text: "Help them to a chair and give water", isCorrect: false, explanation: "Moving without assessment can worsen injuries; get first aid")
            ],
            environment: .kitchen,
            hazards: [],
            visualStyle: .general,
            category: .firstAid,
            difficulty: .beginner,
            hazardLevel: .medium
        ),
        Scenario(
            title: "Steam Burn from Pot",
            description: "A cook receives a steam burn when removing the lid from a large pot.",
            imageIcon: "thermometer.sun.fill",
            choices: [
                Choice(id: "1", text: "Apply toothpaste to the burned area", isCorrect: false, explanation: "Toothpaste traps heat and can cause infection"),
                Choice(id: "2", text: "Remove from heat, cool with cool water for 20 minutes", isCorrect: true, explanation: "Cool running water is the primary first aid for burns"),
                Choice(id: "3", text: "Wrap tightly in cling wrap immediately", isCorrect: false, explanation: "Cool first; cling wrap after for minor burns in clinical setting"),
                Choice(id: "4", text: "Apply burn cream straight away and continue working", isCorrect: false, explanation: "Must cool burn first; cannot continue working with burn injury")
            ],
            environment: .kitchen,
            hazards: [],
            timeLimit: 30,
            visualStyle: .burn,
            category: .firstAid,
            difficulty: .beginner,
            hazardLevel: .medium
        ),
        Scenario(
            title: "Choking Customer",
            description: "A restaurant customer is choking on food and cannot cough or speak.",
            imageIcon: "fork.knife",
            choices: [
                Choice(id: "1", text: "Give them water to wash down the food", isCorrect: false, explanation: "Water cannot help with complete airway obstruction"),
                Choice(id: "2", text: "Perform Heimlich maneuver and call 911", isCorrect: true, explanation: "Abdominal thrusts can dislodge obstruction; get emergency help"),
                Choice(id: "3", text: "Pound hard on their back while they stand", isCorrect: false, explanation: "Back blows are part of first aid but not alone; combine with abdominal thrusts"),
                Choice(id: "4", text: "Tell them to swallow harder", isCorrect: false, explanation: "If they cannot cough or speak, they need immediate intervention")
            ],
            environment: .kitchen,
            hazards: [],
            timeLimit: 20,
            visualStyle: .general,
            category: .firstAid,
            difficulty: .intermediate,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Ammonia Refrigerant Leak",
            description: "A strong ammonia smell comes from the commercial refrigeration system.",
            imageIcon: "refrigerator.fill",
            choices: [
                Choice(id: "1", text: "Continue cooking but open the back door", isCorrect: false, explanation: "Ammonia is toxic; evacuate immediately"),
                Choice(id: "2", text: "Evacuate kitchen, call refrigeration technician and 911", isCorrect: true, explanation: "Ammonia refrigerant is toxic; evacuate and get professional help"),
                Choice(id: "3", text: "Put wet cloth over the refrigerant source", isCorrect: false, explanation: "Do not approach ammonia source without respiratory protection"),
                Choice(id: "4", text: "Turn on kitchen fans to disperse the smell", isCorrect: false, explanation: "Electrical switches can spark; evacuate first")
            ],
            environment: .kitchen,
            hazards: [.gas],
            timeLimit: 20,
            visualStyle: .gasLeak,
            category: .chemical,
            difficulty: .advanced,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Carbon Monoxide from Stove",
            description: "Multiple kitchen staff are feeling dizzy and the CO alarm is sounding.",
            imageIcon: "alarm.fill",
            choices: [
                Choice(id: "1", text: "Open windows and keep cooking", isCorrect: false, explanation: "CO source must be eliminated; evacuate all staff"),
                Choice(id: "2", text: "Evacuate everyone immediately, call 911", isCorrect: true, explanation: "CO is lethal; evacuate and get emergency help"),
                Choice(id: "3", text: "Turn off one burner to reduce CO", isCorrect: false, explanation: "Must evacuate; do not attempt to diagnose source"),
                Choice(id: "4", text: "Check on the affected staff only", isCorrect: false, explanation: "Everyone must evacuate from CO environment")
            ],
            environment: .kitchen,
            hazards: [.gas],
            timeLimit: 20,
            visualStyle: .gasLeak,
            category: .evacuation,
            difficulty: .intermediate,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Blender Explosion",
            description: "Hot liquid has been blended with the lid off, spraying boiling liquid.",
            imageIcon: "bolt.horizontal.fill",
            choices: [
                Choice(id: "1", text: "Keep blending to finish the task", isCorrect: false, explanation: "Blending hot liquids without lid is extremely dangerous"),
                Choice(id: "2", text: "Turn off blender, cool any burns with water immediately", isCorrect: true, explanation: "Stop the hazard and treat burns with cool water"),
                Choice(id: "3", text: "Wipe hot liquid off surfaces with towel", isCorrect: false, explanation: "Treat any burn injuries first before cleaning"),
                Choice(id: "4", text: "Tilt blender to prevent more spilling", isCorrect: false, explanation: "Turn off the blender; do not keep it running")
            ],
            environment: .kitchen,
            hazards: [],
            timeLimit: 30,
            visualStyle: .burn,
            category: .firstAid,
            difficulty: .beginner,
            hazardLevel: .medium
        ),
        Scenario(
            title: "Fire Extinguisher Use in Kitchen",
            description: "A small fire breaks out in a pan. The fire is contained but growing.",
            imageIcon: "cylinder.fill",
            choices: [
                Choice(id: "1", text: "Use water from the sink tap on the pan fire", isCorrect: false, explanation: "Water on grease fire causes explosive spread"),
                Choice(id: "2", text: "Use Class K (wet chemical) extinguisher", isCorrect: true, explanation: "Class K extinguisher is designed specifically for kitchen fires"),
                Choice(id: "3", text: "Use CO2 extinguisher on the pan", isCorrect: false, explanation: "CO2 can spread burning grease; Class K is correct for kitchen"),
                Choice(id: "4", text: "Use dry powder extinguisher", isCorrect: false, explanation: "Dry powder contaminates food surfaces; Class K is appropriate")
            ],
            environment: .kitchen,
            hazards: [.flammableLiquid],
            visualStyle: .burn,
            category: .fire,
            difficulty: .intermediate,
            hazardLevel: .high
        ),
        Scenario(
            title: "Exhaust Fan Sparking",
            description: "The kitchen exhaust fan is making sparking sounds and smelling of burnt motor.",
            imageIcon: "fan.fill",
            choices: [
                Choice(id: "1", text: "Keep running to clear kitchen smoke", isCorrect: false, explanation: "Malfunctioning motor is a fire hazard; turn off immediately"),
                Choice(id: "2", text: "Turn off fan at switch, report to maintenance", isCorrect: true, explanation: "Cut power to sparking equipment and get it repaired"),
                Choice(id: "3", text: "Spray water on fan motor to cool it", isCorrect: false, explanation: "Water on electrical motor causes electrocution"),
                Choice(id: "4", text: "Place bowl under it to catch any sparks", isCorrect: false, explanation: "Must cut power; sparks can ignite grease accumulated in fan")
            ],
            environment: .kitchen,
            hazards: [.electrical],
            visualStyle: .electricalFire,
            category: .electrical,
            difficulty: .beginner,
            hazardLevel: .medium
        ),
        Scenario(
            title: "Gas Pilot Light Failure",
            description: "Multiple pilot lights have gone out on the gas stove and you smell gas.",
            imageIcon: "flame.circle",
            choices: [
                Choice(id: "1", text: "Light all pilots immediately with a lighter", isCorrect: false, explanation: "Gas may have accumulated; lighting can cause explosion"),
                Choice(id: "2", text: "Turn off gas supply, ventilate well, then relight carefully", isCorrect: true, explanation: "Purge accumulated gas before relighting any pilot"),
                Choice(id: "3", text: "Turn on all burners to use up the gas quickly", isCorrect: false, explanation: "Opening more gas valves increases explosion risk"),
                Choice(id: "4", text: "Call the gas company and wait without ventilating", isCorrect: false, explanation: "Must ventilate area with accumulated gas before waiting")
            ],
            environment: .kitchen,
            hazards: [.gas],
            visualStyle: .gasLeak,
            category: .fire,
            difficulty: .intermediate,
            hazardLevel: .high
        ),
        Scenario(
            title: "Fryer Oil Overflow Fire",
            description: "A deep fryer is overflowing with burning oil that's spreading on the floor.",
            imageIcon: "flame.fill",
            choices: [
                Choice(id: "1", text: "Use water hose to extinguish floor fire", isCorrect: false, explanation: "Water on burning oil causes violent flare-up and spread"),
                Choice(id: "2", text: "Use Class K extinguisher, turn off fryer, evacuate if necessary", isCorrect: true, explanation: "Class K for kitchen grease fires; cut fuel source"),
                Choice(id: "3", text: "Try to scoop oil back into the fryer", isCorrect: false, explanation: "Never approach burning oil with bare hands"),
                Choice(id: "4", text: "Open the back door and let wind blow it out", isCorrect: false, explanation: "Wind can spread burning oil and make fire worse")
            ],
            environment: .kitchen,
            hazards: [.flammableLiquid, .heavySmoke],
            timeLimit: 30,
            visualStyle: .burn,
            category: .fire,
            difficulty: .advanced,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Broken Glass in Food",
            description: "A glass display cover has shattered and pieces may have fallen into prepared food.",
            imageIcon: "fork.knife.circle.fill",
            choices: [
                Choice(id: "1", text: "Remove visible pieces and serve the food", isCorrect: false, explanation: "Invisible glass shards remain dangerous even after removing visible pieces"),
                Choice(id: "2", text: "Discard all potentially contaminated food immediately", isCorrect: true, explanation: "Entire batch must be discarded; glass contamination is not safe to screen"),
                Choice(id: "3", text: "Run food through a sieve to catch glass", isCorrect: false, explanation: "Small glass pieces can pass through sieves"),
                Choice(id: "4", text: "Visually check each portion before serving", isCorrect: false, explanation: "Glass is often invisible in food; do not serve any from that batch")
            ],
            environment: .kitchen,
            hazards: [],
            visualStyle: .general,
            category: .chemical,
            difficulty: .beginner,
            hazardLevel: .high
        ),
        Scenario(
            title: "Chemical Drain Cleaner Spill",
            description: "A concentrated chemical drain cleaner has splashed on a worker's arms.",
            imageIcon: "drop.fill",
            choices: [
                Choice(id: "1", text: "Wipe off with dry cloth", isCorrect: false, explanation: "Wiping spreads corrosive chemical over more skin area"),
                Choice(id: "2", text: "Flush with large amounts of water for 20 minutes", isCorrect: true, explanation: "Copious water flushing removes caustic chemical from skin"),
                Choice(id: "3", text: "Neutralize with vinegar since it is alkaline cleaner", isCorrect: false, explanation: "Do not apply neutralizers; flush with water immediately"),
                Choice(id: "4", text: "Apply moisturizing lotion to protect skin", isCorrect: false, explanation: "Flush chemical off first; lotion alone won't help")
            ],
            environment: .kitchen,
            hazards: [],
            timeLimit: 20,
            visualStyle: .chemicalFire,
            category: .firstAid,
            difficulty: .intermediate,
            hazardLevel: .high
        ),
        Scenario(
            title: "Food Allergy Emergency",
            description: "A customer with a nut allergy has eaten a dish containing undisclosed nuts.",
            imageIcon: "cross.case.fill",
            choices: [
                Choice(id: "1", text: "Give antihistamine and monitor for 30 minutes", isCorrect: false, explanation: "Severe allergy can cause anaphylaxis; needs EpiPen and 911"),
                Choice(id: "2", text: "Call 911, administer EpiPen if available and prescribed", isCorrect: true, explanation: "Anaphylaxis risk requires emergency services immediately"),
                Choice(id: "3", text: "Have them drink milk to counteract the allergy", isCorrect: false, explanation: "Milk does not counteract nut allergy; call 911 immediately"),
                Choice(id: "4", text: "Wait to see if symptoms develop before calling 911", isCorrect: false, explanation: "Do not wait; call 911 immediately when known allergen ingested")
            ],
            environment: .kitchen,
            hazards: [],
            timeLimit: 20,
            visualStyle: .general,
            category: .firstAid,
            difficulty: .advanced,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Boiling Liquid Overflow",
            description: "A large pot of boiling liquid overflows and contacts the burner flames.",
            imageIcon: "thermometer.high",
            choices: [
                Choice(id: "1", text: "Remove pot with bare hands quickly", isCorrect: false, explanation: "Handling boiling pot without protection causes burns"),
                Choice(id: "2", text: "Turn off burner, use oven mitts to move pot carefully", isCorrect: true, explanation: "Cut heat source first, then safely move pot with protection"),
                Choice(id: "3", text: "Throw cold water on boiling pot to stop overflow", isCorrect: false, explanation: "Cold water in boiling liquid causes violent steam explosion"),
                Choice(id: "4", text: "Fan boiling liquid to cool it faster", isCorrect: false, explanation: "Fanning boiling liquid spreads burning steam")
            ],
            environment: .kitchen,
            hazards: [],
            timeLimit: 30,
            visualStyle: .burn,
            category: .fire,
            difficulty: .beginner,
            hazardLevel: .medium
        ),
        Scenario(
            title: "Dishwasher Chemical Exposure",
            description: "Commercial dishwasher chemical has splashed in a worker's face.",
            imageIcon: "drop.triangle.fill",
            choices: [
                Choice(id: "1", text: "Wipe face with cloth and check in mirror", isCorrect: false, explanation: "Chemical exposure to face requires immediate flushing"),
                Choice(id: "2", text: "Flush face and eyes at eyewash station for 15 minutes", isCorrect: true, explanation: "Immediate copious flushing is essential for facial chemical exposure"),
                Choice(id: "3", text: "Apply skin moisturizer to affected areas", isCorrect: false, explanation: "Must flush chemical off before any topical treatment"),
                Choice(id: "4", text: "Drink water and lie down to recover", isCorrect: false, explanation: "Flush the chemical off externally; do not drink water for skin exposure")
            ],
            environment: .kitchen,
            hazards: [],
            timeLimit: 20,
            visualStyle: .chemicalFire,
            category: .firstAid,
            difficulty: .intermediate,
            hazardLevel: .high
        ),
        Scenario(
            title: "Gas Stove Electrical Short",
            description: "The electronic ignition on the gas stove is sparking continuously and won't stop.",
            imageIcon: "bolt.fill",
            choices: [
                Choice(id: "1", text: "Ignore it and use lighter to light burners", isCorrect: false, explanation: "Continuous sparking near gas is a fire and ignition hazard"),
                Choice(id: "2", text: "Shut off power to stove and call technician", isCorrect: true, explanation: "Cut electrical power to stop sparking; don't use equipment"),
                Choice(id: "3", text: "Pour water on igniter to stop sparking", isCorrect: false, explanation: "Water near gas and electricity is dangerous"),
                Choice(id: "4", text: "Tape over igniter to stop sparking", isCorrect: false, explanation: "Tape over electrical component is a fire hazard")
            ],
            environment: .kitchen,
            hazards: [.electrical, .gas],
            visualStyle: .electricalFire,
            category: .electrical,
            difficulty: .intermediate,
            hazardLevel: .high
        ),
        Scenario(
            title: "Walk-In Freezer Entrapment",
            description: "A worker is trapped in the walk-in freezer with the door jammed shut.",
            imageIcon: "door.left.hand.closed",
            choices: [
                Choice(id: "1", text: "Remain calm and wait for someone to come", isCorrect: false, explanation: "Hypothermia risk; must signal for help immediately"),
                Choice(id: "2", text: "Use interior release mechanism, bang loudly for help", isCorrect: true, explanation: "All commercial freezers have interior release; make noise for help"),
                Choice(id: "3", text: "Try to force the door with your body", isCorrect: false, explanation: "Proper interior release should work; conserve energy and call for help"),
                Choice(id: "4", text: "Sit down and conserve body heat quietly", isCorrect: false, explanation: "Must actively seek help; hypothermia can develop quickly")
            ],
            environment: .kitchen,
            hazards: [],
            timeLimit: 30,
            visualStyle: .general,
            category: .evacuation,
            difficulty: .intermediate,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Hot Surface Burns",
            description: "A cook touched a hot commercial oven surface by mistake causing immediate blisters.",
            imageIcon: "thermometer.sun.circle.fill",
            choices: [
                Choice(id: "1", text: "Apply ice directly to the burned area", isCorrect: false, explanation: "Ice restricts blood flow and can worsen burn injury"),
                Choice(id: "2", text: "Cool under running water for 20 minutes, cover loosely", isCorrect: true, explanation: "Cool running water is the standard first aid for burns"),
                Choice(id: "3", text: "Pop the blisters to release pressure", isCorrect: false, explanation: "Blisters protect the wound; popping increases infection risk"),
                Choice(id: "4", text: "Apply toothpaste or aloe vera immediately", isCorrect: false, explanation: "Cool with water first; topical remedies should not replace this")
            ],
            environment: .kitchen,
            hazards: [],
            timeLimit: 30,
            visualStyle: .burn,
            category: .firstAid,
            difficulty: .beginner,
            hazardLevel: .medium
        ),
        Scenario(
            title: "Grease Trap Fire",
            description: "A grease trap beneath the cooking line has caught fire.",
            imageIcon: "flame.fill",
            choices: [
                Choice(id: "1", text: "Pour water into the trap to extinguish", isCorrect: false, explanation: "Water on grease fire causes explosive spread"),
                Choice(id: "2", text: "Evacuate kitchen, call fire services, activate suppression", isCorrect: true, explanation: "Grease trap fire requires professional response; activate suppression"),
                Choice(id: "3", text: "Continue cooking above while someone handles below", isCorrect: false, explanation: "Fire can rapidly spread to cooking equipment above"),
                Choice(id: "4", text: "Use CO2 extinguisher in the trap", isCorrect: false, explanation: "CO2 not ideal for deep grease fires; use Class K and evacuate")
            ],
            environment: .kitchen,
            hazards: [.flammableLiquid, .heavySmoke],
            timeLimit: 30,
            visualStyle: .burn,
            category: .fire,
            difficulty: .advanced,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Pest Control Chemical Hazard",
            description: "A pest control chemical has been incorrectly applied in the kitchen food prep area.",
            imageIcon: "ant.fill",
            choices: [
                Choice(id: "1", text: "Wipe surfaces with a damp cloth and continue cooking", isCorrect: false, explanation: "Pesticide contamination requires proper decontamination"),
                Choice(id: "2", text: "Stop cooking, discard all food, thoroughly clean surfaces", isCorrect: true, explanation: "All food must be discarded and surfaces properly decontaminated"),
                Choice(id: "3", text: "Cook food at high temperature to kill pesticide residue", isCorrect: false, explanation: "High heat does not eliminate pesticide contamination"),
                Choice(id: "4", text: "Rinse affected area with water and resume service", isCorrect: false, explanation: "Water rinse is insufficient; full decontamination required")
            ],
            environment: .kitchen,
            hazards: [],
            visualStyle: .chemicalFire,
            category: .chemical,
            difficulty: .intermediate,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Electrical Socket Near Water",
            description: "An electrical socket near the kitchen sink is wet from a water splash.",
            imageIcon: "poweroutlet.type.b.fill",
            choices: [
                Choice(id: "1", text: "Continue using the socket carefully", isCorrect: false, explanation: "Wet electrical socket is a serious electrocution hazard"),
                Choice(id: "2", text: "Turn off circuit breaker, dry socket before any use", isCorrect: true, explanation: "Cut power first; socket must be dried before any electrical use"),
                Choice(id: "3", text: "Wipe dry with paper towel and test with appliance", isCorrect: false, explanation: "Must cut power before touching wet electrical socket"),
                Choice(id: "4", text: "Put tape over socket temporarily", isCorrect: false, explanation: "Tape does not make wet socket safe; cut power")
            ],
            environment: .kitchen,
            hazards: [.electrical],
            visualStyle: .electricalFire,
            category: .electrical,
            difficulty: .beginner,
            hazardLevel: .high
        ),
        Scenario(
            title: "Kitchen Fire Evacuation",
            description: "A large kitchen fire is beyond control and spreading rapidly.",
            imageIcon: "figure.run",
            choices: [
                Choice(id: "1", text: "Continue fighting the fire with extinguishers", isCorrect: false, explanation: "Large out-of-control fire requires immediate evacuation"),
                Choice(id: "2", text: "Evacuate all staff, close doors, call fire services", isCorrect: true, explanation: "Safety first; close doors to slow spread and call emergency services"),
                Choice(id: "3", text: "Use the fire suppression system and keep cooking", isCorrect: false, explanation: "Suppression system helps but everyone must still evacuate"),
                Choice(id: "4", text: "Grab valuables before evacuating", isCorrect: false, explanation: "Leave immediately; do not endanger yourself for valuables")
            ],
            environment: .kitchen,
            hazards: [.flammableLiquid, .heavySmoke],
            timeLimit: 20,
            visualStyle: .burn,
            category: .evacuation,
            difficulty: .beginner,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Slippery Kitchen Floor",
            description: "The kitchen floor is covered in spilled oil making it extremely slippery.",
            imageIcon: "figure.fall",
            choices: [
                Choice(id: "1", text: "Continue working very carefully", isCorrect: false, explanation: "Slippery kitchen floor is a serious fall hazard; must address immediately"),
                Choice(id: "2", text: "Warn all staff, close kitchen, clean spill before resuming", isCorrect: true, explanation: "Prevent injuries by closing the area and cleaning hazard"),
                Choice(id: "3", text: "Put cardboard over the oil as temporary fix", isCorrect: false, explanation: "Cardboard over oil is not a safe solution and can shift"),
                Choice(id: "4", text: "Walk around the edges to avoid it", isCorrect: false, explanation: "Others may not know about hazard; must clean it properly")
            ],
            environment: .kitchen,
            hazards: [],
            visualStyle: .general,
            category: .mechanical,
            difficulty: .beginner,
            hazardLevel: .medium
        ),
        Scenario(
            title: "Smoke Alarm in Kitchen",
            description: "The kitchen smoke alarm activates during cooking operations.",
            imageIcon: "alarm.fill",
            choices: [
                Choice(id: "1", text: "Reset the alarm, it's just steam from cooking", isCorrect: false, explanation: "Must verify source before resetting; check for actual fire"),
                Choice(id: "2", text: "Verify source of smoke, evacuate if actual fire detected", isCorrect: true, explanation: "Confirm if cooking steam or actual fire before responding"),
                Choice(id: "3", text: "Disable the alarm to prevent false alarms during cooking", isCorrect: false, explanation: "Never disable smoke alarms; investigate the cause"),
                Choice(id: "4", text: "Increase ventilation and ignore the alarm", isCorrect: false, explanation: "Must investigate every smoke alarm activation")
            ],
            environment: .kitchen,
            hazards: [.heavySmoke],
            visualStyle: .burn,
            category: .fire,
            difficulty: .beginner,
            hazardLevel: .medium
        ),
        Scenario(
            title: "Fryer Electrical Failure",
            description: "The electric deep fryer is sparking heavily and smells of burning wiring.",
            imageIcon: "bolt.circle.fill",
            choices: [
                Choice(id: "1", text: "Unplug the fryer with oil inside", isCorrect: false, explanation: "Unplugging near sparking fryer with hot oil risks burns and shock"),
                Choice(id: "2", text: "Turn off at main switch and call electrician", isCorrect: true, explanation: "Cut power at breaker; do not touch the sparking equipment"),
                Choice(id: "3", text: "Continue using fryer until food is done", isCorrect: false, explanation: "Electrical fault with hot oil is a critical fire and shock hazard"),
                Choice(id: "4", text: "Pour baking soda on electrical sparks", isCorrect: false, explanation: "Do not approach sparking electrical equipment")
            ],
            environment: .kitchen,
            hazards: [.electrical, .flammableLiquid],
            visualStyle: .electricalFire,
            category: .electrical,
            difficulty: .intermediate,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Food Service Burn Protocol",
            description: "A kitchen worker has a large burn covering their entire forearm from a cooking accident.",
            imageIcon: "staple.slash",
            choices: [
                Choice(id: "1", text: "Apply butter and wrap in foil, continue working", isCorrect: false, explanation: "Large burn requires medical attention; butter is harmful"),
                Choice(id: "2", text: "Cool with water, cover loosely, seek immediate medical care", isCorrect: true, explanation: "Cool the burn, loosely cover, and get medical treatment urgently"),
                Choice(id: "3", text: "Apply burn gel and a tight bandage", isCorrect: false, explanation: "Tight bandaging restricts blood flow to burned area"),
                Choice(id: "4", text: "Have them rest in break room and monitor", isCorrect: false, explanation: "Large burns require medical care, not just rest")
            ],
            environment: .kitchen,
            hazards: [],
            timeLimit: 20,
            visualStyle: .burn,
            category: .firstAid,
            difficulty: .intermediate,
            hazardLevel: .high
        ),
        Scenario(
            title: "Gas Cylinder in Kitchen",
            description: "A portable gas cylinder used for a kitchen torch is leaking near the stove.",
            imageIcon: "cylinder.fill",
            choices: [
                Choice(id: "1", text: "Try to tighten the connection with a wrench", isCorrect: false, explanation: "Do not attempt repair; risk of spark from metal contact"),
                Choice(id: "2", text: "Close cylinder valve, move away from ignition, ventilate", isCorrect: true, explanation: "Shut off valve at cylinder, remove from heat sources, ventilate"),
                Choice(id: "3", text: "Submerge in water to stop the leak", isCorrect: false, explanation: "Do not submerge gas cylinder; move away from ignition sources"),
                Choice(id: "4", text: "Continue working and replace cylinder when empty", isCorrect: false, explanation: "Leaking cylinder near heat sources can ignite explosively")
            ],
            environment: .kitchen,
            hazards: [.gas, .flammableLiquid],
            timeLimit: 20,
            visualStyle: .gasLeak,
            category: .chemical,
            difficulty: .intermediate,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Food Processor Injury",
            description: "A food processor has started while someone's hand was inside.",
            imageIcon: "hand.raised.slash.fill",
            choices: [
                Choice(id: "1", text: "Try to remove hand while it's running", isCorrect: false, explanation: "Never attempt to remove entangled body part from running machinery"),
                Choice(id: "2", text: "Immediately cut power, then carefully remove hand", isCorrect: true, explanation: "Stop the machine completely before attempting any extraction"),
                Choice(id: "3", text: "Reverse the machine direction to release", isCorrect: false, explanation: "Cut power completely; do not attempt to run in reverse"),
                Choice(id: "4", text: "Call for help while machine keeps running", isCorrect: false, explanation: "Cut power immediately; then call for help")
            ],
            environment: .kitchen,
            hazards: [],
            timeLimit: 15,
            visualStyle: .mechanicalFire,
            category: .firstAid,
            difficulty: .advanced,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Oven Cleaning Chemical Fumes",
            description: "A strong smell from oven cleaner chemicals is filling the kitchen.",
            imageIcon: "oven.fill",
            choices: [
                Choice(id: "1", text: "Continue cooking in the kitchen", isCorrect: false, explanation: "Oven cleaner fumes are caustic and respiratory hazards"),
                Choice(id: "2", text: "Evacuate kitchen, ventilate fully, wait until fumes clear", isCorrect: true, explanation: "Caustic fumes require full ventilation before kitchen re-entry"),
                Choice(id: "3", text: "Use kitchen fans to clear fumes while working", isCorrect: false, explanation: "Must leave kitchen; fans alone may be insufficient"),
                Choice(id: "4", text: "Cover nose with cloth and continue work", isCorrect: false, explanation: "Cloth does not protect from caustic chemical fumes")
            ],
            environment: .kitchen,
            hazards: [.gas],
            visualStyle: .chemicalFire,
            category: .chemical,
            difficulty: .beginner,
            hazardLevel: .medium
        ),
        Scenario(
            title: "Microwave Fire Alarm",
            description: "Food in the commercial microwave has caught fire with visible flames.",
            imageIcon: "microwave.fill",
            choices: [
                Choice(id: "1", text: "Open door immediately to remove burning food", isCorrect: false, explanation: "Opening provides oxygen and spreads the fire"),
                Choice(id: "2", text: "Keep door closed, turn off and unplug microwave", isCorrect: true, explanation: "Contain fire by keeping door closed; cut power to stop it"),
                Choice(id: "3", text: "Pour water through the microwave vents", isCorrect: false, explanation: "Water and microwave electricity is extremely dangerous"),
                Choice(id: "4", text: "Wait for microwave cycle to end", isCorrect: false, explanation: "Turn off immediately; do not let fire continue")
            ],
            environment: .kitchen,
            hazards: [.electrical, .heavySmoke],
            visualStyle: .electricalFire,
            category: .fire,
            difficulty: .beginner,
            hazardLevel: .medium
        ),
        Scenario(
            title: "Chemical Sanitizer Skin Contact",
            description: "Concentrated food-grade sanitizer has splashed on a worker's bare arms.",
            imageIcon: "drop.circle.fill",
            choices: [
                Choice(id: "1", text: "Dilute sanitizer and continue using arm", isCorrect: false, explanation: "Must flush concentrated sanitizer off skin immediately"),
                Choice(id: "2", text: "Rinse with large amounts of water for 15 minutes", isCorrect: true, explanation: "Even food-grade sanitizers in concentration cause chemical burns"),
                Choice(id: "3", text: "Apply sunscreen to protect the skin", isCorrect: false, explanation: "Must flush the chemical off with water first"),
                Choice(id: "4", text: "Wipe with dry cloth and continue working", isCorrect: false, explanation: "Wiping spreads concentrated chemical; flush with water")
            ],
            environment: .kitchen,
            hazards: [],
            timeLimit: 20,
            visualStyle: .chemicalFire,
            category: .firstAid,
            difficulty: .beginner,
            hazardLevel: .medium
        ),
        Scenario(
            title: "Wok Fire Flare-Up",
            description: "A wok fire from alcohol in a sauce has flared up and touched the overhead hood.",
            imageIcon: "flame.circle.fill",
            choices: [
                Choice(id: "1", text: "Wave towel over wok to fan out flames", isCorrect: false, explanation: "Fanning increases oxygen and worsens fire"),
                Choice(id: "2", text: "Remove wok from heat, use metal lid to smother", isCorrect: true, explanation: "Move fuel from heat source, then cut oxygen supply"),
                Choice(id: "3", text: "Pour water on flaming wok", isCorrect: false, explanation: "Water on alcohol fire spreads burning liquid"),
                Choice(id: "4", text: "Continue cooking and the flame will die down", isCorrect: false, explanation: "Flare-up touching hood vent is a serious escalation risk")
            ],
            environment: .kitchen,
            hazards: [.flammableLiquid],
            timeLimit: 30,
            visualStyle: .burn,
            category: .fire,
            difficulty: .intermediate,
            hazardLevel: .high
        ),
        Scenario(
            title: "Worker Heatstroke in Kitchen",
            description: "A kitchen worker is confused, stopped sweating, and has very hot skin.",
            imageIcon: "thermometer.high",
            choices: [
                Choice(id: "1", text: "Give them a cold drink and have them rest", isCorrect: false, explanation: "Heatstroke is a medical emergency; call 911"),
                Choice(id: "2", text: "Call 911, move to cool area, apply cool wet cloths", isCorrect: true, explanation: "Heatstroke requires emergency cooling and medical care"),
                Choice(id: "3", text: "Have them stand in front of kitchen fan", isCorrect: false, explanation: "Need to actively cool the body and call for emergency help"),
                Choice(id: "4", text: "Have them splash water on face and continue working", isCorrect: false, explanation: "Heatstroke requires them to stop work and get medical help")
            ],
            environment: .kitchen,
            hazards: [],
            timeLimit: 20,
            visualStyle: .general,
            category: .firstAid,
            difficulty: .intermediate,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Propane Cylinder Malfunction",
            description: "A portable propane cylinder used for catering outdoors is extremely hot to touch.",
            imageIcon: "cylinder.fill",
            choices: [
                Choice(id: "1", text: "Spray water on it to cool it down", isCorrect: false, explanation: "Water on overheating gas cylinder can cause BLEVE explosion"),
                Choice(id: "2", text: "Move everyone away and call emergency services", isCorrect: true, explanation: "Overheating propane cylinder can explode; evacuate and call 911"),
                Choice(id: "3", text: "Place in freezer to cool down quickly", isCorrect: false, explanation: "Do not transport overheating pressurized cylinder"),
                Choice(id: "4", text: "Slowly open valve to release pressure", isCorrect: false, explanation: "Do not approach or open overheating pressurized container")
            ],
            environment: .kitchen,
            hazards: [.gas, .flammableLiquid],
            timeLimit: 20,
            visualStyle: .explosion,
            category: .chemical,
            difficulty: .advanced,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Oven Grease Fire",
            description: "Grease has accumulated and caught fire inside a commercial oven.",
            imageIcon: "oven.fill",
            choices: [
                Choice(id: "1", text: "Open door and use water to extinguish", isCorrect: false, explanation: "Water on grease fire in oven causes explosive steam and spread"),
                Choice(id: "2", text: "Keep door closed, turn off oven, let it burn out safely", isCorrect: true, explanation: "Contain by keeping door closed; grease fire needs oxygen to burn"),
                Choice(id: "3", text: "Open door and blow out the flames", isCorrect: false, explanation: "Opening provides oxygen and spreading burning grease risk"),
                Choice(id: "4", text: "Use CO2 extinguisher through oven vents", isCorrect: false, explanation: "Cannot safely deliver extinguisher this way; keep door closed")
            ],
            environment: .kitchen,
            hazards: [.flammableLiquid],
            visualStyle: .burn,
            category: .fire,
            difficulty: .intermediate,
            hazardLevel: .high
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
        ),
        Scenario(
            title: "Forklift Accident",
            description: "A forklift has tipped over and the driver appears injured and pinned.",
            imageIcon: "car.fill",
            choices: [
                Choice(id: "1", text: "Try to pull driver out from under the forklift", isCorrect: false, explanation: "Moving crush injury victim can worsen spinal injuries"),
                Choice(id: "2", text: "Call 911, keep driver still, do not remove forklift yourself", isCorrect: true, explanation: "Stabilize and get professional help; forklift removal requires equipment"),
                Choice(id: "3", text: "Restart forklift to lift it off driver", isCorrect: false, explanation: "Restarting overturned forklift is extremely dangerous"),
                Choice(id: "4", text: "Have bystanders collectively lift the forklift", isCorrect: false, explanation: "Forklift too heavy; use proper lifting equipment with professionals")
            ],
            environment: .factory,
            hazards: [],
            timeLimit: 20,
            visualStyle: .mechanicalFire,
            category: .firstAid,
            difficulty: .advanced,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Confined Space Emergency",
            description: "A worker who entered a tank for inspection has collapsed inside.",
            imageIcon: "cylinder.split.1x2.fill",
            choices: [
                Choice(id: "1", text: "Immediately enter the tank to rescue them", isCorrect: false, explanation: "Confined space emergencies require trained rescuers with equipment"),
                Choice(id: "2", text: "Call confined space rescue team; do not enter without equipment", isCorrect: true, explanation: "Confined space rescue requires proper training and life safety equipment"),
                Choice(id: "3", text: "Lower a rope for them to grab", isCorrect: false, explanation: "Unconscious worker cannot grab a rope; need trained rescue"),
                Choice(id: "4", text: "Shout their name repeatedly to wake them", isCorrect: false, explanation: "Cannot waste time; call trained rescue team immediately")
            ],
            environment: .factory,
            hazards: [.gas],
            timeLimit: 20,
            visualStyle: .general,
            category: .evacuation,
            difficulty: .expert,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Lockout/Tagout Violation",
            description: "A maintenance worker forgot to lockout a machine that another person is now trying to start.",
            imageIcon: "lock.open.fill",
            choices: [
                Choice(id: "1", text: "Yell to warn them as they start the machine", isCorrect: false, explanation: "Verbal warning may be too late if they are already starting"),
                Choice(id: "2", text: "Apply lockout immediately and physically stop the startup", isCorrect: true, explanation: "Apply lockout/tagout before any work on energized equipment"),
                Choice(id: "3", text: "Complete maintenance quickly before they return", isCorrect: false, explanation: "Must apply lockout; rushing is never acceptable"),
                Choice(id: "4", text: "Ask them to wait a moment while you finish", isCorrect: false, explanation: "Immediate lockout is required; do not work without it")
            ],
            environment: .factory,
            hazards: [.electrical],
            timeLimit: 20,
            visualStyle: .electricalFire,
            category: .mechanical,
            difficulty: .advanced,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Chemical Skin Exposure",
            description: "A worker has been splashed with industrial solvent on arms and chest.",
            imageIcon: "figure.arms.open",
            choices: [
                Choice(id: "1", text: "Wipe off with work rag and continue working", isCorrect: false, explanation: "Industrial solvents penetrate skin and require immediate flushing"),
                Choice(id: "2", text: "Activate emergency shower, remove contaminated clothing", isCorrect: true, explanation: "Use emergency shower for full body decontamination"),
                Choice(id: "3", text: "Apply petroleum jelly to protect skin", isCorrect: false, explanation: "Must flush chemical off; petroleum jelly can trap chemical"),
                Choice(id: "4", text: "Cover with dry cloth to absorb solvent", isCorrect: false, explanation: "Must flush with water immediately; cloth is insufficient")
            ],
            environment: .factory,
            hazards: [],
            timeLimit: 20,
            visualStyle: .chemicalFire,
            category: .firstAid,
            difficulty: .intermediate,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Compressed Air Line Rupture",
            description: "A high-pressure compressed air line has ruptured and is whipping violently.",
            imageIcon: "wind",
            choices: [
                Choice(id: "1", text: "Try to grab the hose to point it safely", isCorrect: false, explanation: "High-pressure air hose can cause fatal air injection injuries"),
                Choice(id: "2", text: "Shut off compressor at main valve immediately", isCorrect: true, explanation: "Cut supply at source; do not approach whipping line"),
                Choice(id: "3", text: "Use foot to hold down the hose", isCorrect: false, explanation: "Do not use any body part to stop high-pressure air hose"),
                Choice(id: "4", text: "Warn others and continue working nearby", isCorrect: false, explanation: "Whipping high-pressure air line is a lethal hazard; shut down")
            ],
            environment: .factory,
            hazards: [],
            timeLimit: 20,
            visualStyle: .explosion,
            category: .mechanical,
            difficulty: .intermediate,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Machinery Entanglement",
            description: "A worker's sleeve has been caught in a rotating machine part.",
            imageIcon: "gearshape.2.fill",
            choices: [
                Choice(id: "1", text: "Pull their arm away forcefully", isCorrect: false, explanation: "Pulling against rotation can tear limb; stop machine first"),
                Choice(id: "2", text: "Hit emergency stop immediately", isCorrect: true, explanation: "Stop machine instantly; do not attempt extraction with machine running"),
                Choice(id: "3", text: "Reverse machine to unwind material", isCorrect: false, explanation: "Only stop machine; reversing can worsen entanglement"),
                Choice(id: "4", text: "Cut sleeve with nearby scissors quickly", isCorrect: false, explanation: "Stop machine first before any manual intervention")
            ],
            environment: .factory,
            hazards: [],
            timeLimit: 15,
            visualStyle: .mechanicalFire,
            category: .firstAid,
            difficulty: .expert,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Toxic Gas Alarm",
            description: "The plant's toxic gas detection system is alarming throughout the facility.",
            imageIcon: "exclamationmark.shield.fill",
            choices: [
                Choice(id: "1", text: "Look for the source of gas before evacuating", isCorrect: false, explanation: "Evacuate immediately; do not search for gas source"),
                Choice(id: "2", text: "Evacuate using upwind emergency routes immediately", isCorrect: true, explanation: "Evacuate upwind to avoid toxic gas cloud; follow emergency plan"),
                Choice(id: "3", text: "Cover mouth with work rag and continue working", isCorrect: false, explanation: "Work rag provides no protection from industrial toxic gas"),
                Choice(id: "4", text: "Shelter in place in an enclosed office", isCorrect: false, explanation: "Building HVAC can spread gas inside; evacuate upwind")
            ],
            environment: .factory,
            hazards: [.gas],
            timeLimit: 20,
            visualStyle: .gasLeak,
            category: .evacuation,
            difficulty: .intermediate,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Scaffold Collapse",
            description: "A scaffolding structure is creaking loudly and visibly swaying.",
            imageIcon: "wrench.fill",
            choices: [
                Choice(id: "1", text: "Quickly finish work and get down carefully", isCorrect: false, explanation: "Do not stay on unstable scaffolding; immediate descent required"),
                Choice(id: "2", text: "Stop work immediately, descend carefully, clear area below", isCorrect: true, explanation: "Evacuate scaffolding and clear fall zone before collapse"),
                Choice(id: "3", text: "Hold on and call for help from the scaffold", isCorrect: false, explanation: "Get off swaying scaffold; do not wait for it to collapse"),
                Choice(id: "4", text: "Move to the opposite side to redistribute weight", isCorrect: false, explanation: "Get off the scaffold entirely; do not try to stabilize it")
            ],
            environment: .factory,
            hazards: [],
            timeLimit: 20,
            visualStyle: .general,
            category: .evacuation,
            difficulty: .intermediate,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Chemical Tank Overpressure",
            description: "A chemical storage tank's pressure gauge is in the red zone and rising.",
            imageIcon: "gauge.open.with.lines.needle.33percent.and.arrowtriangle",
            choices: [
                Choice(id: "1", text: "Open vent valve manually to reduce pressure", isCorrect: false, explanation: "Opening vent without proper equipment risks chemical release"),
                Choice(id: "2", text: "Evacuate area and call emergency and plant engineer", isCorrect: true, explanation: "Overpressurized chemical tank can rupture catastrophically; evacuate"),
                Choice(id: "3", text: "Cool tank exterior with water spray", isCorrect: false, explanation: "Do not approach overpressurized chemical tank"),
                Choice(id: "4", text: "Check the gauge calibration first", isCorrect: false, explanation: "Do not approach; evacuate and call emergency services")
            ],
            environment: .factory,
            hazards: [.flammableLiquid],
            timeLimit: 20,
            visualStyle: .explosion,
            category: .chemical,
            difficulty: .expert,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Loading Dock Fall",
            description: "A worker has fallen from a loading dock onto the ground level below.",
            imageIcon: "person.fill.xmark",
            choices: [
                Choice(id: "1", text: "Have coworkers carry them back up immediately", isCorrect: false, explanation: "Moving fall victim without assessment risks worsening injuries"),
                Choice(id: "2", text: "Call 911, keep them still, do not remove helmet if wearing one", isCorrect: true, explanation: "Falls from height risk spinal injury; stabilize and get emergency help"),
                Choice(id: "3", text: "Give them water and help them sit up", isCorrect: false, explanation: "Do not move or give anything to drink; stabilize and call 911"),
                Choice(id: "4", text: "Have them walk to first aid station to check injuries", isCorrect: false, explanation: "Potential spinal injury means do not walk; call 911")
            ],
            environment: .factory,
            hazards: [],
            timeLimit: 20,
            visualStyle: .general,
            category: .firstAid,
            difficulty: .intermediate,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Welding Flash Burns",
            description: "A worker was exposed to welding flash without proper eye protection.",
            imageIcon: "eye.slash.fill",
            choices: [
                Choice(id: "1", text: "Rub eyes to relieve irritation", isCorrect: false, explanation: "Rubbing causes additional damage to flash-burned corneas"),
                Choice(id: "2", text: "Cover eyes, seek medical treatment; symptoms appear later", isCorrect: true, explanation: "Flash burns cause delayed pain; rest eyes and get medical assessment"),
                Choice(id: "3", text: "Continue working if no immediate pain", isCorrect: false, explanation: "Flash burn symptoms appear hours later; must get medical evaluation"),
                Choice(id: "4", text: "Apply eye drops and rest for 10 minutes", isCorrect: false, explanation: "Medical evaluation is required; eye drops alone are insufficient")
            ],
            environment: .factory,
            hazards: [],
            timeLimit: 30,
            visualStyle: .general,
            category: .firstAid,
            difficulty: .intermediate,
            hazardLevel: .high
        ),
        Scenario(
            title: "Electrical Shock to Coworker",
            description: "A coworker is frozen and being electrocuted by contact with live equipment.",
            imageIcon: "bolt.heart.fill",
            choices: [
                Choice(id: "1", text: "Pull them away from the equipment immediately", isCorrect: false, explanation: "Direct contact with electrocution victim makes you victim too"),
                Choice(id: "2", text: "Cut power at breaker, then render first aid", isCorrect: true, explanation: "Must eliminate electrical hazard before approaching victim"),
                Choice(id: "3", text: "Push them away with a wooden board", isCorrect: false, explanation: "Cut power at breaker first; this is faster and safer"),
                Choice(id: "4", text: "Throw water to disconnect the circuit", isCorrect: false, explanation: "Water conducts electricity; will make situation worse")
            ],
            environment: .factory,
            hazards: [.electrical],
            timeLimit: 15,
            visualStyle: .electricalFire,
            category: .firstAid,
            difficulty: .advanced,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Chlorine Gas Leak",
            description: "You detect a sharp smell and workers are coughing near the water treatment area.",
            imageIcon: "smoke.fill",
            choices: [
                Choice(id: "1", text: "Cover mouth and investigate the source", isCorrect: false, explanation: "Cloth is no protection from chlorine; evacuate upwind"),
                Choice(id: "2", text: "Evacuate upwind, call emergency services, do not re-enter", isCorrect: true, explanation: "Chlorine gas is acutely toxic; evacuate upwind and call 911"),
                Choice(id: "3", text: "Use air freshener to neutralize the smell", isCorrect: false, explanation: "Air freshener cannot neutralize toxic gas"),
                Choice(id: "4", text: "Run through the gas cloud to get to the exit", isCorrect: false, explanation: "Find upwind exit route; running through chlorine cloud is dangerous")
            ],
            environment: .factory,
            hazards: [.gas],
            timeLimit: 20,
            visualStyle: .gasLeak,
            category: .chemical,
            difficulty: .advanced,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Pressurized Vessel Rupture",
            description: "A pressurized steam vessel is making high-pitched sounds and leaking steam.",
            imageIcon: "arrow.up.left.and.down.right.and.arrow.up.right.and.down.left",
            choices: [
                Choice(id: "1", text: "Try to tighten the leaking fittings", isCorrect: false, explanation: "Do not approach leaking pressurized vessel"),
                Choice(id: "2", text: "Evacuate area, activate emergency stop, call plant engineer", isCorrect: true, explanation: "Pressurized vessel failure can be catastrophic; evacuate immediately"),
                Choice(id: "3", text: "Cool with water spray from a distance", isCorrect: false, explanation: "Do not approach; thermal shock can accelerate failure"),
                Choice(id: "4", text: "Slowly open pressure relief valve manually", isCorrect: false, explanation: "Do not approach leaking pressurized vessel; evacuate")
            ],
            environment: .factory,
            hazards: [],
            timeLimit: 15,
            visualStyle: .explosion,
            category: .mechanical,
            difficulty: .expert,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Heat Exhaustion at Work",
            description: "A worker doing heavy physical work is pale, sweating heavily, and feeling faint.",
            imageIcon: "thermometer.sun.fill",
            choices: [
                Choice(id: "1", text: "Have them keep working slowly to push through", isCorrect: false, explanation: "Heat exhaustion can progress to heatstroke; stop work"),
                Choice(id: "2", text: "Move to cool area, provide water, rest, monitor closely", isCorrect: true, explanation: "Cool environment and hydration treats heat exhaustion"),
                Choice(id: "3", text: "Give caffeinated energy drink for energy", isCorrect: false, explanation: "Caffeine is a diuretic and worsens dehydration"),
                Choice(id: "4", text: "Have them lie in the sun to keep muscles warm", isCorrect: false, explanation: "Must move to cool area; sun exposure worsens heat exhaustion")
            ],
            environment: .factory,
            hazards: [],
            timeLimit: 30,
            visualStyle: .general,
            category: .firstAid,
            difficulty: .intermediate,
            hazardLevel: .high
        ),
        Scenario(
            title: "Industrial Crane Load Drop",
            description: "The crane operator signals a suspended load is about to drop.",
            imageIcon: "arrow.down.circle.fill",
            choices: [
                Choice(id: "1", text: "Run underneath to try to catch the load", isCorrect: false, explanation: "Never stand under suspended loads; clear the area"),
                Choice(id: "2", text: "Clear all personnel from the drop zone immediately", isCorrect: true, explanation: "Suspended load drop zone must be completely clear of personnel"),
                Choice(id: "3", text: "Brace yourself against a sturdy wall nearby", isCorrect: false, explanation: "Must clear the area; a wall does not protect from falling load"),
                Choice(id: "4", text: "Signal crane operator to hold by hand waving", isCorrect: false, explanation: "Clear people first; operator must be contacted via radio")
            ],
            environment: .factory,
            hazards: [],
            timeLimit: 15,
            visualStyle: .general,
            category: .evacuation,
            difficulty: .intermediate,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Solvent Storage Room Fire",
            description: "Fire has broken out in the solvent storage room.",
            imageIcon: "flame.fill",
            choices: [
                Choice(id: "1", text: "Open doors to ventilate the fire", isCorrect: false, explanation: "Solvent storage fire is a BLEVE risk; do not open doors"),
                Choice(id: "2", text: "Activate plant alarm, evacuate building, call fire services", isCorrect: true, explanation: "Solvent fires can explode; full evacuation and professional response needed"),
                Choice(id: "3", text: "Use CO2 extinguisher through door crack", isCorrect: false, explanation: "Solvent storage fire cannot safely be fought by workers"),
                Choice(id: "4", text: "Move adjacent containers away from the fire room", isCorrect: false, explanation: "Do not approach; solvent fires can explode at any moment")
            ],
            environment: .factory,
            hazards: [.flammableLiquid, .heavySmoke],
            timeLimit: 20,
            visualStyle: .chemicalFire,
            category: .fire,
            difficulty: .advanced,
            hazardLevel: .critical
        ),
        Scenario(
            title: "PPE Failure During Chemical Work",
            description: "Your respirator has run out of air while working in a hazardous atmosphere.",
            imageIcon: "lungs.fill",
            choices: [
                Choice(id: "1", text: "Remove respirator and work quickly without it", isCorrect: false, explanation: "Hazardous atmosphere requires respiratory protection at all times"),
                Choice(id: "2", text: "Exit hazardous area immediately without removing respirator", isCorrect: true, explanation: "Leave the hazardous area immediately; do not work without protection"),
                Choice(id: "3", text: "Share respirator with nearest colleague", isCorrect: false, explanation: "Cannot share respiratory protection; both must exit area"),
                Choice(id: "4", text: "Hold breath and finish the task quickly", isCorrect: false, explanation: "Toxic atmosphere can affect consciousness instantly; exit immediately")
            ],
            environment: .factory,
            hazards: [.gas],
            timeLimit: 15,
            visualStyle: .chemicalFire,
            category: .evacuation,
            difficulty: .advanced,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Electrical Transformer Fire",
            description: "The outdoor electrical transformer is on fire with black smoke.",
            imageIcon: "bolt.fill",
            choices: [
                Choice(id: "1", text: "Use CO2 fire extinguisher on transformer", isCorrect: false, explanation: "High voltage transformer fire requires keeping 30m clearance"),
                Choice(id: "2", text: "Keep 30m clearance, call fire services, cut upstream power", isCorrect: true, explanation: "High voltage fire requires emergency services and safe distance"),
                Choice(id: "3", text: "Use dry sand to smother transformer fire", isCorrect: false, explanation: "Do not approach; high voltage transformer fires are lethal"),
                Choice(id: "4", text: "Pour water from a safe distance", isCorrect: false, explanation: "Never use water on high voltage electrical equipment")
            ],
            environment: .factory,
            hazards: [.electrical, .heavySmoke],
            timeLimit: 20,
            visualStyle: .electricalFire,
            category: .electrical,
            difficulty: .expert,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Material Handling Crush Injury",
            description: "A worker has their hand crushed between two heavy materials being moved.",
            imageIcon: "hand.raised.fill",
            choices: [
                Choice(id: "1", text: "Pull hand free immediately", isCorrect: false, explanation: "Pulling can worsen crush injury; stabilize first"),
                Choice(id: "2", text: "Stop movement, carefully release pressure, call 911", isCorrect: true, explanation: "Stop machinery/movement, carefully relieve crushing force, get emergency help"),
                Choice(id: "3", text: "Wrap in bandage and continue to hospital by car", isCorrect: false, explanation: "Crush injuries can be life-threatening; call 911"),
                Choice(id: "4", text: "Apply ice pack and elevate the hand", isCorrect: false, explanation: "Must relieve crushing force first; then call 911")
            ],
            environment: .factory,
            hazards: [],
            timeLimit: 20,
            visualStyle: .general,
            category: .firstAid,
            difficulty: .advanced,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Spill of Hazardous Chemical",
            description: "A drum of hazardous liquid has overturned and is spreading across the factory floor.",
            imageIcon: "drop.fill",
            choices: [
                Choice(id: "1", text: "Mop it up quickly with paper towels", isCorrect: false, explanation: "Hazardous chemical requires proper PPE and containment equipment"),
                Choice(id: "2", text: "Don appropriate PPE, use spill kit to contain and absorb", isCorrect: true, explanation: "Proper PPE and spill kit are required for hazardous liquid spills"),
                Choice(id: "3", text: "Flush down floor drain with water hose", isCorrect: false, explanation: "Hazardous chemicals must not enter drains; environmental violation"),
                Choice(id: "4", text: "Wait for chemical to evaporate naturally", isCorrect: false, explanation: "Evaporation creates toxic vapor; contain and clean immediately")
            ],
            environment: .factory,
            hazards: [.flammableLiquid],
            visualStyle: .chemicalFire,
            category: .chemical,
            difficulty: .intermediate,
            hazardLevel: .high
        ),
        Scenario(
            title: "Arc Flash Incident",
            description: "A maintenance worker is working on an electrical panel and an arc flash occurs.",
            imageIcon: "bolt.trianglebadge.exclamationmark.fill",
            choices: [
                Choice(id: "1", text: "Approach immediately to check if they are okay", isCorrect: false, explanation: "Arc flash area may still be energized; cut power first"),
                Choice(id: "2", text: "Cut power at upstream breaker before approaching", isCorrect: true, explanation: "Ensure power is cut before approaching arc flash victim"),
                Choice(id: "3", text: "Use CO2 extinguisher to clear the area", isCorrect: false, explanation: "Must cut power first; extinguisher not appropriate here"),
                Choice(id: "4", text: "Spray water from distance to dissipate energy", isCorrect: false, explanation: "Water and high voltage is lethal; cut power first")
            ],
            environment: .factory,
            hazards: [.electrical],
            timeLimit: 20,
            visualStyle: .electricalFire,
            category: .electrical,
            difficulty: .expert,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Emergency Stop Test",
            description: "A worker is testing equipment and realizes the emergency stop is unresponsive.",
            imageIcon: "stop.circle.fill",
            choices: [
                Choice(id: "1", text: "Note it in the log and continue working", isCorrect: false, explanation: "Non-functional emergency stop is a critical safety defect"),
                Choice(id: "2", text: "Stop all operations on that machine, tag out, call maintenance", isCorrect: true, explanation: "Equipment without functional emergency stop must be taken out of service"),
                Choice(id: "3", text: "Use the machine carefully while avoiding hazards", isCorrect: false, explanation: "Non-functional emergency stop makes machine unsafe to operate"),
                Choice(id: "4", text: "Bypass the emergency stop and continue testing", isCorrect: false, explanation: "Never bypass safety systems")
            ],
            environment: .factory,
            hazards: [],
            visualStyle: .mechanicalFire,
            category: .mechanical,
            difficulty: .intermediate,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Conveyor Belt Jam with Person Nearby",
            description: "A conveyor belt has jammed and a worker is attempting to clear it while running.",
            imageIcon: "arrow.right.circle.fill",
            choices: [
                Choice(id: "1", text: "Help them clear the jam faster", isCorrect: false, explanation: "Never clear conveyor jam while running; lockout first"),
                Choice(id: "2", text: "Hit emergency stop and shout at worker to stop", isCorrect: true, explanation: "Stop the equipment; clearing a running conveyor is extremely dangerous"),
                Choice(id: "3", text: "Slow down the conveyor speed", isCorrect: false, explanation: "Stop completely; any movement is dangerous during maintenance"),
                Choice(id: "4", text: "Tell them to be careful and keep going", isCorrect: false, explanation: "Must stop conveyor; working on running equipment is never acceptable")
            ],
            environment: .factory,
            hazards: [],
            timeLimit: 15,
            visualStyle: .mechanicalFire,
            category: .mechanical,
            difficulty: .advanced,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Industrial Fire Suppression",
            description: "The factory fire suppression system activates in the paint storage area.",
            imageIcon: "drop.fill",
            choices: [
                Choice(id: "1", text: "Re-enter to save materials before suppression soaks them", isCorrect: false, explanation: "Suppression activates for a reason; do not enter the area"),
                Choice(id: "2", text: "Evacuate, verify all personnel out, call fire services", isCorrect: true, explanation: "Treat suppression activation as real emergency; evacuate and verify headcount"),
                Choice(id: "3", text: "Turn off suppression system to prevent product damage", isCorrect: false, explanation: "Never disable fire suppression during activation"),
                Choice(id: "4", text: "Check if activation is accidental before evacuating", isCorrect: false, explanation: "Treat every activation as real; verify from outside")
            ],
            environment: .factory,
            hazards: [.flammableLiquid],
            timeLimit: 20,
            visualStyle: .chemicalFire,
            category: .evacuation,
            difficulty: .intermediate,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Boiler Room Emergency",
            description: "The boiler room pressure alarm is sounding and steam is visible from seams.",
            imageIcon: "thermometer.high",
            choices: [
                Choice(id: "1", text: "Manually adjust boiler controls to reduce pressure", isCorrect: false, explanation: "Do not enter or operate leaking high-pressure boiler"),
                Choice(id: "2", text: "Evacuate the area and contact boiler engineer immediately", isCorrect: true, explanation: "High-pressure boiler emergency requires trained professional response"),
                Choice(id: "3", text: "Cool boiler room with water spray", isCorrect: false, explanation: "Do not approach; leaking high-pressure steam is lethal"),
                Choice(id: "4", text: "Open boiler room windows for ventilation", isCorrect: false, explanation: "Do not enter boiler room during pressure emergency")
            ],
            environment: .factory,
            hazards: [],
            timeLimit: 20,
            visualStyle: .explosion,
            category: .mechanical,
            difficulty: .advanced,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Natural Gas Leak in Plant",
            description: "A natural gas pipe is leaking in the manufacturing area.",
            imageIcon: "cloud.fog.fill",
            choices: [
                Choice(id: "1", text: "Turn on ventilation fans to remove gas", isCorrect: false, explanation: "Fan motor sparks can ignite natural gas"),
                Choice(id: "2", text: "Avoid all electrical switches, evacuate, call gas company", isCorrect: true, explanation: "No sparks near gas; evacuate and let professionals respond"),
                Choice(id: "3", text: "Find and tighten the leaking connection", isCorrect: false, explanation: "Do not approach gas leak without proper training and equipment"),
                Choice(id: "4", text: "Use electrical tape to seal the leak temporarily", isCorrect: false, explanation: "Do not approach gas leak; tape cannot seal pressure fitting")
            ],
            environment: .factory,
            hazards: [.gas, .flammableLiquid],
            timeLimit: 20,
            visualStyle: .gasLeak,
            category: .chemical,
            difficulty: .intermediate,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Pneumatic System Overpressure",
            description: "Pressure gauge on pneumatic system reads 50% above normal operating range.",
            imageIcon: "gauge.with.dots.needle.100percent",
            choices: [
                Choice(id: "1", text: "Ignore it, gauges often read high", isCorrect: false, explanation: "Overpressure in pneumatic systems can cause catastrophic failure"),
                Choice(id: "2", text: "Shut down system, call maintenance, isolate from production", isCorrect: true, explanation: "Overpressure is a critical safety condition; shut down and investigate"),
                Choice(id: "3", text: "Manually bleed pressure from the system", isCorrect: false, explanation: "Must follow proper shutdown procedure; untrained bleeding is dangerous"),
                Choice(id: "4", text: "Increase cooling to bring pressure down", isCorrect: false, explanation: "Must shut down; do not attempt to manage overpressure yourself")
            ],
            environment: .factory,
            hazards: [],
            timeLimit: 30,
            visualStyle: .explosion,
            category: .mechanical,
            difficulty: .intermediate,
            hazardLevel: .high
        ),
        Scenario(
            title: "Ammonia Leak in Refrigeration",
            description: "A cold storage area has a strong ammonia smell from the refrigeration system.",
            imageIcon: "refrigerator.fill",
            choices: [
                Choice(id: "1", text: "Enter and check the refrigeration equipment", isCorrect: false, explanation: "Ammonia is toxic; do not enter without SCBA respiratory protection"),
                Choice(id: "2", text: "Evacuate all personnel, call hazmat response team", isCorrect: true, explanation: "Industrial ammonia leaks are toxic emergencies requiring hazmat response"),
                Choice(id: "3", text: "Use wet cloth over nose and enter to fix leak", isCorrect: false, explanation: "Wet cloth provides no protection from industrial ammonia concentrations"),
                Choice(id: "4", text: "Open loading bay doors to ventilate", isCorrect: false, explanation: "Do not approach area; evacuate and call hazmat")
            ],
            environment: .factory,
            hazards: [.gas],
            timeLimit: 20,
            visualStyle: .gasLeak,
            category: .chemical,
            difficulty: .advanced,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Welding Smoke Inhalation",
            description: "A welder is complaining of severe headache and nausea from welding zinc-coated metal.",
            imageIcon: "smoke.fill",
            choices: [
                Choice(id: "1", text: "Have them rest and continue later", isCorrect: false, explanation: "Metal fume fever from zinc is a medical issue requiring fresh air and monitoring"),
                Choice(id: "2", text: "Take to fresh air, provide water, seek medical evaluation", isCorrect: true, explanation: "Remove from exposure, hydrate, get medical assessment for metal fume fever"),
                Choice(id: "3", text: "Give them salt water to drink to flush metals", isCorrect: false, explanation: "Salt water does not treat metal fume fever; seek medical care"),
                Choice(id: "4", text: "Have them breathe through work gloves as filter", isCorrect: false, explanation: "Gloves provide no respiratory protection; get to fresh air")
            ],
            environment: .factory,
            hazards: [.gas, .heavySmoke],
            timeLimit: 30,
            visualStyle: .chemicalFire,
            category: .firstAid,
            difficulty: .intermediate,
            hazardLevel: .high
        ),
        Scenario(
            title: "Falling Object from Height",
            description: "A worker above drops a heavy tool that falls toward workers below.",
            imageIcon: "arrow.down.circle.fill",
            choices: [
                Choice(id: "1", text: "Try to catch the falling tool", isCorrect: false, explanation: "Never attempt to catch falling heavy objects from height"),
                Choice(id: "2", text: "Shout warning and move out of fall path", isCorrect: true, explanation: "Warn others and move clear of fall zone immediately"),
                Choice(id: "3", text: "Shield head with arms and stay still", isCorrect: false, explanation: "Arms cannot protect from heavy falling tool; move away"),
                Choice(id: "4", text: "Stand behind nearby machinery for protection", isCorrect: false, explanation: "Move clear of the fall zone; do not hide near falling path")
            ],
            environment: .factory,
            hazards: [],
            timeLimit: 10,
            visualStyle: .general,
            category: .evacuation,
            difficulty: .beginner,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Hazardous Waste Drum Fire",
            description: "A drum of hazardous waste is on fire in the storage area.",
            imageIcon: "xmark.bin.fill",
            choices: [
                Choice(id: "1", text: "Use standard ABC extinguisher on the drum", isCorrect: false, explanation: "Unknown hazardous waste may require specialized extinguishing agent"),
                Choice(id: "2", text: "Evacuate area, call hazmat fire response team", isCorrect: true, explanation: "Hazardous waste fire requires specialized hazmat response"),
                Choice(id: "3", text: "Cool the drum with water to prevent explosion", isCorrect: false, explanation: "Water may react with drum contents; do not approach"),
                Choice(id: "4", text: "Move adjacent drums away from heat", isCorrect: false, explanation: "Do not approach hazardous waste fire; evacuate immediately")
            ],
            environment: .factory,
            hazards: [.flammableLiquid, .heavySmoke],
            timeLimit: 20,
            visualStyle: .chemicalFire,
            category: .chemical,
            difficulty: .advanced,
            hazardLevel: .critical
        ),
        Scenario(
            title: "High Voltage Proximity Alarm",
            description: "You hear the high voltage proximity alarm while using a crane near overhead lines.",
            imageIcon: "powerline",
            choices: [
                Choice(id: "1", text: "Quickly move crane away from lines", isCorrect: false, explanation: "Moving crane could cause contact with high voltage lines"),
                Choice(id: "2", text: "Freeze crane movement, shut down, call safety officer", isCorrect: true, explanation: "Stop all movement; proximity to high voltage lines requires immediate expert response"),
                Choice(id: "3", text: "Lower crane speed to inch away carefully", isCorrect: false, explanation: "Any movement near high voltage lines is dangerous; stop completely"),
                Choice(id: "4", text: "Step out of crane cab to get away from lines", isCorrect: false, explanation: "Stay inside; exiting near energized lines is extremely dangerous")
            ],
            environment: .factory,
            hazards: [.electrical],
            timeLimit: 15,
            visualStyle: .electricalFire,
            category: .electrical,
            difficulty: .expert,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Chemical Eye Exposure at Work",
            description: "A factory worker gets industrial cleaner splashed directly in both eyes.",
            imageIcon: "eye.fill",
            choices: [
                Choice(id: "1", text: "Wipe eyes with work cloth", isCorrect: false, explanation: "Wiping spreads chemical and causes more damage"),
                Choice(id: "2", text: "Use emergency eyewash station for 15+ minutes", isCorrect: true, explanation: "Immediate prolonged flushing is essential for chemical eye exposure"),
                Choice(id: "3", text: "Keep eyes closed and wait for first aid responder", isCorrect: false, explanation: "Must flush immediately; waiting increases damage"),
                Choice(id: "4", text: "Apply saline drops from first aid kit", isCorrect: false, explanation: "Must flush with copious water; drops are insufficient")
            ],
            environment: .factory,
            hazards: [],
            timeLimit: 20,
            visualStyle: .general,
            category: .firstAid,
            difficulty: .intermediate,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Paint Spray Booth Fire",
            description: "A fire has started inside the paint spray booth.",
            imageIcon: "paintbrush.pointed.fill",
            choices: [
                Choice(id: "1", text: "Open booth door and spray water inside", isCorrect: false, explanation: "Opening provides oxygen; water spreads paint/solvent fire"),
                Choice(id: "2", text: "Activate booth suppression, shut down spray operations, evacuate", isCorrect: true, explanation: "Use built-in suppression, stop operations, and evacuate area"),
                Choice(id: "3", text: "Continue spraying paint to use up flammable material", isCorrect: false, explanation: "Adding flammable material to an active fire is extremely dangerous"),
                Choice(id: "4", text: "Open ventilation to clear fumes and smoke", isCorrect: false, explanation: "Ventilation in booth fire can spread flames through ductwork")
            ],
            environment: .factory,
            hazards: [.flammableLiquid, .heavySmoke],
            timeLimit: 20,
            visualStyle: .chemicalFire,
            category: .fire,
            difficulty: .advanced,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Worker Pinch Point Injury",
            description: "A worker's finger is caught in a pinch point between two machine parts.",
            imageIcon: "wrench.adjustable.fill",
            choices: [
                Choice(id: "1", text: "Pull finger out forcefully while machine is running", isCorrect: false, explanation: "Do not attempt extraction with machine running; stop machine first"),
                Choice(id: "2", text: "Emergency stop machine, apply lockout, then extract carefully", isCorrect: true, explanation: "Stop and lockout machine before any attempt to free trapped limb"),
                Choice(id: "3", text: "Reverse machine to release", isCorrect: false, explanation: "Apply lockout; do not run machine in any direction with person trapped"),
                Choice(id: "4", text: "Apply lubrication to help slide finger out", isCorrect: false, explanation: "Machine must be stopped and locked out first")
            ],
            environment: .factory,
            hazards: [],
            timeLimit: 15,
            visualStyle: .mechanicalFire,
            category: .firstAid,
            difficulty: .advanced,
            hazardLevel: .critical
        ),
        Scenario(
            title: "Oxygen Deficient Atmosphere",
            description: "Workers in a silo are becoming dizzy without apparent cause.",
            imageIcon: "lungs.fill",
            choices: [
                Choice(id: "1", text: "Help them out by pulling their arms", isCorrect: false, explanation: "Rescuer without SCBA in oxygen-deficient space will also collapse"),
                Choice(id: "2", text: "Do not enter, call confined space rescue with SCBA", isCorrect: true, explanation: "Oxygen-deficient atmosphere requires SCBA; only trained rescue should enter"),
                Choice(id: "3", text: "Lower a rope for them to grab and pull themselves out", isCorrect: false, explanation: "Unconscious or incapacitated workers cannot self-rescue"),
                Choice(id: "4", text: "Turn on fans to push more air in", isCorrect: false, explanation: "Call trained rescue team immediately; fans may be insufficient")
            ],
            environment: .factory,
            hazards: [.gas],
            timeLimit: 20,
            visualStyle: .general,
            category: .evacuation,
            difficulty: .expert,
            hazardLevel: .critical
        )
    ]
}
