//
//  GameState.swift
//  Craps
//
//  Created by Matthew Long on 5/14/26.
//


class GameState {
    var comeOutRoll: Bool
    var betMap: [Int: Int]

    init() {
        betMap = {
            2:0,
            3:0,
            4:0,
            5:0,
            6:0,
            7:0,
            8:0,
            9:0,
            10:0,
            11:0,
            12:0
        }

        comeOutRoll = true

    }

}
