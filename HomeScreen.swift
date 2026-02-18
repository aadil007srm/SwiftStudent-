import SwiftUI

struct HomeScreen: View {
    @ObservedObject var gameState: GameState
    
    let emergencyRed = Color(red: 1.0, green: 0.3, blue: 0.2)
    let emergencyOrange = Color(red: 1.0, green: 0.5, blue: 0.0)
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Header Card
                    VStack(spacing: 16) {
                        Image(systemName: "alarm.fill")
                            .font(.system(size: 50))
                            .foregroundStyle(
                                LinearGradient(
                                    gradient: Gradient(colors: [emergencyRed, emergencyOrange]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                        
                        Text("Real-Time Emergency Training")
                            .font(.title2.bold())
                            .foregroundColor(.primary)
                            .multilineTextAlignment(.center)
                        
                        Text("Recognize hazards and respond under time pressure")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(UIColor.secondarySystemGroupedBackground))
                    .cornerRadius(16)
                    .padding(.horizontal)
                    .padding(.top, 20)
                    
                    // Core Principles
                    VStack(spacing: 12) {
                        Text("Training Focus")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HStack(spacing: 12) {
                            PrincipleTag(icon: "exclamationmark.circle.fill", label: "Urgency", color: emergencyRed)
                            PrincipleTag(icon: "gauge.high", label: "Risk", color: emergencyOrange)
                        }
                        
                        HStack(spacing: 12) {
                            PrincipleTag(icon: "hand.raised.fill", label: "Control", color: .blue)
                            PrincipleTag(icon: "checkmark.shield.fill", label: "Stability", color: .green)
                        }
                    }
                    .padding()
                    .background(Color(UIColor.secondarySystemGroupedBackground))
                    .cornerRadius(16)
                    .padding(.horizontal)
                    
                    // Training Phases
                    VStack(spacing: 16) {
                        HomeCard(
                            icon: "eye.fill",
                            title: "Recognize Hazards",
                            description: "Identify emergency scenarios in real-time",
                            color: emergencyRed
                        ) {
                            HapticManager.shared.lightImpact()
                            gameState.currentScreen = .environmentSelection
                            gameState.currentPhase = .recognize
                        }
                        
                        HomeCard(
                            icon: "bolt.fill",
                            title: "Respond Correctly",
                            description: "Make safety decisions under pressure",
                            color: emergencyOrange
                        ) {
                            HapticManager.shared.lightImpact()
                            gameState.currentScreen = .environmentSelection
                            gameState.currentPhase = .respond
                        }
                        
                        HomeCard(
                            icon: "chart.bar.fill",
                            title: "Performance Review",
                            description: "Analyze your emergency response skills",
                            color: .blue
                        ) {
                            HapticManager.shared.lightImpact()
                            if gameState.totalDecisions > 0 {
                                gameState.currentScreen = .completion
                            }
                        }
                        
                        HomeCard(
                            icon: "book.fill",
                            title: "Safety Protocols",
                            description: "Study emergency response procedures",
                            color: .green
                        ) {
                            HapticManager.shared.lightImpact()
                            gameState.currentScreen = .learning
                        }
                    }
                    .padding(.horizontal)
                    
                    // Stats if available
                    if gameState.totalDecisions > 0 {
                        VStack(spacing: 16) {
                            Text("Your Performance")
                                .font(.headline)
                                .foregroundColor(.primary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            HStack(spacing: 16) {
                                StatBadge(value: "\(gameState.score)", label: "Score", color: .blue)
                                StatBadge(value: "\(Int(gameState.accuracyPercentage))%", label: "Accuracy", color: .green)
                                StatBadge(value: "\(gameState.completedScenarios.count)", label: "Completed", color: emergencyOrange)
                            }
                        }
                        .padding()
                        .background(Color(UIColor.secondarySystemGroupedBackground))
                        .cornerRadius(16)
                        .padding(.horizontal)
                    }
                }
                .padding(.bottom, 30)
            }
            .navigationTitle("Safe60")
            .navigationBarTitleDisplayMode(.large)
        }
        .navigationViewStyle(.stack)
    }
}

struct PrincipleTag: View {
    let icon: String
    let label: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 18))
                .foregroundColor(color)
            
            Text(label)
                .font(.subheadline.weight(.semibold))
                .foregroundColor(.primary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(color.opacity(0.1))
        .cornerRadius(10)
    }
}

struct HomeCard: View {
    let icon: String
    let title: String
    let description: String
    let color: Color
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
            HStack(spacing: 16) {
                ZStack {
                    Circle()
                        .fill(color.opacity(0.15))
                        .frame(width: 56, height: 56)
                    
                    Image(systemName: icon)
                        .font(.system(size: 24))
                        .foregroundColor(color)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text(description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(Color(UIColor.tertiaryLabel))
            }
            .padding()
            .background(Color(UIColor.secondarySystemGroupedBackground))
            .cornerRadius(16)
            .scaleEffect(isPressed ? 0.97 : 1.0)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct StatBadge: View {
    let value: String
    let label: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 6) {
            Text(value)
                .font(.title2.bold())
                .foregroundColor(color)
            
            Text(label)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(color.opacity(0.1))
        .cornerRadius(12)
    }
}
