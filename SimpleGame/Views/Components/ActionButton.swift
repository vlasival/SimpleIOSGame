import SwiftUI

struct ActionButton: View {
    let title: String
    let color: Color
    let isEnabled: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(isEnabled ? color : Color.gray)
                .cornerRadius(12)
        }
        .disabled(!isEnabled)
        .scaleEffect(isEnabled ? 1.0 : 0.95)
        .animation(.easeInOut(duration: 0.1), value: isEnabled)
    }
}

#Preview {
    VStack(spacing: 16) {
        ActionButton(
            title: "⚔️ Атаковать",
            color: .red,
            isEnabled: true
        ) {
            print("Attack")
        }
        
        ActionButton(
            title: "💚 Исцелиться",
            color: .green,
            isEnabled: false
        ) {
            print("Heal")
        }
    }
    .padding()
}
