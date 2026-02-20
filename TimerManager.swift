import Foundation
import SwiftUI

@MainActor
class TimerManager: ObservableObject {
    @Published var timeRemaining: Int = 60
    private var timer: Timer?
    private var onTimeout: (() -> Void)?
    
    func startTimer(duration: Int, onTimeout: @escaping @MainActor () -> Void) {
        // Reset first
        self.timeRemaining = duration
        self.onTimeout = onTimeout
        
        // Cancel any existing timer
        timer?.invalidate()
        timer = nil
        
        // Create a repeating timer that fires every 1 second
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            
            Task { @MainActor in
                if self.timeRemaining > 0 {
                    self.timeRemaining -= 1
                } else {
                    self.timer?.invalidate()
                    self.timer = nil
                    self.onTimeout?()
                }
            }
        }
        
        // Add to run loop to ensure it runs even during scrolling
        if let timer = timer {
            RunLoop.main.add(timer, forMode: .common)
        }
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
