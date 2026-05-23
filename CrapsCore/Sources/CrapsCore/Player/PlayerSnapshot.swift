//
//  PlayerSnapshot.swift
//  CrapsCore
//
//  Created by Matthew Long on 5/22/26.
//

public struct PlayerSnapshot {
    let balance: Int
    let bets: [Bet]

    init(balance: Int, bets: [Bet]){
        self.balance = balance
        self.bets = bets
    }
}
