import Foundation

enum MonsterType: String, CaseIterable {
    case goblin = "Гоблин"
    case orc = "Орк"
    case troll = "Тролль"
    case dragon = "Дракон"
    
    var baseStats: (attack: Int, defense: Int, maxHealth: Int, damageRange: DamageRange) {
        switch self {
            case .goblin:
                return (attack: 8, defense: 5, maxHealth: 20, damageRange: try! DamageRange(min: 1, max: 4))
            case .orc:
                return (attack: 12, defense: 8, maxHealth: 35, damageRange: try! DamageRange(min: 2, max: 6))
            case .troll:
                return (attack: 15, defense: 12, maxHealth: 50, damageRange: try! DamageRange(min: 3, max: 8))
            case .dragon:
                return (attack: 20, defense: 15, maxHealth: 80, damageRange: try! DamageRange(min: 5, max: 12))
        }
    }
}

class Monster: Creature {
    let type: MonsterType?
    let config: MonsterConfig?
    
    init(config: MonsterConfig) throws {
        self.type = nil
        self.config = config
        
        try super.init(
            name: config.name,
            attack: config.attack,
            defense: config.defense,
            maxHealth: config.maxHealth,
            damageRange: config.damageRange
        )
    }
    
    init(type: MonsterType, difficulty: DifficultyConfiguration) throws {
        self.type = type
        self.config = nil
        let stats = type.baseStats
        
        try super.init(
            name: type.rawValue,
            attack: stats.attack,
            defense: stats.defense,
            maxHealth: stats.maxHealth,
            damageRange: stats.damageRange
        )
    }
    
    init(type: MonsterType) throws {
        self.type = type
        self.config = nil
        let stats = type.baseStats
        
        try super.init(
            name: type.rawValue,
            attack: stats.attack,
            defense: stats.defense,
            maxHealth: stats.maxHealth,
            damageRange: stats.damageRange
        )
    }
    
    static func createRandom(difficulty: DifficultyConfiguration) throws -> Monster {
        let monsterConfig = difficulty.getRandomMonsterConfig()
        return try Monster(config: monsterConfig)
    }
    
    static func createRandom() throws -> Monster {
        let randomType = MonsterType.allCases.randomElement() ?? .goblin
        return try Monster(type: randomType)
    }
    
    static func createWeak() throws -> Monster {
        return try Monster(type: .goblin)
    }
    
    static func createStrong() throws -> Monster {
        return try Monster(type: .dragon)
    }
    
    var monsterIcon: String {
        return config?.icon ?? "👹"
    }
    
    var isFromConfig: Bool {
        return config != nil
    }
}
