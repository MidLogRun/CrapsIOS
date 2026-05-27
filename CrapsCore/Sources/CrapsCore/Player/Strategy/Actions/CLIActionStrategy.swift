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

    func printBets(player: Player){
        print("=====CURRENT BETS=====")
        for (index, bet) in player.listBets().enumerated() {
            print("\(index + 1)) BET \(bet.id)")
            print("   TYPE \(bet.type)")
            print("   AMOUNT \(bet.amount)")
            if let on = bet.on {
                print("   ON \(on)")
            }
        }
    }

    func decideBetToRemove(player: Player) -> Bet? {
        let bets = player.listBets()
        if bets.isEmpty {
            print("You have no bets to remove.")
            return nil
        }

        printBets(player: player)

        while true {
            print("Select a bet number to remove:")
            print("Choice: ", terminator: "")

            guard let line = readLine(),
                  let choice = Int(line),
                  choice >= 1,
                  choice <= bets.count else {
                print("Invalid bet selection.")
                continue
            }

            return bets[choice - 1]
        }
    }

    public mutating func getActionWithBalance(gameState: GameState, puck: Puck, player: Player) -> any Action {
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
                        balance: player.getBalance()
                    )

                    guard canMakeBet(bet: bet, gameState: gameState) else {
                        return RollAction()
                    }
                    return MakeBetAction(bet: bet, player: player)
                case "B":
                    guard let bet = decideBetToRemove(player: player) else {
                        continue
                    }
                    return ClearBetAction(bet: bet, player: player)
                case "C":
                    return RollAction()
                case "D":
                    print("Balance: \(player.getBalance())")
                case "E":
                    printBets(player: player)
                case "F":
                    print("Quitting game.")
                    return QuitAction()
                default:
                    print("invalid input")
            }
        }

    }


}
