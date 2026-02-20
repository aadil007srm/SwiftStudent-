import Foundation
import Combine

@MainActor
class TimerManager: ObservableObject {
    @Published var timeRemaining: Int = 60
    private var timer: AnyCancellable?
    private var onTimeout: (() -> Void)?
    
    func startTimer(duration: Int, onTimeout: @escaping () -> Void) {
        self.timeRemaining = duration
        self.onTimeout = onTimeout
        
        // Cancel any existing timer
        timer?.cancel()
        
        // Create a timer that fires EVERY SECOND on the main thread
        timer = Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                
                if self.timeRemaining > 0 {
                    self.timeRemaining -= 1
                } else {
                    self.timer?.cancel()
                    self.onTimeout?()
                }
            }
    }
    
    func pauseTimer() {
        timer?.cancel()
    }
    
    func reset() {
        timer?.cancel()
        timeRemaining = 60
    }
    
    deinit {
        timer?.cancel()
    }
}
