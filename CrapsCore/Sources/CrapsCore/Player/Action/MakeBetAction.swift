//
//  BetAction.swift
//  CrapsCore
//
//  Created by Matthew Long on 5/18/26.
//



public struct MakeBetAction: Action {
    let bet: Bet

    init(bet: Bet) {
        self.bet = bet
    }

    public func execute(on: ActionExecutor) {
        _ = on.makeBet(bet: bet)
    }
}
