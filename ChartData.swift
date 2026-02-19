import Foundation

struct PerformanceMetric: Identifiable, Codable {
    let id: UUID
    let date: Date
    let score: Int
    let accuracy: Int
    let responseTime: Double
    let environment: String
    
    init(id: UUID = UUID(), date: Date = Date(), score: Int, accuracy: Int, responseTime: Double, environment: String) {
        self.id = id
        self.date = date
        self.score = score
        self.accuracy = accuracy
        self.responseTime = responseTime
        self.environment = environment
    }
}

class PerformanceTracker: ObservableObject {
    @Published var metrics: [PerformanceMetric] = []
    
    private let metricsKey = "performanceMetrics"
    
    init() {
        loadMetrics()
    }
    
    func recordSession(score: Int, accuracy: Int, responseTime: Double, environment: String) {
        let metric = PerformanceMetric(
            score: score,
            accuracy: accuracy,
            responseTime: responseTime,
            environment: environment
        )
        metrics.append(metric)
        saveMetrics()
    }
    
    var averageAccuracy: Int {
        guard !metrics.isEmpty else { return 0 }
        let sum = metrics.reduce(0) { $0 + $1.accuracy }
        return sum / metrics.count
    }
    
    var averageResponseTime: Double {
        guard !metrics.isEmpty else { return 0 }
        let sum = metrics.reduce(0.0) { $0 + $1.responseTime }
        return sum / Double(metrics.count)
    }
    
    var totalScore: Int {
        metrics.reduce(0) { $0 + $1.score }
    }
    
    var sessionsCompleted: Int {
        metrics.count
    }
    
    func metricsForEnvironment(_ environment: String) -> [PerformanceMetric] {
        metrics.filter { $0.environment == environment }
    }
    
    private func saveMetrics() {
        if let data = try? JSONEncoder().encode(metrics) {
            UserDefaults.standard.set(data, forKey: metricsKey)
        }
    }
    
    private func loadMetrics() {
        if let data = UserDefaults.standard.data(forKey: metricsKey),
           let savedMetrics = try? JSONDecoder().decode([PerformanceMetric].self, from: data) {
            self.metrics = savedMetrics
        }
    }
}
