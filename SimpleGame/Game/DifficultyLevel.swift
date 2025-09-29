import Foundation

enum DifficultyLevel: String, CaseIterable {
    case easy = "Легкий"
    case normal = "Обычный"
    case hard = "Сложный"
    
    var description: String {
        switch self {
            case .easy:
                return "Подходит для новичков."
            case .normal:
                return "Сбалансированная сложность."
            case .hard:
                return "Для опытных игроков."
        }
    }
    
    var icon: String {
        switch self {
            case .easy:
                return "🟢"
            case .normal:
                return "🟡"
            case .hard:
                return "🔴"
        }
    }
}

struct DifficultyConfiguration {
    let level: DifficultyLevel
    
    var monsterConfigs: [MonsterConfig] {
        switch level {
            case .easy:
                return [
                    MonsterConfig(
                        name: "Гоблин", 
                        attack: 6, defense: 4, 
                        maxHealth: 15, 
                        damageMin: 1, 
                        damageMax: 3, 
                        icon: "👹"
                    ),
                    MonsterConfig(
                        name: "Орк", 
                        attack: 8, 
                        defense: 6, 
                        maxHealth: 25, 
                        damageMin: 1, 
                        damageMax: 4, 
                        icon: "👹"
                    ),
                    MonsterConfig(
                        name: "Тролль", 
                        attack: 10, 
                        defense: 8, 
                        maxHealth: 35, 
                        damageMin: 2, 
                        damageMax: 5, 
                        icon: "👹"
                    )
                ]
            case .normal:
                return [
                    MonsterConfig(
                        name: "Гоблин", 
                        attack: 7, 
                        defense: 4, 
                        maxHealth: 18, 
                        damageMin: 1, 
                        damageMax: 3, 
                        icon: "👹"
                    ),
                    MonsterConfig(
                        name: "Орк", 
                        attack: 10, 
                        defense: 6, 
                        maxHealth: 28, 
                        damageMin: 2, 
                        damageMax: 5, 
                        icon: "👹"
                    ),
                    MonsterConfig(
                        name: "Тролль", 
                        attack: 12, 
                        defense: 9, 
                        maxHealth: 40, 
                        damageMin: 2, 
                        damageMax: 6, 
                        icon: "👹"
                    ),
                    MonsterConfig(
                        name: "Дракон", 
                        attack: 16, 
                        defense: 12, 
                        maxHealth: 60, 
                        damageMin: 4, 
                        damageMax: 9, 
                        icon: "🐉"
                    )
                ]
            case .hard:
                return [
                    MonsterConfig(
                        name: "Вожак Орков", 
                        attack: 13, 
                        defense: 9, 
                        maxHealth: 40, 
                        damageMin: 2, 
                        damageMax: 6, 
                        icon: "👹"
                    ),
                    MonsterConfig(
                        name: "Древний Тролль", 
                        attack: 16, 
                        defense: 12, 
                        maxHealth: 55, 
                        damageMin: 3, 
                        damageMax: 8, 
                        icon: "👹"
                    ),
                    MonsterConfig(
                        name: "Старый Дракон", 
                        attack: 20, 
                        defense: 15, 
                        maxHealth: 75, 
                        damageMin: 4, 
                        damageMax: 11, 
                        icon: "🐉"
                    ),
                    MonsterConfig(
                        name: "Демон", 
                        attack: 22, 
                        defense: 18, 
                        maxHealth: 85, 
                        damageMin: 5, 
                        damageMax: 12, 
                        icon: "👹"
                    ),
                    MonsterConfig(
                        name: "Лорд Тьмы", 
                        attack: 25, 
                        defense: 20, 
                        maxHealth: 100, 
                        damageMin: 6, 
                        damageMax: 14, 
                        icon: "👹"
                    ),
                    MonsterConfig(
                        name: "Король Лич", 
                        attack: 20, 
                        defense: 16, 
                        maxHealth: 70, 
                        damageMin: 4, 
                        damageMax: 10, 
                        icon: "💀"
                    ),
                    MonsterConfig(
                        name: "Архидемон", 
                        attack: 24, 
                        defense: 19, 
                        maxHealth: 95, 
                        damageMin: 5, 
                        damageMax: 13, 
                        icon: "👹"
                    )
                ]
        }
    }
    
    var playerAttackBonus: Int {
        switch level {
            case .easy: return 2
            case .normal: return 0
            case .hard: return -1
        }
    }
    
    var playerDefenseBonus: Int {
        switch level {
            case .easy: return 2
            case .normal: return 0
            case .hard: return -1
        }
    }
    
    var playerHealthBonus: Int {
        switch level {
            case .easy: return 20
            case .normal: return 0
            case .hard: return -10
        }
    }
    
    var totalMonsters: Int {
        switch level {
            case .easy: return 3
            case .normal: return 5
            case .hard: return 7
        }
    }
    
    var playerHealsCount: Int {
        switch level {
            case .easy: return 4
            case .normal: return 4
            case .hard: return 4
        }
    }
    
    func applyPlayerModifiers(baseStats: (attack: Int, defense: Int, maxHealth: Int)) -> (attack: Int, defense: Int, maxHealth: Int) {
        let modifiedAttack = max(1, min(30, baseStats.attack + playerAttackBonus))
        let modifiedDefense = max(1, min(30, baseStats.defense + playerDefenseBonus))
        let modifiedHealth = max(20, baseStats.maxHealth + playerHealthBonus)
        
        return (attack: modifiedAttack, defense: modifiedDefense, maxHealth: modifiedHealth)
    }
    
    func getRandomMonsterConfig() -> MonsterConfig {
        return monsterConfigs.randomElement() ?? monsterConfigs[0]
    }
    
    func getAllMonsterConfigs() -> [MonsterConfig] {
        return monsterConfigs
    }
}
