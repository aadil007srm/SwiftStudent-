import SwiftUI
import Combine

class TimerManager: ObservableObject {
    @Published var timeRemaining: Int = 60
    @Published var isActive: Bool = false
    @Published var totalTime: Int = 60
    
    private var timer: AnyCancellable?
    var onTimeUp: (() -> Void)?
    
    func startTimer(duration: Int = 60, onComplete: (() -> Void)? = nil) {
        totalTime = duration
        timeRemaining = duration
        isActive = true
        onTimeUp = onComplete
        
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                if self.timeRemaining > 0 {
                    self.timeRemaining -= 1
                } else {
                    self.stopTimer()
                    self.onTimeUp?()
                }
            }
    }
    
    func stopTimer() {
        timer?.cancel()
        isActive = false
    }
    
    func pauseTimer() {
        timer?.cancel()
        isActive = false
    }
    
    func resumeTimer() {
        guard !isActive else { return }
        isActive = true
        
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                if self.timeRemaining > 0 {
                    self.timeRemaining -= 1
                } else {
                    self.stopTimer()
                    self.onTimeUp?()
                }
            }
    }
    
    func reset(to seconds: Int = 60) {
        stopTimer()
        timeRemaining = seconds
        totalTime = seconds
    }
    
    func addTime(_ seconds: Int) {
        timeRemaining += seconds
    }
    
    func getProgressPercentage() -> Double {
        guard totalTime > 0 else { return 0 }
        return Double(timeRemaining) / Double(totalTime)
    }
}
