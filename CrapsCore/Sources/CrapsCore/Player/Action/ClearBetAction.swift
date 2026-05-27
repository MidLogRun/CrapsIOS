//
//  ClearBetAction.swift
//  CrapsCore
//
//  Created by Matthew Long on 5/22/26.
//


public struct ClearBetAction: Action {
    let bet: Bet
    var player: Player

    init(bet: Bet, player: Player) {
        self.bet = bet
        self.player = player
    }

    public func execute(on: any ActionExecutor) {
        _ = player.clearBet(bet: bet)
    }

}

