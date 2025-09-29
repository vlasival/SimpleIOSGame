import Foundation

enum GameError: Error, LocalizedError {
    case invalidAttackValue(_ value: Int)
    case invalidDefenseValue(_ value: Int)
    case invalidHealthValue(_ value: Int)
    case invalidDamageRange(min: Int, max: Int)
    case creatureIsDead
    case attackOnDeadCreature
    
    var errorDescription: String? {
        switch self {
            case .invalidAttackValue(let value):
                return "Атака должна быть от 1 до 30, получено: \(value)"
            case .invalidDefenseValue(let value):
                return "Защита должна быть от 1 до 30, получено: \(value)"
            case .invalidHealthValue(let value):
                return "Здоровье должно быть натуральным числом, получено: \(value)"
            case .invalidDamageRange(let min, let max):
                return "Диапазон урона некорректен: min=\(min), max=\(max). Min должен быть > 0 и <= max"
            case .creatureIsDead:
                return "Существо мертво"
            case .attackOnDeadCreature:
                return "Нельзя атаковать мертвое существо"
        }
    }
}

enum PlayerError: Error, LocalizedError {
    case noHealsRemaining
    case invalidHealAmount(_ amount: Int)
    
    var errorDescription: String? {
        switch self {
            case .noHealsRemaining:
                return "У игрока не осталось исцелений"
            case .invalidHealAmount(let amount):
                return "Некорректное количество исцеления: \(amount)"
        }
    }
}
