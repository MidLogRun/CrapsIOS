//
//  GameState.swift
//  Craps
//
//  Created by Matthew Long on 5/14/26.
//


public class GameState {
   private var rollHistory: [RollResult]
    private var balance: Int

   public init() {
        self.rollHistory = []
        balance = 0
    }

    public init(balance: Int){
        self.rollHistory = []
        self.balance = balance
    }

    public func updateRollHistory(roll: RollResult) -> Void {
        self.rollHistory.append(roll)
    }

    public func getRollHistory() -> [RollResult]{
        return self.rollHistory
    }

    public func getRollHistoryTotals() -> [Int]{
        var totals: [Int] = []
        for i in self.rollHistory {
            totals.append(i.total)
        }
        return totals
    }

    public func updateBalance(amount: Int) -> Void {
        self.balance += amount
    }

    public func getBalance() -> Int {
        self.balance
    }

}
