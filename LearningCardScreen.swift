import SwiftUI

struct LearningCardScreen: View {
    @ObservedObject var gameState: GameState
    @State private var currentCardIndex = 0
    
    let learningCards = LearningCardData.allCards
    let emergencyRed = Color(red: 1.0, green: 0.3, blue: 0.2)
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Progress Indicator
                VStack(spacing: 12) {
                    HStack {
                        Text("Card \(currentCardIndex + 1) of \(learningCards.count)")
                            .font(.subheadline.weight(.medium))
                            .foregroundColor(.secondary)
                        
                        Spacer()
                        
                        Text(learningCards[currentCardIndex].title)
                            .font(.subheadline.weight(.semibold))
                            .foregroundColor(.primary)
                            .lineLimit(1)
                    }
                    
                    ProgressView(value: Double(currentCardIndex + 1), total: Double(learningCards.count))
                        .tint(emergencyRed)
                }
                .padding()
                .background(Color(UIColor.secondarySystemGroupedBackground))
                
                // Learning Card Content
                ScrollView {
                    LearningCard(card: learningCards[currentCardIndex])
                        .padding()
                }
                
                // Navigation Buttons
                HStack(spacing: 12) {
                    Button(action: {
                        HapticManager.shared.lightImpact()
                        withAnimation {
                            if currentCardIndex > 0 {
                                currentCardIndex -= 1
                            }
                        }
                    }) {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Previous")
                        }
                        .font(.headline)
                        .foregroundColor(currentCardIndex > 0 ? .blue : .secondary)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(UIColor.secondarySystemGroupedBackground))
                        .cornerRadius(12)
                    }
                    .disabled(currentCardIndex == 0)
                    
                    Button(action: {
                        HapticManager.shared.lightImpact()
                        withAnimation {
                            if currentCardIndex < learningCards.count - 1 {
                                currentCardIndex += 1
                            }
                        }
                    }) {
                        HStack {
                            Text("Next")
                            Image(systemName: "chevron.right")
                        }
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            currentCardIndex < learningCards.count - 1
                            ? LinearGradient(
                                gradient: Gradient(colors: [emergencyRed, Color(red: 1.0, green: 0.5, blue: 0.0)]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                            : LinearGradient(
                                gradient: Gradient(colors: [Color.gray, Color.gray]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(12)
                    }
                    .disabled(currentCardIndex == learningCards.count - 1)
                }
                .padding()
                .background(Color(UIColor.systemBackground))
            }
            .navigationTitle("Safety Protocols")
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

struct LearningCard: View {
    let card: LearningCardContent
    
    var body: some View {
        VStack(spacing: 24) {
            // Icon and Title
            VStack(spacing: 12) {
                ZStack {
                    Circle()
                        .fill(card.color.opacity(0.15))
                        .frame(width: 80, height: 80)
                    
                    Image(systemName: card.icon)
                        .font(.system(size: 40))
                        .foregroundColor(card.color)
                }
                
                Text(card.title)
                    .font(.title2.bold())
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
            }
            
            // Description
            Text(card.description)
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .lineSpacing(4)
                .padding(.horizontal)
            
            Divider()
                .padding(.horizontal)
            
            // Key Points
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Image(systemName: "list.bullet.circle.fill")
                        .foregroundColor(card.color)
                    Text("KEY POINTS")
                        .font(.caption.weight(.bold))
                        .foregroundColor(.secondary)
                }
                
                ForEach(Array(card.keyPoints.enumerated()), id: \.offset) { index, point in
                    HStack(alignment: .top, spacing: 12) {
                        ZStack {
                            Circle()
                                .fill(card.color.opacity(0.15))
                                .frame(width: 28, height: 28)
                            
                            Text("\(index + 1)")
                                .font(.caption.weight(.bold))
                                .foregroundColor(card.color)
                        }
                        
                        Text(point)
                            .font(.body)
                            .foregroundColor(.primary)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(Color(UIColor.secondarySystemGroupedBackground))
            .cornerRadius(16)
            
            // Example
            if let example = card.example {
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Image(systemName: "lightbulb.fill")
                            .foregroundColor(.orange)
                        Text("REAL-WORLD EXAMPLE")
                            .font(.caption.weight(.bold))
                            .foregroundColor(.secondary)
                    }
                    
                    Text(example)
                        .font(.body)
                        .foregroundColor(.primary)
                        .lineSpacing(4)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color.orange.opacity(0.1))
                .cornerRadius(16)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .strokeBorder(Color.orange.opacity(0.3), lineWidth: 1.5)
                )
            }
        }
        .padding(.vertical)
    }
}
