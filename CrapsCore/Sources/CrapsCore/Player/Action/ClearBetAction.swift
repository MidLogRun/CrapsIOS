//
//  ClearBetAction.swift
//  CrapsCore
//
//  Created by Matthew Long on 5/22/26.
//


public struct ClearBetAction: Action {
    let bet: Bet

    init(bet: Bet) {
        self.bet = bet
    }

    public func execute(on: any ActionExecutor) {
        _ = on.clearBet(bet: bet)
    }

}

