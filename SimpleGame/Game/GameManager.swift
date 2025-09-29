import Foundation
import Observation

@Observable
class GameManager {
    private(set) var player: Player?
    private(set) var currentMonster: Monster?
    private(set) var gameState: GameState = .notStarted
    private(set) var combatLog: [CombatLogEntry] = []
    private(set) var roundCount: Int = 0
    
    private(set) var totalMonsters: Int = 5
    private(set) var defeatedMonsters: Int = 0
    private(set) var currentBattleNumber: Int = 1
    private(set) var monstersQueue: [MonsterConfig] = []
    private(set) var difficulty: DifficultyConfiguration = DifficultyConfiguration(level: .normal)
    
    var battleProgress: Double {
        return Double(defeatedMonsters) / Double(totalMonsters)
    }
    
    var isLastBattle: Bool {
        return currentBattleNumber == totalMonsters
    }
    
    var battleStatusText: String {
        return "Бой \(currentBattleNumber)/\(totalMonsters)"
    }
    
    func startNewGame(playerName: String, difficulty: DifficultyLevel = .normal) throws {
        self.difficulty = DifficultyConfiguration(level: difficulty)
        
        let newPlayer = try Player(name: playerName, difficulty: self.difficulty)
        
        monstersQueue = generateMonsterQueue()
        
        let firstMonster = try Monster(config: monstersQueue[0])
        
        self.player = newPlayer
        self.currentMonster = firstMonster
        self.gameState = .inProgress
        self.combatLog.removeAll()
        self.roundCount = 0
        self.defeatedMonsters = 0
        self.currentBattleNumber = 1
        self.totalMonsters = self.difficulty.totalMonsters
        
        addLogEntry(
            attacker: "Система",
            target: "Игра",
            action: "Начало игры",
            result: "Игрок \(playerName) начинает серию из \(totalMonsters) боев! Сложность: \(difficulty.rawValue)"
        )
        
        addLogEntry(
            attacker: "Система",
            target: "Бой \(currentBattleNumber)",
            action: "Начало боя",
            result: "Противник: \(firstMonster.name)"
        )
    }
    
    private func generateMonsterQueue() -> [MonsterConfig] {
        var queue: [MonsterConfig] = []
        let availableConfigs = difficulty.getAllMonsterConfigs()
        
        queue.append(contentsOf: availableConfigs)
        
        while queue.count < totalMonsters {
            let randomConfig = availableConfigs.randomElement() ?? availableConfigs[0]
            queue.append(randomConfig)
        }
        
        return queue.shuffled()
    }
    
    func playerAttack() throws {
        guard let player = player, let monster = currentMonster else {
            throw GameError.creatureIsDead
        }
        
        guard gameState == .inProgress else {
            throw GameError.creatureIsDead
        }
        
        roundCount += 1
        
        do {
            let damage = try player.attack(target: monster)
            
            if damage > 0 {
                addLogEntry(
                    attacker: player.name,
                    target: monster.name,
                    action: "атакует",
                    result: "Попадание!",
                    damage: damage
                )
            } else {
                addLogEntry(
                    attacker: player.name,
                    target: monster.name,
                    action: "атакует",
                    result: "Промах!"
                )
            }
            
            checkGameState()
            
        } catch {
            addLogEntry(
                attacker: player.name,
                target: monster.name,
                action: "атакует",
                result: "Ошибка: \(error.localizedDescription)"
            )
            throw error
        }
    }
    
    func monsterAttack() throws {
        guard let player = player, let monster = currentMonster else {
            throw GameError.creatureIsDead
        }
        
        guard gameState == .inProgress else {
            throw GameError.creatureIsDead
        }
        
        do {
            let damage = try monster.attack(target: player)
            
            if damage > 0 {
                addLogEntry(
                    attacker: monster.name,
                    target: player.name,
                    action: "атакует",
                    result: "Попадание!",
                    damage: damage
                )
            } else {
                addLogEntry(
                    attacker: monster.name,
                    target: player.name,
                    action: "атакует",
                    result: "Промах!"
                )
            }
            
            checkGameState()
            
        } catch {
            addLogEntry(
                attacker: monster.name,
                target: player.name,
                action: "атакует",
                result: "Ошибка: \(error.localizedDescription)"
            )
            throw error
        }
    }
    
    func playerHeal() throws {
        guard let player = player else {
            throw GameError.creatureIsDead
        }
        
        guard gameState == .inProgress else {
            throw GameError.creatureIsDead
        }
        
        do {
            try player.healSelf()
            addLogEntry(
                attacker: player.name,
                target: player.name,
                action: "исцеляется",
                result: "Восстановлено здоровье! Осталось исцелений: \(player.healsRemaining)"
            )
        } catch {
            addLogEntry(
                attacker: player.name,
                target: player.name,
                action: "пытается исцелиться",
                result: "Ошибка: \(error.localizedDescription)"
            )
            throw error
        }
    }
    
    private func checkGameState() {
        guard let player = player, let monster = currentMonster else { return }
        
        if !player.isAlive {
            gameState = .playerLost
            addLogEntry(
                attacker: "Система",
                target: "Игра",
                action: "Конец игры",
                result: "Игрок погиб в бою \(currentBattleNumber)!"
            )
        } else if !monster.isAlive {
            defeatedMonsters += 1
            
            if defeatedMonsters >= totalMonsters {
                gameState = .playerWon
                addLogEntry(
                    attacker: "Система",
                    target: "Игра",
                    action: "ПОБЕДА!",
                    result: "Игрок победил всех \(totalMonsters) монстров! 🎉"
                )
            } else {
                spawnNextMonster()
            }
        }
    }
    
    private func spawnNextMonster() {
        currentBattleNumber += 1
        
        do {
            let nextMonsterConfig = monstersQueue[currentBattleNumber - 1]
            let nextMonster = try Monster(config: nextMonsterConfig)
            
            currentMonster = nextMonster
            
            addLogEntry(
                attacker: "Система",
                target: "Бой \(currentBattleNumber)",
                action: "Новый противник",
                result: "Противник: \(nextMonster.name) (Побеждено: \(defeatedMonsters)/\(totalMonsters))"
            )
            
        } catch {
            addLogEntry(
                attacker: "Система",
                target: "Ошибка",
                action: "Создание монстра",
                result: "Ошибка: \(error.localizedDescription)"
            )
        }
    }
    
    private func addLogEntry(attacker: String, target: String, action: String, result: String, damage: Int? = nil) {
        let entry = CombatLogEntry(
            attacker: attacker,
            target: target,
            action: action,
            result: result,
            damage: damage
        )
        combatLog.append(entry)
    }
    
    func resetGame() {
        player = nil
        currentMonster = nil
        gameState = .notStarted
        combatLog.removeAll()
        roundCount = 0
        defeatedMonsters = 0
        currentBattleNumber = 1
        monstersQueue.removeAll()
    }
    
    var canPlayerAct: Bool {
        return gameState == .inProgress && player?.isAlive == true
    }
    
    var canMonsterAct: Bool {
        return gameState == .inProgress && currentMonster?.isAlive == true
    }
}