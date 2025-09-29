import SwiftUI

// MARK: - Combat Log Entry View
// Отображение отдельной записи в журнале боя
// Показывает время, участников, действие и результат с цветовой индикацией
struct CombatLogEntryView: View {
    let entry: CombatLogEntry
    
    var body: some View {
        HStack {
            // Время события
            Text(formatTime(entry.timestamp))
                .font(.caption2)
                .foregroundColor(.secondary)
            
            // Участники и действие
            Text("\(entry.attacker) \(entry.action) \(entry.target)")
                .font(.caption)
            
            Spacer()
            
            // Результат с цветовой индикацией
            Text(entry.result)
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(resultColor)
            
            // Урон (если есть)
            if let damage = entry.damage, damage > 0 {
                Text("(-\(damage))")
                    .font(.caption2)
                    .foregroundColor(.red)
            }
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 2)
    }
    
    // MARK: - Helper Methods
    // Вспомогательные методы для форматирования
    
    private func formatTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        return formatter.string(from: date)
    }
    
    private var resultColor: Color {
        if entry.result.contains("Попадание") {
            return .red
        } else if entry.result.contains("Промах") {
            return .orange
        } else if entry.result.contains("Восстановлено") {
            return .green
        } else {
            return .primary
        }
    }
}

// MARK: - Preview
// Предварительный просмотр для разработки
#Preview {
    VStack(spacing: 4) {
        CombatLogEntryView(entry: CombatLogEntry(
            attacker: "Герой",
            target: "Гоблин",
            action: "атакует",
            result: "Попадание!",
            damage: 5
        ))
        
        CombatLogEntryView(entry: CombatLogEntry(
            attacker: "Гоблин",
            target: "Герой",
            action: "атакует",
            result: "Промах!"
        ))
        
        CombatLogEntryView(entry: CombatLogEntry(
            attacker: "Герой",
            target: "Герой",
            action: "исцеляется",
            result: "Восстановлено здоровье!"
        ))
    }
    .padding()
}
