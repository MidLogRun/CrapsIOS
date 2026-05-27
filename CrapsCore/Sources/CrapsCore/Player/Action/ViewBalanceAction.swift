//
//  ViewBalanceAction.swift
//  CrapsCore
//
//  Created by Matthew Long on 5/22/26.
//



public struct ViewBalanceAction: Action {
    let balance: Int

    init(player: Player){
        self.balance = player.getBalance()
    }

    public func execute(on: any ActionExecutor) {
        print("Player balance is: ", balance)
    }

}
