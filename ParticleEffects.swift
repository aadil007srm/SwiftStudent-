import SwiftUI

// Particle model
struct Particle: Identifiable {
    let id = UUID()
    var position: CGPoint
    var velocity: CGPoint
    var size: CGFloat
    var opacity: Double
    var color: Color
    var lifetime: Double
}

// Particle System
@MainActor  // ✅ Add MainActor to the class
class ParticleSystem: ObservableObject {
    @Published var particles: [Particle] = []
    
    private var particleType: ParticleType
    private var timer: Timer?
    
    init(type: ParticleType) {
        self.particleType = type
    }
    
    func start() {
        // ✅ Use main thread timer
        timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            Task { @MainActor in
                self.updateParticles()
                self.generateParticles()
            }
        }
    }
    
    func stop() {
        timer?.invalidate()
        timer = nil
        particles.removeAll()
    }
    
    private func generateParticles() {
        let newParticles = particleType.generate()
        particles.append(contentsOf: newParticles)
    }
    
    private func updateParticles() {
        particles = particles.compactMap { particle in
            var updated = particle
            updated.position.x += particle.velocity.x
            updated.position.y += particle.velocity.y
            updated.opacity -= 0.02
            updated.lifetime -= 0.05
            
            return updated.lifetime > 0 ? updated : nil
        }
    }
}

// Particle Types
enum ParticleType {
    case fire
    case smoke
    case sparks
    case explosion
    
    func generate() -> [Particle] {
        switch self {
        case .fire:
            return generateFireParticles()
        case .smoke:
            return generateSmokeParticles()
        case .sparks:
            return generateSparkParticles()
        case .explosion:
            return generateExplosionParticles()
        }
    }
    
    private func generateFireParticles() -> [Particle] {
        (0..<3).map { _ in
            Particle(
                position: CGPoint(x: 200 + CGFloat.random(in: -20...20), y: 400),
                velocity: CGPoint(x: CGFloat.random(in: -1...1), y: CGFloat.random(in: -3...(-1))),
                size: CGFloat.random(in: 8...16),
                opacity: 1.0,
                color: [Color.red, Color.orange, Color.yellow].randomElement()!,
                lifetime: Double.random(in: 1...2)
            )
        }
    }
    
    private func generateSmokeParticles() -> [Particle] {
        (0..<2).map { _ in
            Particle(
                position: CGPoint(x: 200 + CGFloat.random(in: -30...30), y: 400),
                velocity: CGPoint(x: CGFloat.random(in: -0.5...0.5), y: CGFloat.random(in: -2...(-0.5))),
                size: CGFloat.random(in: 12...24),
                opacity: 0.7,
                color: Color.gray.opacity(0.6),
                lifetime: Double.random(in: 2...3)
            )
        }
    }
    
    private func generateSparkParticles() -> [Particle] {
        (0..<5).map { _ in
            Particle(
                position: CGPoint(x: 200, y: 400),
                velocity: CGPoint(
                    x: CGFloat.random(in: -3...3),
                    y: CGFloat.random(in: -3...3)
                ),
                size: CGFloat.random(in: 2...4),
                opacity: 1.0,
                color: Color.yellow,
                lifetime: Double.random(in: 0.5...1)
            )
        }
    }
    
    private func generateExplosionParticles() -> [Particle] {
        (0..<15).map { _ in
            let angle = Double.random(in: 0...(2 * .pi))
            let speed = CGFloat.random(in: 2...5)
            
            return Particle(
                position: CGPoint(x: 200, y: 400),
                velocity: CGPoint(
                    x: cos(angle) * speed,
                    y: sin(angle) * speed
                ),
                size: CGFloat.random(in: 4...8),
                opacity: 1.0,
                color: [Color.red, Color.orange, Color.yellow].randomElement()!,
                lifetime: Double.random(in: 1...1.5)
            )
        }
    }
}

// Particle View using Canvas
struct ParticleEffectView: View {
    @StateObject private var particleSystem: ParticleSystem
    
    init(type: ParticleType) {
        _particleSystem = StateObject(wrappedValue: ParticleSystem(type: type))
    }
    
    var body: some View {
        Canvas { context, size in
            for particle in particleSystem.particles {
                var particleContext = context
                particleContext.opacity = particle.opacity
                
                let rect = CGRect(
                    x: particle.position.x - particle.size / 2,
                    y: particle.position.y - particle.size / 2,
                    width: particle.size,
                    height: particle.size
                )
                
                particleContext.fill(
                    Circle().path(in: rect),
                    with: .color(particle.color)
                )
            }
        }
        .onAppear {
            particleSystem.start()
        }
        .onDisappear {
            particleSystem.stop()
        }
    }
}

// Fire Animation View (for training scenes)
struct FireAnimationView: View {
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            // Base fire using particles
            ParticleEffectView(type: .fire)
            
            // Additional flame shapes for effect
            VStack(spacing: -20) {
                ForEach(0..<3, id: \.self) { index in
                    Image(systemName: "flame.fill")
                        .font(.system(size: 60))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.red, .orange, .yellow],
                                startPoint: .bottom,
                                endPoint: .top
                            )
                        )
                        .scaleEffect(isAnimating ? 1.2 : 0.8)
                        .opacity(isAnimating ? 0.8 : 0.6)
                        .animation(
                            .easeInOut(duration: 0.5)
                            .repeatForever(autoreverses: true)
                            .delay(Double(index) * 0.2),
                            value: isAnimating
                        )
                }
            }
        }
        .onAppear {
            isAnimating = true
        }
    }
}

// Smoke Animation View
struct SmokeAnimationView: View {
    var body: some View {
        ParticleEffectView(type: .smoke)
    }
}

// Explosion Animation View (for wrong decisions)
struct ExplosionAnimationView: View {
    @State private var showExplosion = false
    
    var body: some View {
        ZStack {
            if showExplosion {
                ParticleEffectView(type: .explosion)
                
                Image(systemName: "burst.fill")
                    .font(.system(size: 100))
                    .foregroundStyle(.red.gradient)
                    .scaleEffect(showExplosion ? 2.0 : 0.1)
                    .opacity(showExplosion ? 0 : 1)
            }
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.5)) {
                showExplosion = true
            }
        }
    }
}

// Preview
#Preview {
    VStack(spacing: 40) {
        Text("Fire Effect")
            .font(.headline)
        FireAnimationView()
            .frame(height: 200)
        
        Text("Smoke Effect")
            .font(.headline)
        SmokeAnimationView()
            .frame(height: 200)
    }
}
