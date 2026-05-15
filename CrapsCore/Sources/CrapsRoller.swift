//
//  CrapsDice.swift
//  Craps
//
//  Created by Matthew Long on 5/14/26.
//

struct CrapsRoller {
    static func roll() -> RollResult {
        RollResult(left: Int.random(in: 1...6), right: Int.random(in:1...6))
    }


}


