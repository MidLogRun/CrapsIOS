//
//  ActionStrategy.swift
//  CrapsCore
//
//  Created by Matthew Long on 5/18/26.
//



public protocol ActionStrategy {
    var bettingStrategy: BettingStrategy { get }

    init(bettingStrategy: BettingStrategy)
    
    func getAction(gameState: GameState, puck: Puck, balance: Int) -> Action

    func getActionWithBalance(gameState: GameState, puck: Puck, balance: Int) -> Action

}

extension ActionStrategy {
    public func getAction(gameState: GameState, puck: Puck, balance: Int) -> Action {
        guard balance > 0 else {
            return RollAction()
        }

        return getActionWithBalance(gameState: gameState, puck: puck, balance: balance)
    }
}
