import SwiftUI

// MARK: - Action Buttons View
// Панель кнопок действий игрока
// Содержит кнопки атаки и исцеления с автоматической атакой монстра
struct ActionButtonsView: View {
    let gameManager: GameManager
    let onError: (String) -> Void
    
    var body: some View {
        VStack(spacing: 12) {
            // Горизонтальная панель кнопок действий
            HStack(spacing: 12) {
                // Кнопка атаки
                ActionButton(
                    title: "⚔️ Атаковать",
                    color: .red,
                    isEnabled: gameManager.canPlayerAct
                ) {
                    performPlayerAttack()
                }
                
                // Кнопка исцеления
                ActionButton(
                    title: "💚 Исцелиться",
                    color: .green,
                    isEnabled: gameManager.canPlayerAct && gameManager.player?.canHeal == true
                ) {
                    performPlayerHeal()
                }
            }
        }
    }
    
    // MARK: - Action Methods
    // Методы для выполнения действий игрока
    
    private func performPlayerAttack() {
        do {
            try gameManager.playerAttack()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                if gameManager.canMonsterAct {
                    performMonsterAttack()
                }
            }
        } catch {
            onError(error.localizedDescription)
        }
    }
    
    private func performPlayerHeal() {
        do {
            try gameManager.playerHeal()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                if gameManager.canMonsterAct {
                    performMonsterAttack()
                }
            }
        } catch {
            onError(error.localizedDescription)
        }
    }
    
    private func performMonsterAttack() {
        do {
            try gameManager.monsterAttack()
        } catch {
            onError(error.localizedDescription)
        }
    }
}

// MARK: - Preview
// Предварительный просмотр для разработки
#Preview {
    ActionButtonsView(gameManager: GameManager()) { error in
        print("Error: \(error)")
    }
    .padding()
}
