    //
    //  Player.swift
    //  Craps
    //
    //  Created by Matthew Long on 5/16/26.
    //


class Player {
    let name: String
    private var balance: Int
    private var bets: [Bet]

    init(name: String, balance: Int) {
        self.name = name
        self.balance = balance
        self.bets = []
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

    //Bets
    public func makeBet(bet: Bet) -> Bool{
        if (subtractFromBalance(amount: bet.amount)){
            bets.append(bet)
            return true
        }
        return false
    }

    public func listBets() -> [Bet] {
        return self.bets
    }
}
