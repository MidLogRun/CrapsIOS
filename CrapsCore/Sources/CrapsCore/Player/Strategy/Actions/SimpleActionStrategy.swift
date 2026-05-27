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

    public mutating func getActionWithBalance(gameState: GameState, puck: Puck, player: Player) -> any Action {
        let bet = bettingStrategy.makeBet(gameState: gameState, puck: puck, balance: player.getBalance())

        guard canMakeBet(bet: bet, gameState: gameState) else {
            return RollAction()
        }
        return MakeBetAction(bet: bet, player: player)
    }


}
