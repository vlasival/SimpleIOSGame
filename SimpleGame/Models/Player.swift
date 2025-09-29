import Foundation
import Observation

@Observable
class Player: Creature {
    private let maxHeals: Int
    var healsRemaining: Int
    
    init(name: String, attack: Int, defense: Int, maxHealth: Int, damageRange: DamageRange, maxHeals: Int = 4) throws {
        self.maxHeals = maxHeals
        self.healsRemaining = maxHeals
        try super.init(name: name, attack: attack, defense: defense, maxHealth: maxHealth, damageRange: damageRange)
    }
    
    convenience init(name: String, difficulty: DifficultyConfiguration) throws {
        let baseStats = (attack: 15, defense: 10, maxHealth: 100)
        let modifiedStats = difficulty.applyPlayerModifiers(baseStats: baseStats)
        let damageRange = try DamageRange(min: 2, max: 8)
        
        try self.init(
            name: name,
            attack: modifiedStats.attack,
            defense: modifiedStats.defense,
            maxHealth: modifiedStats.maxHealth,
            damageRange: damageRange,
            maxHeals: difficulty.playerHealsCount
        )
    }
    
    override init(name: String, attack: Int, defense: Int, maxHealth: Int, damageRange: DamageRange) throws {
        self.maxHeals = 4
        self.healsRemaining = 4
        try super.init(name: name, attack: attack, defense: defense, maxHealth: maxHealth, damageRange: damageRange)
    }
    
    func healSelf() throws {
        guard isAlive else {
            throw GameError.creatureIsDead
        }
        
        guard healsRemaining > 0 else {
            throw PlayerError.noHealsRemaining
        }
        
        let healAmount = Int(Double(maxHealth) * 0.3)
        
        guard healAmount > 0 else {
            throw PlayerError.invalidHealAmount(healAmount)
        }
        
        try heal(healAmount)
        healsRemaining -= 1
    }
    
    var healPercentage: Double {
        return Double(healsRemaining) / Double(maxHeals) * 100
    }
    
    var canHeal: Bool {
        return isAlive && healsRemaining > 0
    }
}
