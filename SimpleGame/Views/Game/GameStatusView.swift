import SwiftUI

struct GameStatusView: View {
    let gameManager: GameManager
    
    var body: some View {
        VStack(spacing: 12) {
            Text(statusText)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(statusColor)
            
            if gameManager.gameState == .inProgress {
                VStack(spacing: 8) {
                    Text(gameManager.battleStatusText)
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    ProgressView(value: gameManager.battleProgress) {
                        Text("Побеждено: \(gameManager.defeatedMonsters)/\(gameManager.totalMonsters)")
                    }
                    .progressViewStyle(.linear)
                    .tint(.green)
                    
                    Text("Раунд: \(gameManager.roundCount)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding()
        .background(Color.white.opacity(0.8))
        .cornerRadius(12)
    }
    
    private var statusText: String {
        switch gameManager.gameState {
            case .notStarted:
                return "Игра не начата"
            case .inProgress:
                return "Бой в процессе"
            case .playerWon:
                return "🎉 ПОБЕДА! 🎉"
            case .playerLost:
                return "💀 Поражение"
            case .gameOver:
                return "Игра окончена"
        }
    }
    
    private var statusColor: Color {
        switch gameManager.gameState {
            case .notStarted:
                return .gray
            case .inProgress:
                return .blue
            case .playerWon:
                return .green
            case .playerLost:
                return .red
            case .gameOver:
                return .gray
        }
    }
}

#Preview {
    VStack(spacing: 16) {
        GameStatusView(gameManager: GameManager())
        
        GameStatusView(gameManager: {
            let manager = GameManager()
            try! manager.startNewGame(playerName: "Тест", difficulty: .normal)
            return manager
        }())
    }
    .padding()
}
