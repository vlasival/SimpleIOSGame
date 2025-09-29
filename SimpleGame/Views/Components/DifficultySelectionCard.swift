import SwiftUI

struct DifficultySelectionCard: View {
    let difficulty: DifficultyLevel
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            HStack {
                Text(difficulty.icon)
                    .font(.title2)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(difficulty.rawValue)
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text(difficulty.description)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.leading)
                }
                
                Spacer()
                
                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.blue)
                        .font(.title2)
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(isSelected ? Color.blue.opacity(0.1) : Color.gray.opacity(0.1))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(isSelected ? Color.blue : Color.clear, lineWidth: 2)
                    )
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    VStack(spacing: 8) {
        DifficultySelectionCard(
            difficulty: .easy,
            isSelected: true
        ) {
            print("Easy selected")
        }
        
        DifficultySelectionCard(
            difficulty: .normal,
            isSelected: false
        ) {
            print("Normal selected")
        }
        
        DifficultySelectionCard(
            difficulty: .hard,
            isSelected: false
        ) {
            print("Hard selected")
        }
    }
    .padding()
}
