//
//  SimpleActionStrategy.swift
//  CrapsCore
//
//  Created by Matthew Long on 5/18/26.
//


public struct SimpleActionStrategy: ActionStrategy {
    public let bettingStrategy: any BettingStrategy

    public init(bettingStrategy: any BettingStrategy) {
        self.bettingStrategy = bettingStrategy
    }

    public func getActionWithBalance(gameState: GameState, puck: Puck, balance: Int) -> any Action {
        let bet = bettingStrategy.makeBet(gameState: gameState, puck: puck, balance: balance)
        return BetAction(bet: bet)
    }


}
