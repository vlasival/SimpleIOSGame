import Foundation
import Observation

protocol CreatureProtocol: AnyObject {
    var name: String { get }
    var attack: Int { get }
    var defense: Int { get }
    var currentHealth: Int { get }
    var maxHealth: Int { get }
    var damageRange: DamageRange { get }
    var isAlive: Bool { get }
    
    func takeDamage(_ damage: Int) throws
    func attack(target: CreatureProtocol) throws -> Int
}

@Observable
class Creature: CreatureProtocol {
    let name: String
    private(set) var attack: Int
    private(set) var defense: Int
    var currentHealth: Int
    let maxHealth: Int
    let damageRange: DamageRange
    
    var isAlive: Bool {
        return currentHealth > 0
    }
    
    init(name: String, attack: Int, defense: Int, maxHealth: Int, damageRange: DamageRange) throws {
        guard attack >= 1 && attack <= 30 else {
            throw GameError.invalidAttackValue(attack)
        }
        
        guard defense >= 1 && defense <= 30 else {
            throw GameError.invalidDefenseValue(defense)
        }
        
        guard maxHealth > 0 else {
            throw GameError.invalidHealthValue(maxHealth)
        }
        
        self.name = name
        self.attack = attack
        self.defense = defense
        self.maxHealth = maxHealth
        self.currentHealth = maxHealth
        self.damageRange = damageRange
    }
    
    func takeDamage(_ damage: Int) throws {
        guard isAlive else {
            throw GameError.creatureIsDead
        }
        
        guard damage >= 0 else {
            throw GameError.invalidHealthValue(damage)
        }
        
        currentHealth = max(0, currentHealth - damage)
    }
    
    func heal(_ amount: Int) throws {
        guard isAlive else {
            throw GameError.creatureIsDead
        }
        
        guard amount >= 0 else {
            throw GameError.invalidHealthValue(amount)
        }
        
        currentHealth = min(maxHealth, currentHealth + amount)
    }
    
    func attack(target: CreatureProtocol) throws -> Int {
        guard isAlive else {
            throw GameError.creatureIsDead
        }
        
        guard target.isAlive else {
            throw GameError.attackOnDeadCreature
        }
        
        let attackModifier = max(1, attack - target.defense + 1)
        
        let diceRolls = Dice.rollMultiple(count: attackModifier)
        
        let isSuccessful = diceRolls.contains { $0 >= 5 }
        
        if isSuccessful {
            let damage = damageRange.randomDamage()
            try target.takeDamage(damage)
            return damage
        }
        
        return 0
    }
}
