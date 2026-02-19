import SwiftUI

struct FireAnimation: View {
    @State private var isAnimating = false
    @State private var flameOffset: [CGFloat] = [0, 0, 0]
    @State private var flameScale: [CGFloat] = [1, 1, 1]
    
    var body: some View {
        ZStack {
            // Main flame
            ForEach(0..<3, id: \.self) { index in
                Image(systemName: "flame.fill")
                    .font(.system(size: 60))
                    .foregroundStyle(flameColor(for: index))
                    .offset(y: flameOffset[index])
                    .scaleEffect(flameScale[index])
                    .blur(radius: CGFloat(index) * 2)
            }
        }
        .onAppear {
            startAnimation()
        }
    }
    
    private func flameColor(for index: Int) -> LinearGradient {
        switch index {
        case 0:
            return LinearGradient(
                colors: [.yellow, .orange],
                startPoint: .top,
                endPoint: .bottom
            )
        case 1:
            return LinearGradient(
                colors: [.orange, .red],
                startPoint: .top,
                endPoint: .bottom
            )
        default:
            return LinearGradient(
                colors: [.red, .red.opacity(0.5)],
                startPoint: .top,
                endPoint: .bottom
            )
        }
    }
    
    private func startAnimation() {
        for index in 0..<3 {
            let delay = Double(index) * 0.2
            withAnimation(
                .easeInOut(duration: 0.6 + Double(index) * 0.2)
                .repeatForever(autoreverses: true)
                .delay(delay)
            ) {
                flameOffset[index] = -10
                flameScale[index] = 1.2
            }
        }
    }
}

struct PulsingButton: View {
    let title: String
    let icon: String
    let color: Color
    let action: () -> Void
    
    @State private var isAnimating = false
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.title3)
                Text(title)
                    .font(.headline)
            }
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(color.gradient)
            .cornerRadius(16)
            .shadow(color: color.opacity(0.4), radius: isAnimating ? 12 : 8)
            .scaleEffect(isAnimating ? 1.05 : 1.0)
        }
        .buttonStyle(.plain)
        .onAppear {
            withAnimation(
                .easeInOut(duration: 1.5)
                .repeatForever(autoreverses: true)
            ) {
                isAnimating = true
            }
        }
    }
}
