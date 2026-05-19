//
//  PlayerStrategy.swift
//  CrapsCore
//
//  Created by Matthew Long on 5/17/26.
//



public protocol BettingStrategy {
    func makeBet(gameState: GameState, puck: Puck, balance: Int) -> Bet
}
