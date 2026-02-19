import SwiftUI
import Combine

@MainActor  // ✅ Added MainActor
class TimerManager: ObservableObject {
    @Published var timeRemaining: Int = 60
    private var timer: AnyCancellable?
    var onTimeUp: (() -> Void)?
    
    func startTimer(duration: Int = 60, onComplete: (() -> Void)? = nil) {
        timeRemaining = duration
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
    }
    
    func pauseTimer() {
        timer?.cancel()
    }
    
    func reset() {
        stopTimer()
        timeRemaining = 60
    }
}
