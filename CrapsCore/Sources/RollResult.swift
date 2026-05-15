//
//  RollResult.swift
//  Craps
//
//  Created by Matthew Long on 5/14/26.
//


struct RollResult {
    let left: Int
    let right: Int

    var total: Int {
        left + right
    }

    var isCrap: Bool {
        [2,3,12].contains(total)
    }

    var isNatural: Bool {
        [7,11].contains(total)
    }

    var isPoint: Bool {
        [4,5,6,8,9,10].contains(total)
    }

    var isHard: Bool {
        left == right
    }

}
