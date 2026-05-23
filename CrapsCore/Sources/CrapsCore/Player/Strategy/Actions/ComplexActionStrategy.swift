//
//  ComplexActionStrategy.swift
//  CrapsCore
//
//  Created by Matthew Long on 5/20/26.
//

public struct ComplexActionStrategy: ActionStrategy {
    public let bettingStrategy: any BettingStrategy

    private let minimumBet: Int  = 5 //TODO Instead of betting every turn, play sporadically?

    public init(bettingStrategy: any BettingStrategy) {
        self.bettingStrategy = bettingStrategy
    }



    public mutating func getActionWithBalance(gameState: GameState, puck: Puck, snapshot: PlayerSnapshot) -> any Action {
        return RollAction()//TODO
    }



}
