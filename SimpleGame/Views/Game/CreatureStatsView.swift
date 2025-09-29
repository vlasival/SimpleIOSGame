import SwiftUI

// MARK: - Creature Stats View
// Панель отображения статистик существа (игрок или монстр)
// Показывает атаку, защиту, урон, здоровье и полосу здоровья
struct CreatureStatsView: View {
    let creature: CreatureProtocol
    let title: String
    let backgroundColor: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Заголовок с именем существа
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
            
            // Статистики в две колонки
            HStack {
                // Левая колонка: Атака и Защита
                VStack(alignment: .leading, spacing: 4) {
                    StatRow(label: "Атака", value: "\(creature.attack)")
                    StatRow(label: "Защита", value: "\(creature.defense)")
                }
                
                Spacer()
                
                // Правая колонка: Урон и Здоровье
                VStack(alignment: .trailing, spacing: 4) {
                    StatRow(label: "Урон", value: "\(creature.damageRange.min)-\(creature.damageRange.max)")
                    StatRow(label: "Здоровье", value: "\(creature.currentHealth)/\(creature.maxHealth)")
                }
            }
            
            // Полоса здоровья с анимацией
            HealthBarView(current: creature.currentHealth, max: creature.maxHealth)
        }
        .padding()
        .background(backgroundColor)
        .cornerRadius(12)
        .shadow(radius: 4)
    }
}

// MARK: - Preview
// Предварительный просмотр для разработки
#Preview {
    VStack(spacing: 16) {
        CreatureStatsView(
            creature: try! Player(name: "Герой", attack: 15, defense: 10, maxHealth: 100, damageRange: try! DamageRange(min: 2, max: 8)),
            title: "Игрок",
            backgroundColor: .blue
        )
        
        CreatureStatsView(
            creature: try! Monster(type: .orc),
            title: "Монстр",
            backgroundColor: .red
        )
    }
    .padding()
}
