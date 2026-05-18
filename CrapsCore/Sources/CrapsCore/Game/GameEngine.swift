    //
    //  GameEngine.swift
    //  Craps
    //
    //  Created by Matthew Long on 5/16/26.
    //

    //One player craps
public class GameEngine {
    var puck: Puck
    private let player: Player
    private let gameState: GameState


    public init (puck: Puck, player: Player, gameState: GameState){
        self.puck = puck
        self.player = player
        self.gameState = gameState
    }

    func betOutcome(bet: Bet, result: RollResult) -> BetOutcome {
        switch bet.type {
            case .passLine:
                return passLineOutcome(result: result)
            case .dontLine:
                return dontLineOutcome(result: result)
            case .come:
                return comeOutcome(result: result)
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

    private func comeOutcome(result: RollResult) -> BetOutcome {
        if !puck.isOn {
            if result.isNatural {
                return .win
            }

            if result.isCrap {
                return .lose
            }

            return .noAction
        }

        if result.total == 7 {
            return .lose
        }

        if result.total == puck.point {
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
                    playerEarnings += bet.payout
                    houseEarnings -= bet.winnings
                    player.resolveBet(bet: bet)

                case .lose:
                    houseEarnings += bet.amount
                    player.resolveBet(bet: bet)

                case .noAction:
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

        return player.makeBet(bet: bet)
    }

    public func makeBet() -> Bool {
        return player.makeBet(gameState: gameState, puck: puck)
    }

    public func playTurn(roll: RollResult) -> Void {
            //TODO figure out game loop
        print("Roll: \(roll.total)")
        self.gameState.updateRollHistory(roll: roll)
            //GameState should track last payout?
        self.payout(result: roll)
        puck.flip(roll: roll.total) //toggle a flip

    }

    public func playTurn() -> RollResult {
        //True turn playing
        let roll = CrapsRoller.roll()
        playTurn(roll: roll)
        return roll
    }
}
