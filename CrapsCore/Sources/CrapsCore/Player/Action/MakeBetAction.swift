//
//  BetAction.swift
//  CrapsCore
//
//  Created by Matthew Long on 5/18/26.
//



public struct MakeBetAction: Action {
    let bet: Bet
    var player: Player

    public init(bet: Bet, player: Player) {
        self.bet = bet
        self.player = player
    }

    public func execute(on: ActionExecutor) {
        _ = player.makeBet(bet: bet)
    }
}
