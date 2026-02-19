import SwiftUI

struct Badge: Identifiable, Codable {
    let id: String
    let name: String
    let description: String
    let icon: String
    let color: String
    var isUnlocked: Bool
    var unlockedDate: Date?
    
    static let allBadges: [Badge] = [
        Badge(
            id: "first_training",
            name: "First Steps",
            description: "Complete your first training scenario",
            icon: "figure.walk",
            color: "blue",
            isUnlocked: false
        ),
        Badge(
            id: "perfect_score",
            name: "Perfect Response",
            description: "Get 100% accuracy in a training session",
            icon: "star.fill",
            color: "yellow",
            isUnlocked: false
        ),
        Badge(
            id: "speed_demon",
            name: "Quick Thinker",
            description: "Complete a scenario in under 30 seconds",
            icon: "bolt.fill",
            color: "orange",
            isUnlocked: false
        ),
        Badge(
            id: "factory_expert",
            name: "Factory Safety Expert",
            description: "Complete all factory scenarios",
            icon: "gearshape.2.fill",
            color: "red",
            isUnlocked: false
        ),
        Badge(
            id: "fire_master",
            name: "Fire Type Master",
            description: "Learn about all fire types",
            icon: "flame.fill",
            color: "red",
            isUnlocked: false
        ),
        Badge(
            id: "extinguisher_pro",
            name: "Extinguisher Pro",
            description: "Complete the extinguisher guide",
            icon: "extinguisher.fill",
            color: "green",
            isUnlocked: false
        ),
        Badge(
            id: "week_streak",
            name: "Dedicated Learner",
            description: "Practice for 7 days in a row",
            icon: "calendar",
            color: "purple",
            isUnlocked: false
        ),
        Badge(
            id: "all_environments",
            name: "Environment Master",
            description: "Complete scenarios in all environments",
            icon: "checkmark.seal.fill",
            color: "green",
            isUnlocked: false
        )
    ]
    
    var colorValue: Color {
        switch color {
        case "blue": return .blue
        case "yellow": return .yellow
        case "orange": return .orange
        case "red": return .red
        case "green": return .green
        case "purple": return .purple
        default: return .gray
        }
    }
}

class BadgeManager: ObservableObject {
    @Published var badges: [Badge]
    
    private let badgesKey = "unlockedBadges"
    
    init() {
        // Load saved badges from UserDefaults
        if let data = UserDefaults.standard.data(forKey: badgesKey),
           let savedBadges = try? JSONDecoder().decode([Badge].self, from: data) {
            self.badges = savedBadges
        } else {
            self.badges = Badge.allBadges
        }
    }
    
    func unlockBadge(id: String) {
        guard let index = badges.firstIndex(where: { $0.id == id }) else { return }
        guard !badges[index].isUnlocked else { return }
        
        badges[index].isUnlocked = true
        badges[index].unlockedDate = Date()
        saveBadges()
    }
    
    func checkAndUnlockBadges(gameState: GameState) {
        // First training
        if gameState.totalDecisions > 0 {
            unlockBadge(id: "first_training")
        }
        
        // Perfect score
        if gameState.accuracyPercentage == 100 && gameState.totalDecisions > 0 {
            unlockBadge(id: "perfect_score")
        }
        
        // Factory expert
        if gameState.selectedEnvironment == .factory && 
           gameState.currentScenarioIndex >= gameState.scenarios.count - 1 {
            unlockBadge(id: "factory_expert")
        }
    }
    
    private func saveBadges() {
        if let data = try? JSONEncoder().encode(badges) {
            UserDefaults.standard.set(data, forKey: badgesKey)
        }
    }
    
    var unlockedCount: Int {
        badges.filter { $0.isUnlocked }.count
    }
}
