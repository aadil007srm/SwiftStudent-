import SwiftUI

struct ResponseScreen: View {
    @ObservedObject var gameState: GameState
    @State private var currentStep = 0
    @State private var showCompletion = false
    
    let emergencyRed = Color(red: 1.0, green: 0.3, blue: 0.2)
    
    var body: some View {
        NavigationView {
            ScrollView {
                if let scenario = gameState.currentScenario {
                    VStack(spacing: 24) {
                        // Header
                        VStack(spacing: 16) {
                            ZStack {
                                Circle()
                                    .fill(emergencyRed.opacity(0.15))
                                    .frame(width: 80, height: 80)
                                
                                Image(systemName: "hand.raised.fill")
                                    .font(.system(size: 40))
                                    .foregroundColor(emergencyRed)
                            }
                            
                            Text("Emergency Response Protocol")
                                .font(.title2.bold())
                                .foregroundColor(.primary)
                                .multilineTextAlignment(.center)
                            
                            Text(scenario.title)
                                .font(.headline)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                        }
                        .padding()
                        .background(Color(UIColor.secondarySystemGroupedBackground))
                        .cornerRadius(16)
                        .padding(.horizontal)
                        .padding(.top, 20)
                        
                        // Educational Context
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Image(systemName: "lightbulb.fill")
                                    .foregroundColor(.orange)
                                Text("KEY INFORMATION")
                                    .font(.caption.weight(.bold))
                                    .foregroundColor(.secondary)
                            }
                            
                            Text(scenario.educationalContext)
                                .font(.body)
                                .foregroundColor(.primary)
                                .lineSpacing(4)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(Color.orange.opacity(0.1))
                        .cornerRadius(16)
                        .padding(.horizontal)
                        
                        // Response Steps
                        VStack(alignment: .leading, spacing: 16) {
                            Text("RESPONSE STEPS")
                                .font(.caption.weight(.bold))
                                .foregroundColor(.secondary)
                            
                            ForEach(scenario.responseSteps) { step in
                                ResponseStepView(
                                    step: step,
                                    isCompleted: step.stepNumber <= currentStep,
                                    isCurrent: step.stepNumber == currentStep
                                )
                                .onTapGesture {
                                    if step.stepNumber == currentStep {
                                        HapticManager.shared.lightImpact()
                                        withAnimation {
                                            if currentStep < scenario.responseSteps.count {
                                                currentStep += 1
                                            } else {
                                                showCompletion = true
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        .padding()
                        .background(Color(UIColor.secondarySystemGroupedBackground))
                        .cornerRadius(16)
                        .padding(.horizontal)
                        
                        // Progress
                        if currentStep > 0 {
                            VStack(spacing: 8) {
                                ProgressView(value: Double(currentStep), total: Double(scenario.responseSteps.count))
                                    .tint(emergencyRed)
                                Text("Step \(currentStep) of \(scenario.responseSteps.count) completed")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            .padding()
                            .background(Color(UIColor.secondarySystemGroupedBackground))
                            .cornerRadius(12)
                            .padding(.horizontal)
                        }
                        
                        // Action Buttons
                        if showCompletion {
                            Button(action: {
                                HapticManager.shared.success()
                                gameState.score += 20
                                withAnimation {
                                    gameState.nextScenario()
                                }
                            }) {
                                HStack {
                                    Text("Continue Training")
                                    Image(systemName: "arrow.right.circle.fill")
                                }
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(
                                    LinearGradient(
                                        gradient: Gradient(colors: [Color.green, Color.mint]),
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .cornerRadius(16)
                            }
                            .padding(.horizontal)
                        } else if currentStep == 0 {
                            Button(action: {
                                HapticManager.shared.lightImpact()
                                withAnimation {
                                    currentStep = 1
                                }
                            }) {
                                HStack {
                                    Text("Begin Response Protocol")
                                    Image(systemName: "play.fill")
                                }
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(emergencyRed)
                                .cornerRadius(16)
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.bottom, 30)
                }
            }
            .navigationTitle("Response")
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationViewStyle(.stack)
        .onAppear {
            currentStep = 0
            showCompletion = false
        }
    }
}

struct ResponseStepView: View {
    let step: ResponseStep
    let isCompleted: Bool
    let isCurrent: Bool
    
    var body: some View {
        HStack(spacing: 12) {
            // Step Number
            ZStack {
                Circle()
                    .fill(isCompleted ? Color.green : (isCurrent ? Color.orange : Color(UIColor.systemGray5)))
                    .frame(width: 36, height: 36)
                
                if isCompleted {
                    Image(systemName: "checkmark")
                        .foregroundColor(.white)
                        .font(.system(size: 14, weight: .bold))
                } else {
                    Text("\(step.stepNumber)")
                        .foregroundColor(isCurrent ? .white : .secondary)
                        .font(.system(size: 14, weight: .semibold))
                }
            }
            
            // Step Content
            HStack(spacing: 10) {
                Image(systemName: step.icon)
                    .foregroundColor(isCompleted ? .green : (isCurrent ? .orange : .secondary))
                    .font(.system(size: 18))
                
                Text(step.instruction)
                    .font(.body)
                    .foregroundColor(isCompleted || isCurrent ? .primary : .secondary)
            }
            
            Spacer()
        }
        .padding()
        .background(
            isCurrent ? Color.orange.opacity(0.1) : Color.clear
        )
        .cornerRadius(12)
    }
}
