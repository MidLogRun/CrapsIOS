//
//  BetAction.swift
//  CrapsCore
//
//  Created by Matthew Long on 5/18/26.
//



public struct BetAction: Action {
    let bet: Bet

    init(bet: Bet) {
        self.bet = bet
    }

    public func execute(on: ActionExecutor) {
        let betStatus = on.makeBet(bet: bet)
//        print("bet \(bet.type) placed with amount \(bet.amount)")
    }
}
