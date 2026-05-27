//
//  ActionStrategy.swift
//  CrapsCore
//
//  Created by Matthew Long on 5/18/26.
//



public protocol ActionStrategy {
    var bettingStrategy: BettingStrategy { get }

    init(bettingStrategy: BettingStrategy)
    
    mutating func getAction(gameState: GameState, puck: Puck, player: Player) -> Action

    mutating func getActionWithBalance(gameState: GameState, puck: Puck, player: Player) -> Action

}

//Define canMakeBet here


extension ActionStrategy {

    func canMakeBet(bet: Bet, gameState: GameState) -> Bool {
        switch bet.type {
            case .passLine, .dontLine:
                return gameState.isComeOutRoll

            default:
                return true
        }
    }

    public mutating func getAction(gameState: GameState, puck: Puck, player: Player) -> Action {
        guard player.getBalance() > 0 else {
            return RollAction()
        }

        return getActionWithBalance(
            gameState: gameState,
            puck: puck,
            player: player
        )
    }
}
