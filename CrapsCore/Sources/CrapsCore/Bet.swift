//
//  Bets.swift
//  Craps
//
//  Created by Matthew Long on 5/16/26.
//

import Foundation

enum BetType: String {
    case passLine = "Pass Line"
    case dontLine = "Don't Pass Bar"
    case come = "Come"
    case field = "Field"
    case place = "Place"
    case buy = "Buy"
    case lay = "Lay"
    case lowHorn = "Low Horn" //3 and 11
    case highHorn = "High Horn" //2 and 12
}

enum BetOutcome {
    case win
    case lose
    case noAction
}

//Static factory methods
public struct Bet: Equatable {
    public let id: UUID
    public var on: Int?
    public let amount: Int
    public var isActive: Bool
    let type: BetType


    init (type: BetType, amount: Int, isActive: Bool){
        self.id = UUID()
        self.type = type
        self.amount = amount
        self.isActive = isActive
        self.on = nil
    }

    init (on: Int, amount: Int, isActive: Bool){
        self.id = UUID()
        self.type = .place
        self.amount = amount
        self.on = on
        self.isActive = isActive
    }

    public func changeComeToPoint(bet: Bet, point: Int) -> Bet {
        var newBet = bet
        newBet.on = point
        return newBet
    }

    public static func passLine( amount: Int) -> Bet {
        Bet(type: BetType.passLine, amount: amount, isActive: true)
    }

    public static func dontLine( amount: Int) -> Bet {
        Bet(type: BetType.dontLine, amount: amount, isActive: true)
    }

    public static func comeBet(amount: Int) -> Bet {
        Bet(type: BetType.come, amount: amount, isActive: true)
    }

    public static func placeBet( amount: Int, on: Int) -> Bet {
        Bet(on: on, amount: amount, isActive: true)
    }

    public static func fieldBet( amount: Int) -> Bet {
        Bet(type: .field, amount: amount, isActive: true)
    }

    public static func lowHornBet( amount: Int) -> Bet {
        Bet(type: .lowHorn, amount: amount, isActive: true)
    }

    public  static func highHornBet( amount: Int) -> Bet {
        Bet(type: .highHorn, amount: amount, isActive: true)
    }


    var payoutMultiplier: Float {
        switch type {
            case .passLine:
                return 1.0
            case .dontLine:
                return 1.0
            case .come:
                return 1.0
            case .field:
                return 1.0
            case .place:
                switch on! {
                    case 4, 10:
                        return 1.8
                    case 5, 9:
                        return 1.4
                    case 6, 8:
                        return 7.0 / 6.0
                    default:
                        return 0.0
                }
            case .buy, .lay:
                switch on! {
                    case 4, 10:
                        return 2.0
                    case 5, 9:
                        return 3 / 2.0
                    case 6, 8:
                        return 6.0 / 5.0
                    default:
                        return 0.0
                }
            default:
                return 1.0
        }
    }

    var winnings: Int {
        Int(self.payoutMultiplier * Float(self.amount))
    }

    var payout: Int {
        self.amount + self.winnings
    }

}



