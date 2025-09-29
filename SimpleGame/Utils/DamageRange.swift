import Foundation

struct DamageRange {
    let min: Int
    let max: Int
    
    init(min: Int, max: Int) throws {
        guard min > 0 && min <= max else {
            throw GameError.invalidDamageRange(min: min, max: max)
        }
        self.min = min
        self.max = max
    }
    
    func randomDamage() -> Int {
        return Int.random(in: min...max)
    }
}
