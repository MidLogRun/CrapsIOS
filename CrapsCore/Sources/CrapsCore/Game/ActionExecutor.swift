//
//  ActionExecutor.swift
//  CrapsCore
//
//  Created by Matthew Long on 5/18/26.
//

public protocol ActionExecutor{
    func makeBet(bet: Bet) -> Bool
    func clearBets() -> Bool
    func clearBet(bet: Bet) -> Bool
    func listBets()
    func roll() -> RollResult
    func quit()
}
