import SwiftUI

struct Badge: Identifiable {
    let id = UUID()
    let name: String
    let icon: String
    let color: Color
    let description: String
    let requirement: BadgeRequirement
}

enum BadgeRequirement {
    case completeScenarios(count: Int)
    case achieveAccuracy(percentage: Int)
    case completeEnvironment(type: EnvironmentType)
    case perfectScore
    case speedDemon(seconds: Int)
    case evacuationMaps(count: Int)
    case rescuePeople(count: Int)
    case evacuateTime(maxSeconds: Int)
    case sRankCount(count: Int)
}

// Badge Manager
@MainActor
class BadgeManager: ObservableObject {
    @Published var earnedBadges: Set<String> = [] {
        didSet {
            saveToUserDefaults()
        }
    }
    
    private let userDefaultsKey = "earnedBadges"
    
    init() {
        loadFromUserDefaults()
    }
    
    private func loadFromUserDefaults() {
        if let data = UserDefaults.standard.array(forKey: userDefaultsKey) as? [String] {
            earnedBadges = Set(data)
        }
    }
    
    private func saveToUserDefaults() {
        UserDefaults.standard.set(Array(earnedBadges), forKey: userDefaultsKey)
    }
    
    static let allBadges = [
        Badge(
            name: "First Steps",
            icon: "figure.walk",
            color: .blue,
            description: "Complete your first scenario",
            requirement: .completeScenarios(count: 1)
        ),
        Badge(
            name: "Quick Thinker",
            icon: "bolt.fill",
            color: .yellow,
            description: "Complete a scenario in under 30 seconds",
            requirement: .speedDemon(seconds: 30)
        ),
        Badge(
            name: "Perfect Response",
            icon: "star.fill",
            color: .yellow,
            description: "Achieve 100% accuracy",
            requirement: .achieveAccuracy(percentage: 100)
        ),
        Badge(
            name: "Lab Expert",
            icon: "flask.fill",
            color: .purple,
            description: "Complete all laboratory scenarios",
            requirement: .completeEnvironment(type: .lab)
        ),
        Badge(
            name: "Office Hero",
            icon: "building.2.fill",
            color: .green,
            description: "Complete all office scenarios",
            requirement: .completeEnvironment(type: .office)
        ),
        Badge(
            name: "Kitchen Master",
            icon: "fork.knife",
            color: .red,
            description: "Complete all kitchen scenarios",
            requirement: .completeEnvironment(type: .kitchen)
        ),
        Badge(
            name: "Factory Guardian",
            icon: "gearshape.2.fill",
            color: .orange,
            description: "Complete all factory scenarios",
            requirement: .completeEnvironment(type: .factory)
        ),
        Badge(
            name: "Safety Champion",
            icon: "trophy.fill",
            color: .yellow,
            description: "Earn all other badges",
            requirement: .completeScenarios(count: 20)
        ),
        Badge(
            name: "Evacuation Expert",
            icon: "map.fill",
            color: .purple,
            description: "Complete 10 evacuation maps",
            requirement: .evacuationMaps(count: 10)
        ),
        Badge(
            name: "Life Saver",
            icon: "person.2.fill",
            color: .green,
            description: "Rescue 50 people total",
            requirement: .rescuePeople(count: 50)
        ),
        Badge(
            name: "Speed Evacuator",
            icon: "timer",
            color: .orange,
            description: "Evacuate in under 30 seconds",
            requirement: .evacuateTime(maxSeconds: 30)
        ),
        Badge(
            name: "Perfect Route Master",
            icon: "arrow.triangle.branch",
            color: .blue,
            description: "Get S-rank 5 times",
            requirement: .sRankCount(count: 5)
        )
    ]
    
    func checkAndAwardBadges(gameState: GameState) {
        for badge in BadgeManager.allBadges {
            if !earnedBadges.contains(badge.name) && isBadgeEarned(badge, gameState: gameState) {
                earnedBadges.insert(badge.name)
                gameState.badgesEarnedThisSession.insert(badge.name)  // Track new badge
            }
        }
    }
    
    private func isBadgeEarned(_ badge: Badge, gameState: GameState) -> Bool {
        switch badge.requirement {
        case .completeScenarios(let count):
            return gameState.totalDecisions >= count
            
        case .achieveAccuracy(let percentage):
            return gameState.accuracyPercentage >= percentage
            
        case .completeEnvironment(let type):
            return gameState.selectedEnvironment == type &&
                   gameState.currentScenarioIndex >= gameState.scenarios.count - 1
            
        case .perfectScore:
            return gameState.accuracyPercentage == 100 && gameState.totalDecisions > 0
            
        case .speedDemon:  // ✅ Removed unused 'seconds' parameter
            // This would need additional tracking in GameState
            return false
        case .evacuationMaps(let count):
            return gameState.evacuationMapsCompleted >= count
        case .rescuePeople(let count):
            return gameState.totalPeopleRescued >= count
        case .evacuateTime:
            return gameState.fastEvacuations >= 1
        case .sRankCount(let count):
            return gameState.sRankEvacuations >= count
        }
    }
}

// Badge Display View
struct BadgeView: View {
    let badge: Badge
    let isEarned: Bool
    
    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                Circle()
                    .fill(isEarned ? badge.color.gradient : Color.gray.opacity(0.3).gradient)  // ✅ Fixed: both sides are now gradients
                    .frame(width: 80, height: 80)
                
                Image(systemName: badge.icon)
                    .font(.system(size: 40))
                    .foregroundStyle(isEarned ? .white : .gray)
            }
            
            Text(badge.name)
                .font(.caption.bold())
                .multilineTextAlignment(.center)
            
            Text(badge.description)
                .font(.caption2)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .frame(height: 30)
        }
        .frame(width: 100)
        .opacity(isEarned ? 1.0 : 0.5)
    }
}

// Badges Collection View
struct BadgesCollectionView: View {
    @ObservedObject var gameState: GameState
    @StateObject private var badgeManager = BadgeManager()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.adaptive(minimum: 100))
                ], spacing: 20) {
                    ForEach(BadgeManager.allBadges) { badge in
                        BadgeView(
                            badge: badge,
                            isEarned: badgeManager.earnedBadges.contains(badge.name)
                        )
                    }
                }
                .padding()
            }
            .navigationTitle("Badges")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                badgeManager.checkAndAwardBadges(gameState: gameState)
            }
        }
    }
}

#Preview {
    BadgesCollectionView(gameState: GameState())
}
