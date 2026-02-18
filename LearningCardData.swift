import SwiftUI

struct LearningCardContent {
    let title: String
    let description: String
    let icon: String
    let color: Color
    let keyPoints: [String]
    let example: String?
}

struct LearningCardData {
    static let allCards: [LearningCardContent] = [
        LearningCardContent(
            title: "Fire Extinguisher Types",
            description: "Different fires require different extinguishers. Using the wrong type can make fires worse.",
            icon: "flame.fill",
            color: .red,
            keyPoints: [
                "Class A: Wood, paper, cloth (water or foam)",
                "Class B: Flammable liquids (foam or CO2)",
                "Class C: Electrical (CO2 or dry chemical)",
                "Class D: Metals (specialized dry powder)",
                "Class K: Kitchen/cooking oil (wet chemical)"
            ],
            example: "For a computer fire, use Class C (CO2). For cooking oil, use Class K. Never use water on electrical or oil fires!"
        ),
        
        LearningCardContent(
            title: "PASS Technique",
            description: "The standard method for using fire extinguishers effectively.",
            icon: "checkmark.shield.fill",
            color: .orange,
            keyPoints: [
                "P - Pull the pin",
                "A - Aim at the base of the fire",
                "S - Squeeze the handle",
                "S - Sweep side to side"
            ],
            example: "Stand 6-8 feet away, pull the pin, aim low at the base, squeeze and sweep until the fire is out."
        ),
        
        LearningCardContent(
            title: "Electrical Safety",
            description: "Electrical emergencies require special procedures to prevent electrocution.",
            icon: "bolt.fill",
            color: .yellow,
            keyPoints: [
                "Never use water on electrical fires",
                "Turn off power at the breaker first",
                "Use Class C extinguishers only",
                "Don't touch malfunctioning equipment",
                "Evacuate if there's smoke or sparking"
            ],
            example: "If a server is smoking, hit the EPO (Emergency Power Off), evacuate, then use CO2 extinguisher if trained."
        ),
        
        LearningCardContent(
            title: "Gas Leak Response",
            description: "Gas leaks are invisible and can cause explosions. Quick, correct action is critical.",
            icon: "wind",
            color: .green,
            keyPoints: [
                "Do NOT use electrical switches",
                "Do NOT use open flames",
                "Open windows manually for ventilation",
                "Evacuate immediately",
                "Call emergency services from outside"
            ],
            example: "Smell gas? Don't flip light switches - the spark can ignite it. Open windows by hand and leave immediately."
        ),
        
        LearningCardContent(
            title: "Heavy Smoke Procedures",
            description: "Smoke inhalation kills faster than fire. Know how to escape safely.",
            icon: "smoke.fill",
            color: .gray,
            keyPoints: [
                "Stay low - smoke rises",
                "Cover nose and mouth with cloth",
                "Feel doors before opening (heat check)",
                "If escape blocked, seal door cracks",
                "Signal for help from windows"
            ],
            example: "In heavy smoke, crawl on hands and knees. Touch doors with back of hand - if hot, find another route."
        ),
        
        LearningCardContent(
            title: "Chemical Spill Response",
            description: "Chemical spills require immediate containment and proper neutralization.",
            icon: "drop.triangle.fill",
            color: .purple,
            keyPoints: [
                "Alert others immediately",
                "Wear proper PPE (gloves, goggles)",
                "Use spill kits for containment",
                "Never wash chemicals down drains",
                "Consult Safety Data Sheets (SDS)"
            ],
            example: "Acid spill? Put on PPE, use spill kit neutralizer (not water!), contain the spill, then dispose properly."
        ),
        
        LearningCardContent(
            title: "Emergency Evacuation",
            description: "Organized evacuation saves lives. Know your routes and assembly points.",
            icon: "figure.run",
            color: .blue,
            keyPoints: [
                "Know at least two escape routes",
                "Don't use elevators during fires",
                "Help others who need assistance",
                "Never go back inside",
                "Report to assembly point for headcount"
            ],
            example: "Fire alarm sounds? Use stairs (not elevator), help colleagues, exit calmly, meet at designated outdoor location."
        ),
        
        LearningCardContent(
            title: "Grease Fire Safety",
            description: "Grease fires are common in kitchens and extremely dangerous if handled incorrectly.",
            icon: "fork.knife",
            color: .red,
            keyPoints: [
                "NEVER use water - it causes explosions",
                "Turn off heat source immediately",
                "Cover with metal lid to smother",
                "Leave lid on for 30+ minutes",
                "Use Class K extinguisher if available"
            ],
            example: "Pan catches fire? Turn off stove, slide metal lid over pan, leave it covered. Water will cause burning oil to explode!"
        )
    ]
}
