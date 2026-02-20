import SwiftUI

// MARK: - Custom Color Palette for Safe60 App
extension Color {
    // MARK: Primary Colors
    static let safe60Red = Color(red: 0.95, green: 0.24, blue: 0.19)        // #F23D30
    static let safe60Orange = Color(red: 1.0, green: 0.58, blue: 0.0)       // #FF9500
    static let safe60Yellow = Color(red: 1.0, green: 0.8, blue: 0.0)        // #FFCC00
    
    // MARK: Status Colors
    static let safe60Success = Color(red: 0.2, green: 0.78, blue: 0.35)     // #34C759
    static let safe60Warning = Color(red: 1.0, green: 0.58, blue: 0.0)      // #FF9500
    static let safe60Danger = Color(red: 0.95, green: 0.18, blue: 0.18)     // #F22E2E
    static let safe60Info = Color(red: 0.0, green: 0.48, blue: 1.0)         // #007AFF
    
    // MARK: Environment Colors
    static let labPurple = Color(red: 0.69, green: 0.32, blue: 0.87)        // #B051DE
    static let officeBlue = Color(red: 0.2, green: 0.67, blue: 0.86)        // #32ABDC
    static let kitchenRed = Color(red: 0.92, green: 0.26, blue: 0.21)       // #EB4335
    static let factoryOrange = Color(red: 1.0, green: 0.6, blue: 0.2)       // #FF9933
    
    // MARK: UI Colors
    static let cardBackground = Color(white: 0.95)                          // #F2F2F2
    static let cardShadow = Color.black.opacity(0.1)

    // MARK: Evacuation Map Colors
    static let evacuationBackground = Color(red: 0.95, green: 0.95, blue: 0.97)
    static let wallColor = Color.gray.opacity(0.8)
    static let hallwayColor = Color.gray.opacity(0.15)
    static let fireRed = Color(red: 1.0, green: 0.2, blue: 0.0)
    static let smokeGray = Color.gray.opacity(0.5)
    static let exitGreen = Color.green
    static let exitYellow = Color.yellow
    static let exitRed = Color.red
    static let pathBlue = Color.blue.opacity(0.5)
}
