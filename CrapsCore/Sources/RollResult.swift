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

    var possibleBets: [BetType] {
        switch total {
            case 2:
                return [.dontLine, .field, .highHorn]
            case 3:
                return [.dontLine, .field, .lowHorn]
            case 4:
                return [.come, .field, .place, .buy, .lay]
            case 5, 6, 8:
                return [.come, .place, .buy, .lay]
            case 7:
                return [.passLine, .come]
            case 9, 10:
                return [.come, .place, .buy, .lay, .field]
            case 11:
                return [.passLine, .come, .field, .lowHorn]
            case 12:
                return [.dontLine, .field, .highHorn]
            default:
                return []
        }
    }



}
