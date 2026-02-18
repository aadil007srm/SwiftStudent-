import SwiftUI

struct EnvironmentSelectionScreen: View {
    @ObservedObject var gameState: GameState
    
    let emergencyRed = Color(red: 1.0, green: 0.3, blue: 0.2)
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Header
                    VStack(spacing: 12) {
                        Image(systemName: "location.fill.viewfinder")
                            .font(.system(size: 48))
                            .foregroundColor(emergencyRed)
                        
                        Text("Select Training Environment")
                            .font(.title2.bold())
                            .foregroundColor(.primary)
                            .multilineTextAlignment(.center)
                        
                        Text("Choose where you'll practice hazard recognition")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                    .background(Color(UIColor.secondarySystemGroupedBackground))
                    .cornerRadius(16)
                    .padding(.horizontal)
                    .padding(.top, 20)
                    
                    // Environment Grid
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(EnvironmentType.allCases, id: \.self) { environment in
                            EnvironmentCard(environment: environment) {
                                HapticManager.shared.mediumImpact()
                                gameState.selectedEnvironment = environment
                                gameState.loadScenarios(for: environment)
                                withAnimation {
                                    gameState.currentScreen = .recognize
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom, 30)
            }
            .navigationTitle("Environments")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        HapticManager.shared.lightImpact()
                        withAnimation {
                            gameState.currentScreen = .home
                        }
                    }) {
                        HStack(spacing: 4) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 16, weight: .semibold))
                            Text("Back")
                        }
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct EnvironmentCard: View {
    let environment: EnvironmentType
    let action: () -> Void
    
    @State private var isPressed = false
    
    var body: some View {
        Button(action: {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                isPressed = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation {
                    isPressed = false
                }
                action()
            }
        }) {
            VStack(spacing: 12) {
                ZStack {
                    Circle()
                        .fill(environment.color.opacity(0.15))
                        .frame(width: 64, height: 64)
                    
                    Image(systemName: environment.icon)
                        .font(.system(size: 32))
                        .foregroundColor(environment.color)
                }
                
                Text(environment.rawValue)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(environment.description)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .frame(height: 180)
            .background(Color(UIColor.secondarySystemGroupedBackground))
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .strokeBorder(environment.color.opacity(0.3), lineWidth: 1.5)
            )
            .scaleEffect(isPressed ? 0.95 : 1.0)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
