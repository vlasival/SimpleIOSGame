import SwiftUI

// MARK: - Main Game View
// Главный экран игры, который координирует все остальные компоненты
// Управляет переключением между экранами и основной навигацией
// Использует расширяемую архитектуру с enum состояний
struct GameView: View {
    @Bindable var gameManager: GameManager
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @State private var playerName = ""
    @State private var currentScreen: AppScreens = .nameInput
    @State private var selectedDifficulty: DifficultyLevel = .normal
    
    var body: some View {
        NavigationView {
            ZStack {
                // MARK: - Background
                // Градиентный фон для всего приложения
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.1), Color.purple.opacity(0.1)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                // MARK: - Screen Router
                // Расширяемое переключение между экранами
                switch currentScreen {
                    case .nameInput:
                        // Экран ввода имени и выбора сложности
                        NameInputView(
                            playerName: $playerName,
                            selectedDifficulty: $selectedDifficulty
                        ) {
                            startGame()
                        }
                        
                    case .game:
                        // Основной игровой экран
                        GameScreenView(gameManager: gameManager) { message in
                            showAlert(message)
                        }
                }
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Новая игра") {
                        resetGame()
                    }
                    .disabled(gameManager.gameState == .inProgress)
                }
            }
        }
        .alert("Игра", isPresented: $showingAlert) {
            Button("OK") { }
        } message: {
            Text(alertMessage)
        }
    }
    
    // MARK: - Game Actions
    // Методы для управления игровым процессом
    
    private func startGame() {
        do {
            try gameManager.startNewGame(playerName: playerName, difficulty: selectedDifficulty)
            currentScreen = .game
        } catch {
            showAlert("Ошибка создания игры: \(error.localizedDescription)")
        }
    }
    
    private func resetGame() {
        gameManager.resetGame()
        playerName = ""
        currentScreen = .nameInput
    }
    
    private func showAlert(_ message: String) {
        alertMessage = message
        showingAlert = true
    }
}

// MARK: - Preview
// Предварительный просмотр для разработки

#Preview {
    GameView(gameManager: GameManager())
}
