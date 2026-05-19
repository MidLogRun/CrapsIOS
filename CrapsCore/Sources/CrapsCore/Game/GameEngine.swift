    //
    //  GameEngine.swift
    //  Craps
    //
    //  Created by Matthew Long on 5/16/26.
    //

    //One player craps
public class GameEngine: ActionExecutor {

    var puck: Puck
    private let player: Player
    private let gameState: GameState

    public init (puck: Puck, player: Player, gameState: GameState){
        self.puck = puck
        self.player = player
        self.gameState = gameState
    }

    public func clearBets() -> Bool {
        return true
    }

    public func clearBet(bet: Bet) -> Bool {
        return true
    }

    public func listBets() {
        print("Player has \(player.numBets) bets")
    }

    public func roll() -> RollResult {
        //TODO delete the following line:
        listBets()

        let roll = CrapsRoller.roll()
        print("ROLL IS ------------> \(roll.total)")
        self.gameState.updateRollHistory(roll: roll)
        self.payout(result: roll)
        puck.flip(roll: roll.total)
        return roll
    }

    public func roll(roll: RollResult) -> Void {
        print("ROLL IS ------------> \(roll.total)")
        self.gameState.updateRollHistory(roll: roll)

        self.payout(result: roll)
        puck.flip(roll: roll.total)
    }

    public func quit() {
        print("Quitting!")
    }

    func betOutcome(bet: Bet, result: RollResult) -> BetOutcome {
        switch bet.type {
            case .passLine:
                return passLineOutcome(result: result)
            case .dontLine:
                return dontLineOutcome(result: result)
            case .come:
                return comeOutcome(bet: bet, result: result)
            case .field:
                return fieldOutcome(result: result)
            case .place:
                return placeOutcome(bet: bet, result: result)
            case .buy:
                return buyOutcome(bet: bet, result: result)
            case .lay:
                return layOutcome(bet: bet, result: result)
            case .lowHorn:
                return lowHornOutcome(result: result)
            case .highHorn:
                return highHornOutcome(result: result)
        }
    }

    private func passLineOutcome(result: RollResult) -> BetOutcome {
        if !puck.isOn {
            if result.isNatural {
                return .win
            }

            if result.isCrap {
                return .lose
            }

            return .noAction
        }

        if result.total == puck.point {
            return .win
        }

        if result.total == 7 {
            return .lose
        }

        return .noAction
    }

    private func dontLineOutcome(result: RollResult) -> BetOutcome {
        if !puck.isOn {
            if result.isNatural {
                return .lose
            }

            if result.isCrap {
                return .win
            }

            return .noAction
        }

        if result.total == 7 {
            return .win
        }

        if result.total == puck.point {
            return .lose
        }

        return .noAction
    }

    private func comeOutcome(bet: Bet, result: RollResult) -> BetOutcome {
        if (bet.on == nil) {
            if result.isNatural{
                return .win
            }

            if result.isCrap{
                return .lose
            }

            player.resolveBet(bet: bet)
            let newBet = bet.changeComeToPoint(bet: bet, point: result.total)
            player.appendBet(bet: newBet)
            return .noAction
        }

        if (result.total == 7) {
            return .lose
        }
        if (result.total == bet.on){
            return .win
        }


        return .noAction
    }

    private func fieldOutcome(result: RollResult) -> BetOutcome {
        if [2, 3, 4, 9, 10, 11, 12].contains(result.total) {
            return .win
        }

        return .lose
    }

    private func placeOutcome(bet: Bet, result: RollResult) -> BetOutcome {
        if result.total == bet.on {
            return .win
        }

        if result.total == 7 {
            return .lose
        }

        return .noAction
    }

    private func buyOutcome(bet: Bet, result: RollResult) -> BetOutcome {
        if result.total == bet.on {
            return .win
        }

        if result.total == 7 {
            return .lose
        }

        return .noAction
    }

    private func layOutcome(bet: Bet, result: RollResult) -> BetOutcome {
        if result.total == 7 {
            return .win
        }

        if result.total == bet.on {
            return .lose
        }

        return .noAction
    }

    private func lowHornOutcome(result: RollResult) -> BetOutcome {
        if [3, 11].contains(result.total) {
            return .win
        }

        return .lose
    }

    private func highHornOutcome(result: RollResult) -> BetOutcome {
        if [2, 12].contains(result.total) {
            return .win
        }

        return .lose
    }

    private func payout(result: RollResult) -> Void {
        let betMap = player.listBets()
        var playerEarnings = 0
        var houseEarnings = 0

        betMap.forEach { bet in
            guard bet.isActive else {
                return
            }

            switch betOutcome(bet: bet, result: result){
                case .win:
//                    print("Player won \(bet.payout)")
                    playerEarnings += bet.payout
                    houseEarnings -= bet.winnings
                    player.resolveBet(bet: bet)

                case .lose:
//                    print("Player lost \(bet.amount)")
                    houseEarnings += bet.amount
                    player.resolveBet(bet: bet)

                case .noAction:
//                    print("No action for \(bet.type)")
                    break
            }

        }
        player.updateBalance(amount: playerEarnings)
        gameState.updateBalance(amount: houseEarnings)
    }


    public var isComeOutRoll: Bool {
        !puck.isOn
    }

    public var getPuckPoint: String {
        puck.point.map(String.init) ?? "none"
    }

    public func canMakeBet(_ bet: Bet) -> Bool {
        switch bet.type {
            case .passLine, .dontLine:
                return isComeOutRoll

            default:
                return true
        }
    }

    public func makeBet(bet: Bet) -> Bool {
        guard canMakeBet(bet) else {
            return false
        }

        return player.addBet(bet: bet)
    }


    public func playTurn() -> Void {
        let action: Action = player.decideAction(gameState: self.gameState, puck: puck)
        action.execute(on: self)
    }

    var playerCanPlay: Bool {
        return !(player.getBalance() > 0 && isComeOutRoll)
    }

    public func getLastRoll() -> RollResult? {
        return self.gameState.getRollHistory().last ?? nil
    }

    public func shouldStop() -> Bool {
        return player.getBalance() == 0 && isComeOutRoll && !player.hasUnresolvedBets
    }
}
