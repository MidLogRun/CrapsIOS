    //
    //  BankrollAwarePassLineStrategy.swift
    //  CrapsCore
    //
    //  Created by Matthew Long on 5/17/26.
    //


public struct BankrollAwarePassLineStrategy: BettingStrategy {
    let maxPercent: Double
    public init(maxPercent: Double) {
        self.maxPercent = maxPercent
    }

    public func makeBet(gameState: GameState, puck: Puck, balance: Int) -> Bet? {
        guard !puck.isOn else {
            return nil
        }

        guard balance > 0 else {
            return nil
        }

        let amount = max(1, Int(Double(balance) * maxPercent))
        return Bet.passLine(amount: amount)
    }
}
