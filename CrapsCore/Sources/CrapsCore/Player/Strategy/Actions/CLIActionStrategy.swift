    //
    //  CLIActionStrategy.swift
    //  CrapsCore
    //
    //  Created by Matthew Long on 5/18/26.
    //

public struct CLIActionStrategy: ActionStrategy {
    public let bettingStrategy: any BettingStrategy

    public init(bettingStrategy: any BettingStrategy) {
        self.bettingStrategy = bettingStrategy
    }

    func printOptionList(){
        print("=====ACTION MENU=====")
        print("A) Place a bet")
        print("B) Remove a bet")
        print("C) Roll")
        print("D) View balance")
        print("E) View bets")
        print("F) Quit")
    }

    func printBets(snapshot: PlayerSnapshot){
        print("=====CURRENT BETS=====")
        for (index, bet) in snapshot.bets.enumerated() {
            print("\(index + 1)) BET \(bet.id)")
            print("   TYPE \(bet.type)")
            print("   AMOUNT \(bet.amount)")
            if let on = bet.on {
                print("   ON \(on)")
            }
        }
    }

    func decideBetToRemove(snapshot: PlayerSnapshot) -> Bet? {
        if snapshot.bets.isEmpty {
            print("You have no bets to remove.")
            return nil
        }

        printBets(snapshot: snapshot)

        while true {
            print("Select a bet number to remove:")
            print("Choice: ", terminator: "")

            guard let line = readLine(),
                  let choice = Int(line),
                  choice >= 1,
                  choice <= snapshot.bets.count else {
                print("Invalid bet selection.")
                continue
            }

            return snapshot.bets[choice - 1]
        }
    }

    public mutating func getActionWithBalance(gameState: GameState, puck: Puck, snapshot: PlayerSnapshot) -> any Action {
        printOptionList()
        while true {
            print("Select an option:")
            print("Choice: ", terminator: "")
            guard let line = readLine()?.uppercased() else {
                print("Invalid input.")
                continue
            }

            switch line {
                case "A":
                    let bet = bettingStrategy.makeBet(
                        gameState: gameState,
                        puck: puck,
                        balance: snapshot.balance
                    )
                    return MakeBetAction(bet: bet)
                case "B":
                    guard let bet = decideBetToRemove(snapshot: snapshot) else {
                        continue
                    }
                    return ClearBetAction(bet: bet)
                case "C":
                    return RollAction()
                case "D":
                    print("Balance: \(snapshot.balance)")
                case "E":
                    printBets(snapshot: snapshot)
                case "F":
                    print("Quitting game.")
                    return QuitAction()
                default:
                    print("invalid input")
            }
        }

    }


}
