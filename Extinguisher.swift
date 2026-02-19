import SwiftUI

struct ExtinguisherType: Identifiable {
    let id = UUID()
    let name: String
    let icon: String
    let color: Color
    let compatibleFires: [String]
    let incompatibleFires: [String]
}

// Shared extinguisher data
extension ExtinguisherType {
    static let allExtinguishers = [
        ExtinguisherType(
            name: "Water",
            icon: "drop.fill",
            color: .blue,
            compatibleFires: ["Wood/Paper (Class A)"],
            incompatibleFires: ["Electrical", "Chemical"]
        ),
        ExtinguisherType(
            name: "CO2",
            icon: "wind",
            color: .gray,
            compatibleFires: ["Electrical (Class C)"],
            incompatibleFires: ["Wood/Paper", "Metal"]
        ),
        ExtinguisherType(
            name: "Foam",
            icon: "circle.hexagongrid.fill",
            color: .orange,
            compatibleFires: ["Chemical (Class B)"],
            incompatibleFires: ["Electrical"]
        ),
        ExtinguisherType(
            name: "Dry Powder",
            icon: "sparkles",
            color: .yellow,
            compatibleFires: ["Metal/Firecracker (Class D)"],
            incompatibleFires: ["Confined spaces"]
        )
    ]
}
