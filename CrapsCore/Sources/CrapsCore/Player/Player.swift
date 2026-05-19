    //
    //  Player.swift
    //  Craps
    //
    //  Created by Matthew Long on 5/16/26.
    //


public class Player {
    let name: String
    private var balance: Int
    private var bets: [Bet]
    private var strategy: ActionStrategy

    public init(name: String, balance: Int, strategy: ActionStrategy) {
        self.name = name
        self.balance = balance
        self.bets = []
        self.strategy = strategy
    }

    public func clearBet(on: Int) {
        bets.removeAll { bet in
            if (bet.on == on) {
                self.balance += bet.amount
                return true
            }
            return false
        }
    }

    public var hasUnresolvedBets: Bool {
        return bets.contains(where: { $0.isActive })
    }

    private func subtractFromBalance(amount: Int) -> Bool {
        let balance = self.balance - amount
        if (balance < 0){
            print("Insufficient funds")
            return false
        }
        self.balance = balance
        return true
    }

    public func updateBalance(amount: Int){
        self.balance += amount
    }

    public func getBalance() -> Int {
        self.balance
    }

    func appendBet(bet: Bet) {
        bets.append(bet)
    }
        //Bets
    public func addBet(bet: Bet) -> Bool {
        if (subtractFromBalance(amount: bet.amount)){
            bets.append(bet)
            return true
        }
        return false
    }

    public func clearLastBet() -> Void {
        bets.popLast()
    }

    public func resolveBet(bet: Bet){
        guard let index = bets.firstIndex(where: {storedBet in
            storedBet.id == bet.id
        }) else {
            return
        }

        bets[index].isActive = false
    }

    public func listBets() -> [Bet] {
        return self.bets
    }

    public func decideAction(gameState: GameState, puck: Puck) -> Action {
        return strategy.getAction(gameState: gameState, puck: puck, balance: balance)
    }

    public var numBets: Int {
        self.bets.count
    }


}
