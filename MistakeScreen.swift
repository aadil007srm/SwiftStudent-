import SwiftUI

struct MistakeScreen: View {
    @ObservedObject var gameState: GameState
    @State private var showExitAlert = false
    
    let emergencyRed = Color(red: 1.0, green: 0.3, blue: 0.2)
    let emergencyOrange = Color(red: 1.0, green: 0.5, blue: 0.0)
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Header
                    VStack(spacing: 16) {
                        ZStack {
                            Circle()
                                .fill(emergencyRed.opacity(0.15))
                                .frame(width: 100, height: 100)
                            
                            Image(systemName: "exclamationmark.triangle.fill")
                                .font(.system(size: 50))
                                .foregroundColor(emergencyRed)
                        }
                        
                        Text("Incorrect Response")
                            .font(.title.bold())
                            .foregroundColor(.primary)
                        
                        Text("Review the correct emergency procedure")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.top, 20)
                    
                    if let mistake = gameState.lastMistake {
                        // Scenario Context
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Image(systemName: "location.fill")
                                    .foregroundColor(.blue)
                                Text("SCENARIO")
                                    .font(.caption.weight(.bold))
                                    .foregroundColor(.secondary)
                            }
                            
                            Text(mistake.scenario)
                                .font(.headline)
                                .foregroundColor(.primary)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(Color(UIColor.secondarySystemGroupedBackground))
                        .cornerRadius(16)
                        .padding(.horizontal)
                        
                        // Your Incorrect Choice
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(emergencyRed)
                                    .font(.title3)
                                Text("YOUR CHOICE")
                                    .font(.caption.weight(.bold))
                                    .foregroundColor(.secondary)
                            }
                            
                            Text(mistake.wrongChoice)
                                .font(.body)
                                .foregroundColor(.primary)
                                .padding(.bottom, 8)
                            
                            Divider()
                            
                            HStack {
                                Image(systemName: "flame.fill")
                                    .foregroundColor(emergencyOrange)
                                Text("CONSEQUENCE")
                                    .font(.caption.weight(.bold))
                                    .foregroundColor(.secondary)
                            }
                            
                            Text(mistake.consequence)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(emergencyRed.opacity(0.1))
                        .cornerRadius(16)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .strokeBorder(emergencyRed.opacity(0.3), lineWidth: 1.5)
                        )
                        .padding(.horizontal)
                        
                        // Correct Action
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                                    .font(.title3)
                                Text("CORRECT ACTION")
                                    .font(.caption.weight(.bold))
                                    .foregroundColor(.secondary)
                            }
                            
                            Text(mistake.correctChoice)
                                .font(.body.weight(.medium))
                                .foregroundColor(.primary)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(Color.green.opacity(0.1))
                        .cornerRadius(16)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .strokeBorder(Color.green.opacity(0.3), lineWidth: 1.5)
                        )
                        .padding(.horizontal)
                        
                        // Educational Explanation
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Image(systemName: "lightbulb.fill")
                                    .foregroundColor(.orange)
                                Text("WHY THIS MATTERS")
                                    .font(.caption.weight(.bold))
                                    .foregroundColor(.secondary)
                            }
                            
                            Text(mistake.explanation)
                                .font(.body)
                                .foregroundColor(.primary)
                                .lineSpacing(4)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(Color(UIColor.secondarySystemGroupedBackground))
                        .cornerRadius(16)
                        .padding(.horizontal)
                    }
                    
                    // Action Buttons
                    VStack(spacing: 12) {
                        Button(action: {
                            HapticManager.shared.lightImpact()
                            withAnimation {
                                gameState.currentScreen = .recognize
                            }
                        }) {
                            HStack {
                                Image(systemName: "arrow.clockwise.circle.fill")
                                Text("Continue Training")
                            }
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [emergencyRed, emergencyOrange]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(16)
                        }
                        
                        Button(action: {
                            HapticManager.shared.lightImpact()
                            withAnimation {
                                gameState.currentScreen = .learning
                            }
                        }) {
                            HStack {
                                Image(systemName: "book.circle.fill")
                                Text("Review Safety Protocols")
                            }
                            .font(.headline)
                            .foregroundColor(.blue)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(16)
                        }
                        
                        // Exit to Home Button
                        Button(action: {
                            HapticManager.shared.lightImpact()
                            showExitAlert = true
                        }) {
                            HStack {
                                Image(systemName: "house.circle.fill")
                                Text("Exit Training")
                            }
                            .font(.headline)
                            .foregroundColor(.secondary)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(UIColor.secondarySystemGroupedBackground))
                            .cornerRadius(16)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 8)
                }
                .padding(.bottom, 30)
            }
            .navigationTitle("Analysis")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        HapticManager.shared.lightImpact()
                        showExitAlert = true
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.secondary)
                    }
                }
            }
            .alert("Exit Training?", isPresented: $showExitAlert) {
                Button("Cancel", role: .cancel) {
                    showExitAlert = false
                }
                Button("Exit to Home", role: .destructive) {
                    HapticManager.shared.mediumImpact()
                    withAnimation {
                        gameState.currentScreen = .home
                    }
                }
            } message: {
                Text("Your current progress will be saved. You can resume training anytime.")
            }
        }
        .navigationViewStyle(.stack)
        .onAppear {
            gameState.timerManager.reset()
        }
    }
}
