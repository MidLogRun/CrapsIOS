public struct CLIStrategy: BettingStrategy {

    public init() {}

    private func printDivider() {
        print("────────────────────────────────")
    }

    private func printHeader(_ title: String) {
        print()
        printDivider()
        print(" \(title)")
        printDivider()
    }

    func waitForEnter(prompt: String = "Press Enter to continue..."){
        print()
        print(prompt, terminator: "")
        _ = readLine()
    }
    func printBetOptions(_ puck: Puck, _ balance: Int) {
        printHeader("Select Bet Type")

        print("Balance: $\(balance)")
        print("Puck:    \(puck.isOn ? "ON" : "OFF")")
        print("Point:   \(puck.point.map(String.init) ?? "none")")
        print()

        if !puck.isOn {
            print("  A) Pass Line")
            print("  B) Don't Pass Line")
            print("  D) Place")
            print("  E) Lay")
            print("  F) Buy")
            print("  G) Low Horn")
            print("  H) High Horn")
        } else {
            print("  C) Come")
            print("  D) Place")
            print("  E) Lay")
            print("  F) Buy")
            print("  G) Low Horn")
            print("  H) High Horn")
        }

        print("  Q) No bet")
        print()
    }

    func printPlaceOptions() {
        print()
        print("Valid point numbers:")
        print("  4, 5, 6, 8, 9, 10")
        print()
    }

    func askForValidInt(prompt: String, isValid: (Int) -> Bool) -> Int {
        while true {
            print(prompt, terminator: "")

            if let line = readLine(),
               let value = Int(line),
               isValid(value) {
                return value
            }

            print("Invalid input. Try again.")
        }
    }



    func handlePlaceLayBuy(type: BetType) -> Bet {
        let validPoints = [4, 5, 6, 8, 9, 10]

        printHeader("\(type.rawValue) Bet")
        printPlaceOptions()

        let selectedPoint = askForValidInt(
            prompt: "Point number: "
        ) { value in
            validPoints.contains(value)
        }

        let amount = askForValidInt(
            prompt: "Bet amount: $"
        ) { value in
            value > 0
        }

        return Bet.placeBet(amount: amount, on: selectedPoint)

//        switch type {
//            case .place:
//                return Bet.placeBet(amount: amount, on: selectedPoint)
//            case .buy:
//                return Bet.placeBet(amount: amount, on: selectedPoint)
//            case .lay:
//                return Bet.placeBet(amount: amount, on: selectedPoint)
//            default:
//                return Bet.placeBet(amount: amount, on: selectedPoint)
//        }
    }

    func determineBet(_ gameState: GameState, _ puck: Puck, _ balance: Int) -> Bet? {
        guard balance > 0 else {
            printHeader("No Available Bets")
            print("You have insufficient funds to bet.")
            waitForEnter()
            return nil

        }
        printBetOptions(puck, balance)

        while true {
            print("Choice: ", terminator: "")

            guard let line = readLine()?.uppercased() else {
                print("Invalid input.")
                continue
            }

            switch line {
                case "A":
                    printHeader("Pass Line Bet")
                    let amount = askForValidInt(prompt: "Bet amount: $") { $0 > 0 }
                    return Bet.passLine(amount: amount)

                case "B":
                    printHeader("Don't Pass Line Bet")
                    let amount = askForValidInt(prompt: "Bet amount: $") { $0 > 0 }
                    return Bet.dontLine(amount: amount)

                case "C":
                    printHeader("Come Bet")
                    let amount = askForValidInt(prompt: "Bet amount: $") { $0 > 0 }
                    return Bet.comeBet(amount: amount)

                case "D":
                    return handlePlaceLayBuy(type: .place)

                case "E":
                    return handlePlaceLayBuy(type: .lay)

                case "F":
                    return handlePlaceLayBuy(type: .buy)

                case "G":
                    printHeader("Low Horn Bet")
                    let amount = askForValidInt(prompt: "Bet amount: $") { $0 > 0 }
                    return Bet.lowHornBet(amount: amount)

                case "H":
                    printHeader("High Horn Bet")
                    let amount = askForValidInt(prompt: "Bet amount: $") { $0 > 0 }
                    return Bet.highHornBet(amount: amount)

                case "Q":
                    print()
                    print("No bet placed.")
                    return nil

                default:
                    print("Invalid choice. Enter one of the listed letters.")
            }
        }
    }

    public func makeBet(gameState: GameState, puck: Puck, balance: Int) -> Bet? {
        determineBet(gameState, puck, balance)
    }
}
