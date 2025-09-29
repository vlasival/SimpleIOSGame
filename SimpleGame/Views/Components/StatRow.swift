import SwiftUI

struct StatRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(label)
                .font(.caption)
                .foregroundColor(.white.opacity(0.8))
            Spacer()
            Text(value)
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(.white)
        }
    }
}

#Preview {
    VStack(spacing: 8) {
        StatRow(label: "Атака", value: "15")
        StatRow(label: "Защита", value: "10")
        StatRow(label: "Урон", value: "2-8")
        StatRow(label: "Здоровье", value: "100/100")
    }
    .padding()
    .background(Color.blue)
    .cornerRadius(8)
}
