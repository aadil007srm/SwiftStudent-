import SwiftUI

struct EvacuationTutorialView: View {
    @Binding var isShowing: Bool

    var body: some View {
        ZStack {
            Color.black.opacity(0.72).ignoresSafeArea()

            VStack(spacing: 24) {
                Text("How to Play")
                    .font(.title.bold())
                    .foregroundColor(.white)

                VStack(alignment: .leading, spacing: 16) {
                    TutorialStep(icon: "hand.draw.fill",      text: "Draw evacuation route with your finger")
                    TutorialStep(icon: "flame.fill",           text: "Avoid fire (red) and heavy smoke (gray)")
                    TutorialStep(icon: "person.2.fill",        text: "Pass through trapped people to rescue them")
                    TutorialStep(icon: "door.left.hand.open",  text: "End near a green exit door")
                    TutorialStep(icon: "timer",                text: "Complete before the 60-second timer runs out!")
                }
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(16)

                Button {
                    isShowing = false
                } label: {
                    Text("Start Evacuation")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.safe60Red)
                        .cornerRadius(12)
                }
            }
            .padding()
        }
    }
}

struct TutorialStep: View {
    let icon: String
    let text: String

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.safe60Red)
                .frame(width: 30)
            Text(text)
                .font(.body)
        }
    }
}

#Preview {
    EvacuationTutorialView(isShowing: .constant(true))
}
