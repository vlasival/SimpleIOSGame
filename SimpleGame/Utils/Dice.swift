import Foundation

struct Dice {
    static func roll() -> Int {
        return Int.random(in: 1...6)
    }
    
    static func rollMultiple(count: Int) -> [Int] {
        return (0..<count).map { _ in roll() }
    }
}
