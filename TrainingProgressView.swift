import SwiftUI
import Charts

struct TrainingProgressView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var performanceTracker = PerformanceTracker()
    @StateObject private var badgeManager = BadgeManager()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    // Overview Stats
                    VStack(spacing: 16) {
                        Text("Your Progress")
                            .font(.title.bold())
                        
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                            StatCard(
                                title: "Sessions",
                                value: "\(performanceTracker.sessionsCompleted)",
                                icon: "checkmark.circle.fill",
                                color: .blue
                            )
                            
                            StatCard(
                                title: "Avg Accuracy",
                                value: "\(performanceTracker.averageAccuracy)%",
                                icon: "target",
                                color: .green
                            )
                            
                            StatCard(
                                title: "Total Score",
                                value: "\(performanceTracker.totalScore)",
                                icon: "star.fill",
                                color: .yellow
                            )
                            
                            StatCard(
                                title: "Badges",
                                value: "\(badgeManager.unlockedCount)/\(badgeManager.badges.count)",
                                icon: "trophy.fill",
                                color: .orange
                            )
                        }
                    }
                    .padding()
                    
                    // Accuracy Chart
                    if !performanceTracker.metrics.isEmpty {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Accuracy Over Time")
                                .font(.headline)
                                .padding(.horizontal)
                            
                            Chart {
                                ForEach(Array(performanceTracker.metrics.enumerated()), id: \.element.id) { index, metric in
                                    LineMark(
                                        x: .value("Session", index + 1),
                                        y: .value("Accuracy", metric.accuracy)
                                    )
                                    .foregroundStyle(.green.gradient)
                                    
                                    AreaMark(
                                        x: .value("Session", index + 1),
                                        y: .value("Accuracy", metric.accuracy)
                                    )
                                    .foregroundStyle(.green.opacity(0.1))
                                }
                            }
                            .frame(height: 200)
                            .chartYScale(domain: 0...100)
                            .chartXAxis {
                                AxisMarks(values: .automatic) { _ in
                                    AxisGridLine()
                                    AxisValueLabel()
                                }
                            }
                            .chartYAxis {
                                AxisMarks(position: .leading) { _ in
                                    AxisGridLine()
                                    AxisValueLabel()
                                }
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                            .padding(.horizontal)
                        }
                        
                        // Score Chart
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Score Per Session")
                                .font(.headline)
                                .padding(.horizontal)
                            
                            Chart {
                                ForEach(Array(performanceTracker.metrics.enumerated()), id: \.element.id) { index, metric in
                                    BarMark(
                                        x: .value("Session", index + 1),
                                        y: .value("Score", metric.score)
                                    )
                                    .foregroundStyle(.blue.gradient)
                                }
                            }
                            .frame(height: 200)
                            .chartXAxis {
                                AxisMarks(values: .automatic) { _ in
                                    AxisGridLine()
                                    AxisValueLabel()
                                }
                            }
                            .chartYAxis {
                                AxisMarks(position: .leading) { _ in
                                    AxisGridLine()
                                    AxisValueLabel()
                                }
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                            .padding(.horizontal)
                        }
                    } else {
                        VStack(spacing: 16) {
                            Image(systemName: "chart.line.uptrend.xyaxis")
                                .font(.system(size: 60))
                                .foregroundStyle(.secondary)
                            
                            Text("No Data Yet")
                                .font(.headline)
                            
                            Text("Complete training sessions to see your progress here")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                                .multilineTextAlignment(.center)
                        }
                        .padding()
                    }
                    
                    // Badges Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Badges")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                            ForEach(badgeManager.badges) { badge in
                                BadgeCard(badge: badge)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("Progress")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct StatCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: icon)
                .font(.title)
                .foregroundStyle(color.gradient)
            
            Text(value)
                .font(.title2.bold())
            
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

struct BadgeCard: View {
    let badge: Badge
    
    var body: some View {
        VStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(badge.isUnlocked ? badge.colorValue.gradient : Color(.systemGray5))
                    .frame(width: 60, height: 60)
                
                Image(systemName: badge.icon)
                    .font(.title2)
                    .foregroundStyle(badge.isUnlocked ? .white : .secondary)
            }
            
            Text(badge.name)
                .font(.caption.bold())
                .multilineTextAlignment(.center)
                .foregroundStyle(badge.isUnlocked ? .primary : .secondary)
            
            if badge.isUnlocked {
                Text("✓ Unlocked")
                    .font(.caption2)
                    .foregroundStyle(.green)
            } else {
                Text("Locked")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(badge.isUnlocked ? badge.colorValue.opacity(0.1) : Color(.systemGray6))
        .cornerRadius(12)
        .opacity(badge.isUnlocked ? 1.0 : 0.6)
    }
}
