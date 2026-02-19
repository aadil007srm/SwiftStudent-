import SwiftUI

struct ParticleSystem: View {
    let type: ParticleType
    @State private var particles: [Particle] = []
    @State private var emitterTimer: Timer?
    
    enum ParticleType {
        case fire
        case smoke
        case sparks
        case explosion
    }
    
    var body: some View {
        TimelineView(.animation) { timeline in
            Canvas { context, size in
                let now = timeline.date.timeIntervalSinceReferenceDate
                
                for particle in particles {
                    let age = now - particle.birthTime
                    guard age < particle.lifetime else { continue }
                    
                    let progress = age / particle.lifetime
                    let opacity = 1.0 - progress
                    
                    var position = particle.position
                    position.y -= CGFloat(age) * particle.velocity.y
                    position.x += CGFloat(age) * particle.velocity.x
                    
                    let particleSize = particle.size * (1.0 - CGFloat(progress) * 0.5)
                    
                    context.opacity = opacity
                    context.fill(
                        Circle().path(in: CGRect(
                            x: position.x - particleSize / 2,
                            y: position.y - particleSize / 2,
                            width: particleSize,
                            height: particleSize
                        )),
                        with: .color(particle.color)
                    )
                }
            }
        }
        .onAppear {
            startEmitting()
        }
        .onDisappear {
            stopEmitting()
        }
    }
    
    private func startEmitting() {
        emitterTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            particles.removeAll { particle in
                Date().timeIntervalSinceReferenceDate - particle.birthTime > particle.lifetime
            }
            
            particles.append(contentsOf: generateParticles())
        }
    }
    
    private func stopEmitting() {
        emitterTimer?.invalidate()
        emitterTimer = nil
    }
    
    private func generateParticles() -> [Particle] {
        switch type {
        case .fire:
            return (0..<3).map { _ in
                Particle(
                    position: CGPoint(x: CGFloat.random(in: 0...300), y: 300),
                    velocity: CGPoint(x: CGFloat.random(in: -10...10), y: CGFloat.random(in: 30...60)),
                    size: CGFloat.random(in: 8...16),
                    color: [.red, .orange, .yellow].randomElement()!,
                    lifetime: Double.random(in: 1.0...2.0)
                )
            }
        case .smoke:
            return (0..<2).map { _ in
                Particle(
                    position: CGPoint(x: CGFloat.random(in: 0...300), y: 300),
                    velocity: CGPoint(x: CGFloat.random(in: -5...5), y: CGFloat.random(in: 20...40)),
                    size: CGFloat.random(in: 12...24),
                    color: .gray.opacity(0.5),
                    lifetime: Double.random(in: 2.0...3.0)
                )
            }
        case .sparks:
            return (0..<5).map { _ in
                Particle(
                    position: CGPoint(x: 150, y: 150),
                    velocity: CGPoint(
                        x: CGFloat.random(in: -50...50),
                        y: CGFloat.random(in: -50...50)
                    ),
                    size: CGFloat.random(in: 3...6),
                    color: .yellow,
                    lifetime: Double.random(in: 0.5...1.0)
                )
            }
        case .explosion:
            return (0..<10).map { _ in
                Particle(
                    position: CGPoint(x: 150, y: 150),
                    velocity: CGPoint(
                        x: CGFloat.random(in: -100...100),
                        y: CGFloat.random(in: -100...100)
                    ),
                    size: CGFloat.random(in: 8...16),
                    color: [.red, .orange, .yellow].randomElement()!,
                    lifetime: Double.random(in: 0.5...1.5)
                )
            }
        }
    }
}

struct Particle {
    let position: CGPoint
    let velocity: CGPoint
    let size: CGFloat
    let color: Color
    let lifetime: Double
    let birthTime: TimeInterval
    
    init(position: CGPoint, velocity: CGPoint, size: CGFloat, color: Color, lifetime: Double) {
        self.position = position
        self.velocity = velocity
        self.size = size
        self.color = color
        self.lifetime = lifetime
        self.birthTime = Date().timeIntervalSinceReferenceDate
    }
}
