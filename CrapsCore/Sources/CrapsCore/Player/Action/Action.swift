//
//  Action.swift
//  CrapsCore
//
//  Created by Matthew Long on 5/18/26.
//


//Command pattern

//enum ActionType {
//    case bet
//    case listBets
//    case clearBet
//    case pressBet
//    case roll
//    case quit
//}

public protocol Action {
    func execute(on: ActionExecutor) -> Void
}
