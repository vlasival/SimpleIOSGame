import SwiftUI

// MARK: - Game Screen View
// Основной игровой экран с всеми игровыми компонентами
// Выделен в отдельный компонент для лучшей организации кода
struct GameScreenView: View {
    @Bindable var gameManager: GameManager
    let onError: (String) -> Void
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // MARK: - Game Status
                // Статус игры и прогресс
                GameStatusView(gameManager: gameManager)
                
                // MARK: - Creature Stats
                // Статистики игрока и монстра
                if let player = gameManager.player, let monster = gameManager.currentMonster {
                    VStack(spacing: 16) {
                        CreatureStatsView(
                            creature: player,
                            title: "\(player.name) (Игрок)",
                            backgroundColor: .blue
                        )
                        
                        CreatureStatsView(
                            creature: monster,
                            title: "\(monster.name) (Монстр)",
                            backgroundColor: .red
                        )
                    }
                }
                
                // MARK: - Action Buttons
                // Кнопки действий игрока
                ActionButtonsView(gameManager: gameManager) { message in
                    onError(message)
                }
                
                // MARK: - Combat Log
                // Журнал боя
                CombatLogView(log: gameManager.combatLog)
            }
            .padding()
        }
    }
}

// MARK: - Preview
// Предварительный просмотр для разработки
#Preview {
    GameScreenView(gameManager: GameManager()) { error in
        print("Error: \(error)")
    }
}
