//
//  Untitled.swift
//  CrapsCore
//
//  Created by Matthew Long on 5/17/26.
//


public struct DumbPassLineStrategy: BettingStrategy {

    public init() {}

    public func makeBet(gameState: GameState, puck: Puck, balance: Int) -> Bet {
         return .passLine(amount: balance)
    }
}
