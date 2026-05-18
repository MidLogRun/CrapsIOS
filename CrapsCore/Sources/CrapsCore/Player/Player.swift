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
    private var strategy: BettingStrategy

    public init(name: String, balance: Int, strategy: BettingStrategy) {
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
    public func makeBet(bet: Bet) -> Bool {
        if (subtractFromBalance(amount: bet.amount)){
            bets.append(bet)
            return true
        }
        return false
    }

    public func makeBet(gameState: GameState, puck: Puck) -> Bool {
        guard let bet = strategy.makeBet(
            gameState: gameState,
            puck: puck,
            balance: balance
        ) else {
            return false
        }

        return makeBet(bet: bet)
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
}
