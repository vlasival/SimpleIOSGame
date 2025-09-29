import Foundation

struct CombatLogEntry: Identifiable {
    let id = UUID()
    let timestamp: Date
    let attacker: String
    let target: String
    let action: String
    let result: String
    let damage: Int?
    
    init(attacker: String, target: String, action: String, result: String, damage: Int? = nil) {
        self.timestamp = Date()
        self.attacker = attacker
        self.target = target
        self.action = action
        self.result = result
        self.damage = damage
    }
}
