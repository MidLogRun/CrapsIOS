//
//  ActionStrategy.swift
//  CrapsCore
//
//  Created by Matthew Long on 5/18/26.
//



public protocol ActionStrategy {
    var bettingStrategy: BettingStrategy { get }

    init(bettingStrategy: BettingStrategy)
    
    mutating func getAction(gameState: GameState, puck: Puck, snapshot: PlayerSnapshot) -> Action

    mutating func getActionWithBalance(gameState: GameState, puck: Puck, snapshot: PlayerSnapshot) -> Action

}

extension ActionStrategy {
    public mutating func getAction(gameState: GameState, puck: Puck, snapshot: PlayerSnapshot) -> Action {
        guard snapshot.balance > 0 else {
            return RollAction()
        }

        return getActionWithBalance(
            gameState: gameState,
            puck: puck,
            snapshot: snapshot
        )
    }
}
