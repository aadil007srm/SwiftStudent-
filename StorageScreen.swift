import SwiftUI

struct StorageScreen: View {
    @ObservedObject var gameState: GameState
    
    let emergencyRed = Color(red: 1.0, green: 0.3, blue: 0.2)
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Header
                    VStack(spacing: 16) {
                        ZStack {
                            Circle()
                                .fill(Color.blue.opacity(0.15))
                                .frame(width: 80, height: 80)
                            
                            Image(systemName: "chart.line.uptrend.xyaxis.circle.fill")
                                .font(.system(size: 40))
                                .foregroundColor(.blue)
                        }
                        
                        Text("Training History")
                            .font(.title2.bold())
                            .foregroundColor(.primary)
                        
                        Text("Your emergency response progress")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    .background(Color(UIColor.secondarySystemGroupedBackground))
                    .cornerRadius(16)
                    .padding(.horizontal)
                    .padding(.top, 20)
                    
                    // Overview Stats
                    VStack(spacing: 12) {
                        Text("OVERVIEW")
                            .font(.caption.weight(.bold))
                            .foregroundColor(.secondary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        VStack(spacing: 10) {
                            StatRow(label: "Scenarios Completed", value: "\(gameState.completedScenarios.count)")
                            Divider()
                            StatRow(label: "Total Decisions", value: "\(gameState.totalDecisions)")
                            Divider()
                            StatRow(label: "Correct Responses", value: "\(gameState.correctDecisions)")
                            Divider()
                            StatRow(label: "Overall Accuracy", value: "\(Int(gameState.accuracyPercentage))%")
                            Divider()
                            StatRow(label: "Total Score", value: "\(gameState.score)")
                        }
                    }
                    .padding()
                    .background(Color(UIColor.secondarySystemGroupedBackground))
                    .cornerRadius(16)
                    .padding(.horizontal)
                    
                    // Completed Scenarios
                    if !gameState.completedScenarios.isEmpty {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("COMPLETED SCENARIOS")
                                .font(.caption.weight(.bold))
                                .foregroundColor(.secondary)
                            
                            ForEach(gameState.completedScenarios, id: \.self) { scenario in
                                HStack(spacing: 12) {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.green)
                                        .font(.title3)
                                    
                                    Text(scenario)
                                        .font(.body)
                                        .foregroundColor(.primary)
                                    
                                    Spacer()
                                }
                                .padding()
                                .background(Color.green.opacity(0.1))
                                .cornerRadius(12)
                            }
                        }
                        .padding()
                        .background(Color(UIColor.secondarySystemGroupedBackground))
                        .cornerRadius(16)
                        .padding(.horizontal)
                    }
                    
                    // Back Button
                    Button(action: {
                        HapticManager.shared.lightImpact()
                        withAnimation {
                            gameState.currentScreen = .home
                        }
                    }) {
                        HStack {
                            Image(systemName: "house.circle.fill")
                            Text("Back to Home")
                        }
                        .font(.headline)
                        .foregroundColor(.blue)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(16)
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom, 30)
            }
            .navigationTitle("History")
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationViewStyle(.stack)
    }
}

struct StatRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(label)
                .font(.body)
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
                .font(.body.weight(.semibold))
                .foregroundColor(.primary)
        }
    }
}
