import SwiftUI

struct HealthBarView: View {
    let current: Int
    let max: Int
    
    private var healthPercentage: Double {
        guard max > 0 else { return 0 }
        return Double(current) / Double(max)
    }
    
    private var healthColor: Color {
        if healthPercentage > 0.6 {
            return .green
        } else if healthPercentage > 0.3 {
            return .yellow
        } else {
            return .red
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack {
                Text("Здоровье")
                    .font(.caption2)
                    .foregroundColor(.white.opacity(0.8))
                Spacer()
                Text("\(current)/\(max)")
                    .font(.caption2)
                    .foregroundColor(.white)
            }
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color.white.opacity(0.2))
                        .frame(height: 8)
                        .cornerRadius(4)
                    
                    Rectangle()
                        .fill(healthColor)
                        .frame(width: geometry.size.width * healthPercentage, height: 8)
                        .cornerRadius(4)
                        .animation(.easeInOut(duration: 0.3), value: healthPercentage)
                }
            }
            .frame(height: 8)
        }
    }
}

#Preview {
    VStack(spacing: 16) {
        HealthBarView(current: 100, max: 100)
        HealthBarView(current: 60, max: 100)
        HealthBarView(current: 30, max: 100)
        HealthBarView(current: 10, max: 100)
    }
    .padding()
    .background(Color.blue)
    .cornerRadius(8)
}
