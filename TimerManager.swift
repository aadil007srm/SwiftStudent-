import SwiftUI

@MainActor
class TimerManager: ObservableObject {
    @Published var timeRemaining: Int = 60
    private var timer: Timer?
    private var onTimeout: (() -> Void)?
    
    func startTimer(duration: Int = 60, onComplete: (() -> Void)? = nil) {
        self.timeRemaining = duration
        self.onTimeout = onComplete
        
        timer?.invalidate()
        let newTimer = Timer(timeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                self.timer?.invalidate()
                self.timer = nil
                self.onTimeout?()
            }
        }
        RunLoop.main.add(newTimer, forMode: .common)
        timer = newTimer
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func pauseTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func reset() {
        timer?.invalidate()
        timer = nil
        timeRemaining = 60
    }
}
