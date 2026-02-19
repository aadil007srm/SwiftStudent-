import SwiftUI

struct CustomButton: View {
    let title: String
    let icon: String?
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                if let icon = icon {
                    Image(systemName: icon)
                        .font(.title3)
                }
                Text(title)
                    .font(.headline)
            }
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(color.gradient)
            .cornerRadius(16)
            .shadow(color: color.opacity(0.3), radius: 8)
        }
        .buttonStyle(.plain)
    }
}

struct QuickAccessCard: View {
    let title: String
    let icon: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.system(size: 36))
                    .foregroundStyle(color.gradient)
                
                Text(title)
                    .font(.subheadline.bold())
                    .foregroundStyle(.primary)
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.1), radius: 4)
        }
        .buttonStyle(.plain)
    }
}
