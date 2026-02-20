import SwiftUI

struct EvacuationResultsView: View {
    @ObservedObject var evacuationGame: EvacuationGameState
    @ObservedObject var gameState: GameState
    @State private var showAnimation = false

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground).ignoresSafeArea()

            ScrollView {
                VStack(spacing: 24) {
                    // Grade display
                    VStack(spacing: 16) {
                        Text(evacuationGame.grade)
                            .font(.system(size: 80, weight: .bold))
                            .foregroundColor(gradeColor)
                            .scaleEffect(showAnimation ? 1.0 : 0.3)
                            .animation(.spring(response: 0.6, dampingFraction: 0.7), value: showAnimation)

                        Text(performanceTitle)
                            .font(.title2.bold())

                        Text("Evacuation Complete!")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .padding()

                    // Stats grid
                    VStack(spacing: 16) {
                        HStack(spacing: 16) {
                            StatCard(
                                icon: "timer",
                                value: "\(evacuationGame.initialTime - evacuationGame.timeRemaining)s",
                                label: "Time Used",
                                color: .blue
                            )
                            StatCard(
                                icon: "person.2.fill",
                                value: "\(evacuationGame.rescuedPeople.count)",
                                label: "Saved",
                                color: .green
                            )
                        }
                        HStack(spacing: 16) {
                            StatCard(
                                icon: "arrow.triangle.branch",
                                value: "\(Int(evacuationGame.routeDistance))m",
                                label: "Distance",
                                color: .orange
                            )
                            StatCard(
                                icon: "shield.fill",
                                value: "\(evacuationGame.routeSafetyScore)%",
                                label: "Safety",
                                color: .purple
                            )
                        }
                    }
                    .padding(.horizontal)

                    // Total score
                    VStack(spacing: 8) {
                        Text("Total Score")
                            .font(.headline)
                        Text("\(evacuationGame.score)")
                            .font(.system(size: 48, weight: .bold))
                            .foregroundColor(.safe60Red)
                    }
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(16)
                    .padding(.horizontal)

                    // Buttons
                    VStack(spacing: 12) {
                        Button {
                            evacuationGame.resetGame()
                        } label: {
                            HStack {
                                Image(systemName: "arrow.clockwise.circle.fill")
                                Text("Try Again")
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.safe60Red)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                        }

                        Button {
                            gameState.currentScreen = .home
                        } label: {
                            HStack {
                                Image(systemName: "house.fill")
                                Text("Home")
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .foregroundColor(.primary)
                            .cornerRadius(12)
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
        }
        .onAppear {
            showAnimation = true
            persistStats()
        }
    }

    // MARK: - Helpers
    private var gradeColor: Color {
        switch evacuationGame.grade {
        case "S", "A": return .green
        case "B", "C": return .orange
        default: return .red
        }
    }

    private var performanceTitle: String {
        switch evacuationGame.grade {
        case "S": return "Perfect Evacuation!"
        case "A": return "Excellent Work!"
        case "B": return "Good Job!"
        case "C": return "Decent Effort!"
        default: return "Keep Practicing!"
        }
    }

    private func persistStats() {
        gameState.evacuationMapsCompleted += 1
        gameState.totalPeopleRescued += evacuationGame.rescuedPeople.count
        if evacuationGame.grade == "S" {
            gameState.sRankEvacuations += 1
        }
        if evacuationGame.timeRemaining >= 30 {
            gameState.fastEvacuations += 1
        }
    }
}

// MARK: - Stat Card
private struct StatCard: View {
    let icon: String
    let value: String
    let label: String
    let color: Color

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
            Text(value)
                .font(.title3.bold())
            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
    }
}

#Preview {
    EvacuationResultsView(evacuationGame: EvacuationGameState(), gameState: GameState())
}
