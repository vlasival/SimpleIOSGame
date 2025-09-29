import Foundation

// MARK: - App Screen States
// Enum для управления состояниями экранов приложения
// Легко расширяется для добавления новых экранов
enum AppScreens: CaseIterable {
    case nameInput
    case game
    
    var title: String {
        switch self {
            case .nameInput:
                return "Ввод имени"
            case .game:
                return "Игра"
        }
    }
    
    var icon: String {
        switch self {
            case .nameInput:
                return "person.circle"
            case .game:
                return "gamecontroller"
        }
    }
}
