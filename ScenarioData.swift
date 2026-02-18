import Foundation

struct ScenarioData {
    static func scenarios(for environment: EnvironmentType) -> [Scenario] {
        switch environment {
        case .lab:
            return labScenarios
        case .warehouse:
            return warehouseScenarios
        case .office:
            return officeScenarios
        case .kitchen:
            return kitchenScenarios
        case .serverRoom:
            return serverRoomScenarios
        case .factory:
            return factoryScenarios
        }
    }
    
    // MARK: - Lab Scenarios
    static let labScenarios: [Scenario] = [
        Scenario(
            title: "Chemical Fire Emergency",
            description: "A beaker containing flammable chemicals has caught fire on the workbench. Flames are spreading rapidly.",
            environment: .lab,
            hazardType: .flammableLiquid,
            imageIcon: "flame.fill",
            interactionType: .multipleChoice,
            choices: [
                Choice(id: "1", text: "Use water extinguisher", consequence: "Fire spreads violently! Chemical fires react badly with water.", isCorrect: false, explanation: "Water can react with certain chemicals and spread the fire."),
                Choice(id: "2", text: "Use CO2 extinguisher", consequence: "Fire contained! Correct choice for chemical fires.", isCorrect: true, explanation: "CO2 extinguishers are safe for chemical fires and don't leave residue."),
                Choice(id: "3", text: "Cover with lab coat", consequence: "Lab coat catches fire! You're now in danger.", isCorrect: false, explanation: "Fabric can easily catch fire and worsen the situation."),
                Choice(id: "4", text: "Run away immediately", consequence: "Fire spreads to other chemicals causing explosion.", isCorrect: false, explanation: "Abandoning without action can lead to catastrophic results.")
            ],
            correctChoiceId: "2",
            educationalContext: "Chemical fires require Class B or C extinguishers. Never use water on chemical fires.",
            urgencyLevel: .critical,
            responseSteps: [
                ResponseStep(stepNumber: 1, instruction: "Activate fire alarm", icon: "bell.fill"),
                ResponseStep(stepNumber: 2, instruction: "Grab CO2 extinguisher", icon: "wind"),
                ResponseStep(stepNumber: 3, instruction: "Aim at base of fire", icon: "scope"),
                ResponseStep(stepNumber: 4, instruction: "Sweep side to side", icon: "arrow.left.and.right"),
                ResponseStep(stepNumber: 5, instruction: "Evacuate if fire grows", icon: "figure.run")
            ]
        ),
        Scenario(
            title: "Gas Leak Detection",
            description: "You smell a strong chemical odor near the gas storage area. A hissing sound is audible.",
            environment: .lab,
            hazardType: .gas,
            imageIcon: "wind",
            interactionType: .multipleChoice,
            choices: [
                Choice(id: "1", text: "Turn on exhaust fan", consequence: "Sparks from fan motor ignite gas! Explosion!", isCorrect: false, explanation: "Electrical switches can create sparks that ignite gas."),
                Choice(id: "2", text: "Open windows and evacuate", consequence: "Correct! You ventilate safely and alert others.", isCorrect: true, explanation: "Manual ventilation and evacuation prevent ignition and protect everyone."),
                Choice(id: "3", text: "Light a match to see better", consequence: "Massive explosion! Critical mistake!", isCorrect: false, explanation: "Open flames and gas are a deadly combination."),
                Choice(id: "4", text: "Try to fix the leak yourself", consequence: "Gas overcomes you. You collapse.", isCorrect: false, explanation: "Only trained personnel should handle gas leaks.")
            ],
            correctChoiceId: "2",
            educationalContext: "Gas leaks require immediate evacuation. Avoid all electrical switches and open flames.",
            urgencyLevel: .critical,
            responseSteps: [
                ResponseStep(stepNumber: 1, instruction: "Do not use electrical switches", icon: "bolt.slash"),
                ResponseStep(stepNumber: 2, instruction: "Open windows manually", icon: "rectangle.portrait.and.arrow.right"),
                ResponseStep(stepNumber: 3, instruction: "Evacuate everyone calmly", icon: "figure.walk"),
                ResponseStep(stepNumber: 4, instruction: "Call emergency from safe distance", icon: "phone.fill"),
                ResponseStep(stepNumber: 5, instruction: "Alert building security", icon: "exclamationmark.shield.fill")
            ]
        ),
        Scenario(
            title: "Electrical Equipment Sparking",
            description: "The laboratory centrifuge is sparking and smoking. It's still plugged in.",
            environment: .lab,
            hazardType: .electrical,
            imageIcon: "bolt.fill",
            interactionType: .multipleChoice,
            choices: [
                Choice(id: "1", text: "Unplug it immediately", consequence: "You get shocked! Metal plug conducts electricity.", isCorrect: false, explanation: "Never touch electrical equipment that's malfunctioning."),
                Choice(id: "2", text: "Turn off circuit breaker first", consequence: "Perfect! Power cut safely, then assess.", isCorrect: true, explanation: "Always cut power at the source before handling electrical emergencies."),
                Choice(id: "3", text: "Pour water on it", consequence: "Electric shock through water! Fatal mistake!", isCorrect: false, explanation: "Water conducts electricity and can electrocute you."),
                Choice(id: "4", text: "Continue working, it's fine", consequence: "Equipment catches fire. Lab evacuated.", isCorrect: false, explanation: "Ignoring electrical hazards can lead to fires.")
            ],
            correctChoiceId: "2",
            educationalContext: "Electrical emergencies require cutting power at the breaker before any intervention.",
            urgencyLevel: .high,
            responseSteps: [
                ResponseStep(stepNumber: 1, instruction: "Do not touch equipment", icon: "hand.raised.fill"),
                ResponseStep(stepNumber: 2, instruction: "Locate circuit breaker", icon: "square.grid.2x2"),
                ResponseStep(stepNumber: 3, instruction: "Switch off power", icon: "power"),
                ResponseStep(stepNumber: 4, instruction: "Use appropriate fire extinguisher if needed", icon: "flame.fill"),
                ResponseStep(stepNumber: 5, instruction: "Report to facilities", icon: "wrench.fill")
            ]
        ),
        Scenario(
            title: "Acid Spill on Floor",
            description: "A large bottle of sulfuric acid has spilled across the lab floor. Fumes are rising.",
            environment: .lab,
            hazardType: .flammableLiquid,
            imageIcon: "drop.fill",
            interactionType: .multipleChoice,
            choices: [
                Choice(id: "1", text: "Wipe with paper towels", consequence: "Acid burns through paper and your gloves!", isCorrect: false, explanation: "Concentrated acid requires proper neutralization, not absorption."),
                Choice(id: "2", text: "Use spill kit and neutralize", consequence: "Excellent! You follow proper protocol.", isCorrect: true, explanation: "Chemical spill kits contain neutralizers and proper PPE."),
                Choice(id: "3", text: "Wash down drain with water", consequence: "Acid damages pipes and creates toxic fumes!", isCorrect: false, explanation: "Acids must be neutralized before disposal."),
                Choice(id: "4", text: "Ignore it, it will evaporate", consequence: "Fumes injure several people. Lab closed.", isCorrect: false, explanation: "Acid fumes are dangerous and the liquid is corrosive.")
            ],
            correctChoiceId: "2",
            educationalContext: "Chemical spills require containment, neutralization, and proper disposal using spill kits.",
            urgencyLevel: .high,
            responseSteps: [
                ResponseStep(stepNumber: 1, instruction: "Alert others in area", icon: "speaker.wave.3.fill"),
                ResponseStep(stepNumber: 2, instruction: "Put on protective equipment", icon: "shield.fill"),
                ResponseStep(stepNumber: 3, instruction: "Use spill kit to contain", icon: "box.fill"),
                ResponseStep(stepNumber: 4, instruction: "Apply neutralizing agent", icon: "drop.triangle.fill"),
                ResponseStep(stepNumber: 5, instruction: "Dispose in hazmat container", icon: "trash.fill")
            ]
        )
    ]
    
    // MARK: - Warehouse Scenarios
    static let warehouseScenarios: [Scenario] = [
        Scenario(
            title: "Forklift Fire",
            description: "A forklift's engine compartment is on fire. Fuel is leaking onto the floor.",
            environment: .warehouse,
            hazardType: .flammableLiquid,
            imageIcon: "flame.fill",
            interactionType: .multipleChoice,
            choices: [
                Choice(id: "1", text: "Use foam extinguisher", consequence: "Perfect! Foam suppresses fuel fires effectively.", isCorrect: true, explanation: "Foam extinguishers are designed for fuel and oil fires."),
                Choice(id: "2", text: "Use water hose", consequence: "Fire spreads! Water floats on fuel.", isCorrect: false, explanation: "Water is ineffective on fuel fires and can spread them."),
                Choice(id: "3", text: "Drive forklift outside", consequence: "You're overcome by smoke while driving!", isCorrect: false, explanation: "Never operate burning equipment."),
                Choice(id: "4", text: "Wait for fire department", consequence: "Fire spreads to pallets. Major damage.", isCorrect: false, explanation: "Immediate action with proper equipment can prevent escalation.")
            ],
            correctChoiceId: "1",
            educationalContext: "Fuel fires require foam or dry chemical extinguishers. Never use water.",
            urgencyLevel: .critical,
            responseSteps: [
                ResponseStep(stepNumber: 1, instruction: "Sound alarm", icon: "bell.fill"),
                ResponseStep(stepNumber: 2, instruction: "Grab foam extinguisher", icon: "wind.snow"),
                ResponseStep(stepNumber: 3, instruction: "Approach from upwind", icon: "arrow.up"),
                ResponseStep(stepNumber: 4, instruction: "Aim at base of flames", icon: "scope"),
                ResponseStep(stepNumber: 5, instruction: "Create foam blanket", icon: "cloud.fill")
            ]
        ),
        Scenario(
            title: "Electrical Panel Smoking",
            description: "The main electrical panel is smoking heavily. Lights are flickering throughout the warehouse.",
            environment: .warehouse,
            hazardType: .electrical,
            imageIcon: "bolt.fill",
            interactionType: .multipleChoice,
            choices: [
                Choice(id: "1", text: "Open panel to investigate", consequence: "Arc flash burns you severely!", isCorrect: false, explanation: "Never open smoking electrical panels."),
                Choice(id: "2", text: "Call electrician and evacuate area", consequence: "Correct! Safety first, professionals handle it.", isCorrect: true, explanation: "Electrical panel emergencies require qualified electricians."),
                Choice(id: "3", text: "Use CO2 extinguisher on panel", consequence: "Good attempt but evacuation is priority!", isCorrect: false, explanation: "While CO2 works on electrical fires, evacuation comes first."),
                Choice(id: "4", text: "Turn off main breaker", consequence: "You get shocked! Panel is live!", isCorrect: false, explanation: "Don't touch malfunctioning electrical equipment.")
            ],
            correctChoiceId: "2",
            educationalContext: "Smoking electrical panels indicate serious faults. Evacuate and call professionals.",
            urgencyLevel: .critical,
            responseSteps: [
                ResponseStep(stepNumber: 1, instruction: "Evacuate immediate area", icon: "figure.run"),
                ResponseStep(stepNumber: 2, instruction: "Alert facility manager", icon: "phone.fill"),
                ResponseStep(stepNumber: 3, instruction: "Call emergency electrician", icon: "wrench.fill"),
                ResponseStep(stepNumber: 4, instruction: "Post warning signs", icon: "exclamationmark.triangle.fill"),
                ResponseStep(stepNumber: 5, instruction: "Document incident", icon: "doc.text.fill")
            ]
        ),
        Scenario(
            title: "Gas Cylinder Valve Leak",
            description: "A compressed gas cylinder is hissing loudly. The valve appears damaged.",
            environment: .warehouse,
            hazardType: .gas,
            imageIcon: "wind",
            interactionType: .multipleChoice,
            choices: [
                Choice(id: "1", text: "Try to tighten the valve", consequence: "Valve breaks completely! Massive leak!", isCorrect: false, explanation: "Damaged valves should not be manipulated."),
                Choice(id: "2", text: "Move cylinder outside to open area", consequence: "Excellent! Isolate hazard from people.", isCorrect: true, explanation: "Moving leaking cylinders to open air prevents concentration of gas."),
                Choice(id: "3", text: "Cover with wet cloth", consequence: "Ineffective. Gas continues leaking.", isCorrect: false, explanation: "Wet cloths don't stop gas leaks."),
                Choice(id: "4", text: "Spray water on it", consequence: "No effect on leak. Time wasted.", isCorrect: false, explanation: "Water doesn't seal gas leaks.")
            ],
            correctChoiceId: "2",
            educationalContext: "Leaking gas cylinders should be moved to open air if safe to do so, then isolated.",
            urgencyLevel: .high,
            responseSteps: [
                ResponseStep(stepNumber: 1, instruction: "Assess if safe to approach", icon: "eye.fill"),
                ResponseStep(stepNumber: 2, instruction: "Wear appropriate PPE", icon: "shield.fill"),
                ResponseStep(stepNumber: 3, instruction: "Carefully move to open area", icon: "arrow.right.circle.fill"),
                ResponseStep(stepNumber: 4, instruction: "Keep people away", icon: "hand.raised.fill"),
                ResponseStep(stepNumber: 5, instruction: "Contact gas supplier", icon: "phone.fill")
            ]
        ),
        Scenario(
            title: "Pallet Rack Collapse with Fire",
            description: "A pallet rack has collapsed, and cardboard boxes are now on fire creating heavy smoke.",
            environment: .warehouse,
            hazardType: .heavySmoke,
            imageIcon: "smoke.fill",
            interactionType: .multipleChoice,
            choices: [
                Choice(id: "1", text: "Try to save inventory", consequence: "You're overcome by smoke! Rescued by firefighters.", isCorrect: false, explanation: "Life safety comes before property."),
                Choice(id: "2", text: "Activate alarm and evacuate", consequence: "Perfect! Everyone safe, fire contained.", isCorrect: true, explanation: "Immediate evacuation is critical in heavy smoke conditions."),
                Choice(id: "3", text: "Fight fire with extinguisher", consequence: "Smoke inhalation! You collapse.", isCorrect: false, explanation: "Heavy smoke requires professional firefighting equipment."),
                Choice(id: "4", text: "Close doors to contain it", consequence: "Good instinct but evacuate first!", isCorrect: false, explanation: "Personal safety and evacuation must precede containment.")
            ],
            correctChoiceId: "2",
            educationalContext: "Heavy smoke is deadly. Immediate evacuation and fire alarm activation are priorities.",
            urgencyLevel: .critical,
            responseSteps: [
                ResponseStep(stepNumber: 1, instruction: "Pull fire alarm immediately", icon: "bell.fill"),
                ResponseStep(stepNumber: 2, instruction: "Shout evacuation warning", icon: "speaker.wave.3.fill"),
                ResponseStep(stepNumber: 3, instruction: "Exit via nearest safe route", icon: "arrow.right.to.line"),
                ResponseStep(stepNumber: 4, instruction: "Stay low under smoke", icon: "arrow.down"),
                ResponseStep(stepNumber: 5, instruction: "Call 911 from outside", icon: "phone.fill")
            ]
        )
    ]
    
    // MARK: - Office Scenarios
    static let officeScenarios: [Scenario] = [
        Scenario(
            title: "Computer Monitor Fire",
            description: "A desktop monitor is sparking and starting to catch fire. Multiple computers are nearby.",
            environment: .office,
            hazardType: .electrical,
            imageIcon: "bolt.fill",
            interactionType: .multipleChoice,
            choices: [
                Choice(id: "1", text: "Unplug the monitor", consequence: "Electric shock! You're injured.", isCorrect: false, explanation: "Don't touch electrical devices that are sparking."),
                Choice(id: "2", text: "Use CO2 extinguisher", consequence: "Correct! Safe for electrical fires.", isCorrect: true, explanation: "CO2 extinguishers are safe for electrical equipment."),
                Choice(id: "3", text: "Throw coffee on it", consequence: "Liquid conducts electricity! You're shocked!", isCorrect: false, explanation: "Never use liquids on electrical fires."),
                Choice(id: "4", text: "Cover with jacket", consequence: "Jacket catches fire! Burns your hands.", isCorrect: false, explanation: "Fabric is flammable and ineffective.")
            ],
            correctChoiceId: "2",
            educationalContext: "Electrical fires require Class C extinguishers like CO2 or dry chemical.",
            urgencyLevel: .high,
            responseSteps: [
                ResponseStep(stepNumber: 1, instruction: "Alert nearby colleagues", icon: "person.2.fill"),
                ResponseStep(stepNumber: 2, instruction: "Grab CO2 extinguisher", icon: "wind"),
                ResponseStep(stepNumber: 3, instruction: "Aim at base of fire", icon: "scope"),
                ResponseStep(stepNumber: 4, instruction: "Sweep continuously", icon: "arrow.left.and.right"),
                ResponseStep(stepNumber: 5, instruction: "Evacuate if fire spreads", icon: "figure.run")
            ]
        ),
        Scenario(
            title: "Overheated Printer Smoking",
            description: "The office printer is emitting heavy smoke and a burning plastic smell.",
            environment: .office,
            hazardType: .heavySmoke,
            imageIcon: "smoke.fill",
            interactionType: .multipleChoice,
            choices: [
                Choice(id: "1", text: "Turn off at power strip", consequence: "Good! Power cut. Now evacuate area.", isCorrect: true, explanation: "Cutting power prevents escalation, then ensure safety."),
                Choice(id: "2", text: "Open printer to check inside", consequence: "Smoke inhalation! Flames burst out!", isCorrect: false, explanation: "Opening smoking equipment provides oxygen to fire."),
                Choice(id: "3", text: "Keep printing, it's important", consequence: "Printer catches fire. Office evacuated.", isCorrect: false, explanation: "Never ignore smoke or burning smells."),
                Choice(id: "4", text: "Spray air freshener", consequence: "Aerosol ignites! Flames spread!", isCorrect: false, explanation: "Aerosols are flammable and dangerous near heat.")
            ],
            correctChoiceId: "1",
            educationalContext: "Smoking electronics should be powered off immediately, then assessed for fire risk.",
            urgencyLevel: .medium,
            responseSteps: [
                ResponseStep(stepNumber: 1, instruction: "Turn off power at source", icon: "power"),
                ResponseStep(stepNumber: 2, instruction: "Move people away", icon: "figure.walk"),
                ResponseStep(stepNumber: 3, instruction: "Monitor for flames", icon: "eye.fill"),
                ResponseStep(stepNumber: 4, instruction: "Have extinguisher ready", icon: "wind"),
                ResponseStep(stepNumber: 5, instruction: "Call IT/facilities", icon: "phone.fill")
            ]
        ),
        Scenario(
            title: "Coffee Machine Electrical Spark",
            description: "The break room coffee machine is sparking. Someone is reaching for it.",
            environment: .office,
            hazardType: .electrical,
            imageIcon: "bolt.fill",
            interactionType: .multipleChoice,
            choices: [
                Choice(id: "1", text: "Shout warning and pull them back", consequence: "Excellent! You prevent a shock injury.", isCorrect: true, explanation: "Preventing others from touching electrical hazards saves lives."),
                Choice(id: "2", text: "Let them handle it", consequence: "They get shocked and injured!", isCorrect: false, explanation: "Always warn others of immediate dangers."),
                Choice(id: "3", text: "Pour water on machine", consequence: "Water conducts electricity! Multiple shocks!", isCorrect: false, explanation: "Water and electricity are a deadly combination."),
                Choice(id: "4", text: "Unplug it yourself", consequence: "You get shocked touching the plug!", isCorrect: false, explanation: "Use circuit breaker, not the plug during electrical emergencies.")
            ],
            correctChoiceId: "1",
            educationalContext: "Immediate warnings to prevent others from touching electrical hazards are critical.",
            urgencyLevel: .high,
            responseSteps: [
                ResponseStep(stepNumber: 1, instruction: "Warn others loudly", icon: "speaker.wave.3.fill"),
                ResponseStep(stepNumber: 2, instruction: "Keep everyone away", icon: "hand.raised.fill"),
                ResponseStep(stepNumber: 3, instruction: "Find circuit breaker", icon: "square.grid.2x2"),
                ResponseStep(stepNumber: 4, instruction: "Cut power to outlet", icon: "power"),
                ResponseStep(stepNumber: 5, instruction: "Report to building manager", icon: "person.fill")
            ]
        )
    ]
    
    // MARK: - Kitchen Scenarios
    static let kitchenScenarios: [Scenario] = [
        Scenario(
            title: "Grease Fire on Stove",
            description: "Cooking oil in a pan has ignited. Flames are shooting up toward the exhaust hood.",
            environment: .kitchen,
            hazardType: .flammableLiquid,
            imageIcon: "flame.fill",
            interactionType: .multipleChoice,
            choices: [
                Choice(id: "1", text: "Pour water on it", consequence: "Explosion! Burning oil splatters everywhere!", isCorrect: false, explanation: "Water causes grease fires to explode and spread."),
                Choice(id: "2", text: "Cover with metal lid and turn off heat", consequence: "Perfect! Fire smothered safely.", isCorrect: true, explanation: "Cutting oxygen and heat source extinguishes grease fires."),
                Choice(id: "3", text: "Carry pan outside", consequence: "You're burned severely! Oil spills on floor!", isCorrect: false, explanation: "Never move burning pans."),
                Choice(id: "4", text: "Use fire extinguisher", consequence: "Works but lid method is better for small fires!", isCorrect: false, explanation: "Class K extinguishers work but lids are first choice for small grease fires.")
            ],
            correctChoiceId: "2",
            educationalContext: "Grease fires are smothered by cutting oxygen (lid) and heat (turn off burner). Never use water!",
            urgencyLevel: .critical,
            responseSteps: [
                ResponseStep(stepNumber: 1, instruction: "Turn off burner immediately", icon: "power"),
                ResponseStep(stepNumber: 2, instruction: "Cover with metal lid", icon: "circle.fill"),
                ResponseStep(stepNumber: 3, instruction: "Do not remove lid for 30 min", icon: "clock.fill"),
                ResponseStep(stepNumber: 4, instruction: "If fire spreads, evacuate", icon: "figure.run"),
                ResponseStep(stepNumber: 5, instruction: "Use Class K extinguisher if needed", icon: "wind")
            ]
        ),
        Scenario(
            title: "Oven Fire with Heavy Smoke",
            description: "The oven is on fire. Heavy smoke is pouring out when you open the door.",
            environment: .kitchen,
            hazardType: .heavySmoke,
            imageIcon: "smoke.fill",
            interactionType: .multipleChoice,
            choices: [
                Choice(id: "1", text: "Keep door closed and turn off oven", consequence: "Excellent! Fire starved of oxygen.", isCorrect: true, explanation: "Closing oven door contains fire and limits oxygen."),
                Choice(id: "2", text: "Open door to fight fire", consequence: "Fire flares up with fresh oxygen!", isCorrect: false, explanation: "Opening doors gives fire more oxygen."),
                Choice(id: "3", text: "Spray water inside", consequence: "Steam explosion! You're burned!", isCorrect: false, explanation: "Water in hot ovens creates dangerous steam."),
                Choice(id: "4", text: "Try to remove burning food", consequence: "Severe burns to hands and arms!", isCorrect: false, explanation: "Never reach into a burning oven.")
            ],
            correctChoiceId: "1",
            educationalContext: "Oven fires are contained by keeping door closed and cutting power/gas.",
            urgencyLevel: .high,
            responseSteps: [
                ResponseStep(stepNumber: 1, instruction: "Close oven door immediately", icon: "rectangle.fill"),
                ResponseStep(stepNumber: 2, instruction: "Turn off oven", icon: "power"),
                ResponseStep(stepNumber: 3, instruction: "Monitor through window", icon: "eye.fill"),
                ResponseStep(stepNumber: 4, instruction: "Prepare extinguisher", icon: "wind"),
                ResponseStep(stepNumber: 5, instruction: "Call fire dept if fire grows", icon: "phone.fill")
            ]
        ),
        Scenario(
            title: "Gas Smell from Range",
            description: "You smell strong gas near the cooking range. No flame is visible.",
            environment: .kitchen,
            hazardType: .gas,
            imageIcon: "wind",
            interactionType: .multipleChoice,
            choices: [
                Choice(id: "1", text: "Light a match to find source", consequence: "Massive explosion! Fatal mistake!", isCorrect: false, explanation: "Open flames ignite gas creating explosions."),
                Choice(id: "2", text: "Turn off gas valve and ventilate", consequence: "Perfect! You prevent ignition.", isCorrect: true, explanation: "Stopping gas flow and ventilating prevents dangerous buildup."),
                Choice(id: "3", text: "Turn on exhaust fan", consequence: "Fan motor sparks! Explosion!", isCorrect: false, explanation: "Electrical switches can create sparks."),
                Choice(id: "4", text: "Keep cooking, it's normal", consequence: "Gas accumulates. Later explosion!", isCorrect: false, explanation: "Gas smells always indicate dangerous leaks.")
            ],
            correctChoiceId: "2",
            educationalContext: "Gas leaks require shutting off gas valve, manual ventilation, and evacuation.",
            urgencyLevel: .critical,
            responseSteps: [
                ResponseStep(stepNumber: 1, instruction: "Do not use electrical switches", icon: "bolt.slash"),
                ResponseStep(stepNumber: 2, instruction: "Turn off gas valve", icon: "valve.closed"),
                ResponseStep(stepNumber: 3, instruction: "Open windows manually", icon: "rectangle.portrait.and.arrow.right"),
                ResponseStep(stepNumber: 4, instruction: "Evacuate building", icon: "figure.walk"),
                ResponseStep(stepNumber: 5, instruction: "Call gas company from outside", icon: "phone.fill")
            ]
        )
    ]
    
    // MARK: - Server Room Scenarios
    static let serverRoomScenarios: [Scenario] = [
        Scenario(
            title: "Server Rack Fire",
            description: "A server rack is smoking heavily. Equipment is still running.",
            environment: .serverRoom,
            hazardType: .electrical,
            imageIcon: "bolt.fill",
            interactionType: .multipleChoice,
            choices: [
                Choice(id: "1", text: "Hit emergency power off (EPO)", consequence: "Perfect! Power cut safely, fire contained.", isCorrect: true, explanation: "EPO buttons cut all power to prevent electrical fires from spreading."),
                Choice(id: "2", text: "Unplug individual servers", consequence: "Shocked by electrical current!", isCorrect: false, explanation: "Don't touch equipment during electrical emergencies."),
                Choice(id: "3", text: "Use water sprinkler", consequence: "Massive electrical damage! Multiple shocks!", isCorrect: false, explanation: "Water and electronics create deadly hazards."),
                Choice(id: "4", text: "Continue working", consequence: "Fire spreads! Data center destroyed!", isCorrect: false, explanation: "Smoking equipment indicates imminent fire.")
            ],
            correctChoiceId: "1",
            educationalContext: "Server rooms have Emergency Power Off systems to cut all power during electrical emergencies.",
            urgencyLevel: .critical,
            responseSteps: [
                ResponseStep(stepNumber: 1, instruction: "Activate EPO button", icon: "power"),
                ResponseStep(stepNumber: 2, instruction: "Sound fire alarm", icon: "bell.fill"),
                ResponseStep(stepNumber: 3, instruction: "Use CO2 extinguisher", icon: "wind"),
                ResponseStep(stepNumber: 4, instruction: "Evacuate server room", icon: "figure.run"),
                ResponseStep(stepNumber: 5, instruction: "Call IT emergency team", icon: "phone.fill")
            ]
        ),
        Scenario(
            title: "Cooling System Failure - Overheating",
            description: "The AC has failed. Temperature is 45°C and rising. Servers are shutting down.",
            environment: .serverRoom,
            hazardType: .electrical,
            imageIcon: "thermometer.sun.fill",
            interactionType: .multipleChoice,
            choices: [
                Choice(id: "1", text: "Orderly shutdown critical systems", consequence: "Good! You prevent heat damage.", isCorrect: true, explanation: "Controlled shutdown prevents thermal damage to equipment."),
                Choice(id: "2", text: "Open doors for cooling", consequence: "Compromised security! Helps temporarily.", isCorrect: false, explanation: "While it cools, it violates security protocols."),
                Choice(id: "3", text: "Pour water on servers", consequence: "Electrical destruction! Complete failure!", isCorrect: false, explanation: "Water destroys electronics."),
                Choice(id: "4", text: "Let systems run", consequence: "Thermal shutdown! Hardware damaged!", isCorrect: false, explanation: "Overheating causes permanent damage.")
            ],
            correctChoiceId: "1",
            educationalContext: "Server overheating requires orderly shutdown to prevent thermal damage while cooling is restored.",
            urgencyLevel: .high,
            responseSteps: [
                ResponseStep(stepNumber: 1, instruction: "Alert IT management", icon: "phone.fill"),
                ResponseStep(stepNumber: 2, instruction: "Begin controlled shutdown", icon: "power"),
                ResponseStep(stepNumber: 3, instruction: "Prioritize critical systems", icon: "star.fill"),
                ResponseStep(stepNumber: 4, instruction: "Document temperatures", icon: "doc.text.fill"),
                ResponseStep(stepNumber: 5, instruction: "Call HVAC emergency service", icon: "wrench.fill")
            ]
        ),
        Scenario(
            title: "Battery Backup Smoking",
            description: "The UPS battery backup is smoking and beeping. Acrid smell fills room.",
            environment: .serverRoom,
            hazardType: .electrical,
            imageIcon: "bolt.fill",
            interactionType: .multipleChoice,
            choices: [
                Choice(id: "1", text: "Evacuate and call fire dept", consequence: "Excellent! Battery fires are dangerous.", isCorrect: true, explanation: "UPS batteries can explode and release toxic gases."),
                Choice(id: "2", text: "Disconnect battery yourself", consequence: "Battery explodes! Acid burns you!", isCorrect: false, explanation: "Smoking batteries can explode when disturbed."),
                Choice(id: "3", text: "Ignore the beeping", consequence: "Battery explodes! Fire spreads!", isCorrect: false, explanation: "UPS alarms indicate critical failures."),
                Choice(id: "4", text: "Use water extinguisher", consequence: "Electrical shock and chemical reaction!", isCorrect: false, explanation: "Water reacts badly with battery chemistry.")
            ],
            correctChoiceId: "1",
            educationalContext: "Smoking UPS batteries are extreme hazards requiring immediate evacuation and professional response.",
            urgencyLevel: .critical,
            responseSteps: [
                ResponseStep(stepNumber: 1, instruction: "Evacuate server room", icon: "figure.run"),
                ResponseStep(stepNumber: 2, instruction: "Pull fire alarm", icon: "bell.fill"),
                ResponseStep(stepNumber: 3, instruction: "Call fire department", icon: "phone.fill"),
                ResponseStep(stepNumber: 4, instruction: "Notify IT security", icon: "lock.shield.fill"),
                ResponseStep(stepNumber: 5, instruction: "Activate building evacuation", icon: "building.fill")
            ]
        )
    ]
    
    // MARK: - Factory Scenarios
    static let factoryScenarios: [Scenario] = [
        Scenario(
            title: "Hydraulic Oil Fire",
            description: "A hydraulic line has burst, spraying oil that ignited on hot machinery.",
            environment: .factory,
            hazardType: .flammableLiquid,
            imageIcon: "flame.fill",
            interactionType: .multipleChoice,
            choices: [
                Choice(id: "1", text: "Hit emergency stop and use foam extinguisher", consequence: "Perfect! Machine stopped, fire suppressed.", isCorrect: true, explanation: "Emergency stops prevent machinery from feeding fire, foam handles oil."),
                Choice(id: "2", text: "Use water hose", consequence: "Fire spreads! Oil floats on water!", isCorrect: false, explanation: "Water doesn't extinguish oil fires."),
                Choice(id: "3", text: "Try to fix the leak", consequence: "You're sprayed with burning oil! Severe burns!", isCorrect: false, explanation: "Never approach active hydraulic leaks during fires."),
                Choice(id: "4", text: "Run away without warning", consequence: "Fire spreads to other machines! Factory evacuated!", isCorrect: false, explanation: "Emergency stops and warnings save facilities.")
            ],
            correctChoiceId: "1",
            educationalContext: "Machinery fires require emergency stops first, then appropriate fire suppression.",
            urgencyLevel: .critical,
            responseSteps: [
                ResponseStep(stepNumber: 1, instruction: "Hit emergency stop button", icon: "stop.fill"),
                ResponseStep(stepNumber: 2, instruction: "Sound evacuation alarm", icon: "bell.fill"),
                ResponseStep(stepNumber: 3, instruction: "Use Class B foam extinguisher", icon: "wind.snow"),
                ResponseStep(stepNumber: 4, instruction: "Attack from upwind", icon: "arrow.up"),
                ResponseStep(stepNumber: 5, instruction: "Evacuate if uncontrollable", icon: "figure.run")
            ]
        ),
        Scenario(
            title: "Electrical Panel Arc Flash",
            description: "The main control panel had an arc flash. Sparks and smoke continue.",
            environment: .factory,
            hazardType: .electrical,
            imageIcon: "bolt.fill",
            interactionType: .multipleChoice,
            choices: [
                Choice(id: "1", text: "De-energize at main disconnect", consequence: "Correct! Power cut safely from distance.", isCorrect: true, explanation: "Main disconnects allow safe power cutoff during electrical emergencies."),
                Choice(id: "2", text: "Open panel to assess damage", consequence: "Second arc flash! Critical injuries!", isCorrect: false, explanation: "Never open panels after arc flash."),
                Choice(id: "3", text: "Continue production", consequence: "Full electrical fire! Factory shut down!", isCorrect: false, explanation: "Arc flash indicates dangerous faults."),
                Choice(id: "4", text: "Spray with CO2 extinguisher", consequence: "Helps, but power should be cut first!", isCorrect: false, explanation: "De-energize before fire suppression.")
            ],
            correctChoiceId: "1",
            educationalContext: "Arc flash incidents require immediate de-energization from main disconnect points.",
            urgencyLevel: .critical,
            responseSteps: [
                ResponseStep(stepNumber: 1, instruction: "Do not approach panel", icon: "hand.raised.fill"),
                ResponseStep(stepNumber: 2, instruction: "Locate main disconnect", icon: "power"),
                ResponseStep(stepNumber: 3, instruction: "De-energize system", icon: "bolt.slash"),
                ResponseStep(stepNumber: 4, instruction: "Call qualified electrician", icon: "phone.fill"),
                ResponseStep(stepNumber: 5, instruction: "Document incident", icon: "doc.text.fill")
            ]
        ),
        Scenario(
            title: "Chemical Dust Cloud Ignition",
            description: "Metal dust has formed a cloud and ignited near grinding operation.",
            environment: .factory,
            hazardType: .heavySmoke,
            imageIcon: "smoke.fill",
            interactionType: .multipleChoice,
            choices: [
                Choice(id: "1", text: "Evacuate immediately and sound alarm", consequence: "Perfect! Dust explosions are deadly.", isCorrect: true, explanation: "Dust cloud fires can cause secondary explosions."),
                Choice(id: "2", text: "Use compressed air to blow it away", consequence: "Massive explosion! Multiple casualties!", isCorrect: false, explanation: "Air disperses dust creating explosive conditions."),
                Choice(id: "3", text: "Use water sprinkler", consequence: "Metal dust reacts! Hydrogen explosion!", isCorrect: false, explanation: "Some metal dusts react violently with water."),
                Choice(id: "4", text: "Try to smother with blanket", consequence: "Blanket ignites! You're burned!", isCorrect: false, explanation: "Dust cloud fires require evacuation.")
            ],
            correctChoiceId: "1",
            educationalContext: "Combustible dust fires require immediate evacuation due to explosion risk.",
            urgencyLevel: .critical,
            responseSteps: [
                ResponseStep(stepNumber: 1, instruction: "Pull fire alarm immediately", icon: "bell.fill"),
                ResponseStep(stepNumber: 2, instruction: "Shout evacuation warning", icon: "speaker.wave.3.fill"),
                ResponseStep(stepNumber: 3, instruction: "Exit via emergency routes", icon: "arrow.right.to.line"),
                ResponseStep(stepNumber: 4, instruction: "Account for all personnel", icon: "person.3.fill"),
                ResponseStep(stepNumber: 5, instruction: "Call fire department", icon: "phone.fill")
            ]
        )
    ]
}
