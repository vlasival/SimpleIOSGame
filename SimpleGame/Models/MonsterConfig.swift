import Foundation

struct MonsterConfig {
    let name: String
    let attack: Int
    let defense: Int
    let maxHealth: Int
    let damageMin: Int
    let damageMax: Int
    let icon: String
    
    init(name: String, attack: Int, defense: Int, maxHealth: Int, damageMin: Int, damageMax: Int, icon: String = "👹") {
        self.name = name
        self.attack = attack
        self.defense = defense
        self.maxHealth = maxHealth
        self.damageMin = damageMin
        self.damageMax = damageMax
        self.icon = icon
    }
    
    var damageRange: DamageRange {
        return try! DamageRange(min: damageMin, max: damageMax)
    }
}
