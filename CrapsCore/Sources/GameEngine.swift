//
//  GameEngine.swift
//  Craps
//
//  Created by Matthew Long on 5/16/26.
//

//One player craps
class GameEngine {
    var puck: Puck
    let player: Player
    let gameState: GameState
    var isComeoutRoll: Bool {
        puck.isOn
    }

    init (puck: Puck, player: Player, gameState: GameState){
        self.puck = puck
        self.player = player
        self.gameState = gameState
    }


    private func betWins(bet: Bet, result: RollResult) -> Bool {
        switch bet.type {
            case .passLine:
                if (!puck.isOn){
                    return result.isNatural
                } else {
                    return result.total == puck.point
                }
            case .dontLine:
                if (!puck.isOn){
                    return result.isCrap
                } else {
                    return result.total == 7
                }
            case .come:
                return result.isNatural //This bet doesn't win but it shouldn't take the player's money unless result craps out
            case .field:
                return [2, 3, 4, 9, 10, 11, 12].contains(result.total)
            case .place, .buy, .lay:
                return bet.on == result.total
            case .lowHorn:
                return [3, 11].contains(result.total)
            case .highHorn:
                return [2, 12].contains(result.total)
            default:
                return false

        }
    }



    private func payout(result: RollResult) -> Void {
        let betMap = player.listBets()
        var playerEarnings = 0
        var houseEarnings = 0

        let rollOutcome = result.total


        betMap.forEach { bet in
            guard bet.isActive else {
                return
            }

            if (betWins(bet:bet, result: result)){
                playerEarnings += bet.payout
                houseEarnings -= bet.winnings
            } else {
                houseEarnings += bet.amount
            }
        }

        player.updateBalance(amount: playerEarnings)
        gameState.updateBalance(amount: houseEarnings)
    }

    public func playTurn() -> Void {
        //TODO figure out game loop
        let roll = CrapsRoller.roll()
        puck.flip(roll: roll.total) //toggle a flip
        self.gameState.updateRollHistory(roll: roll)
        //GameState should track last payout?
        self.payout(result: roll)
        
    }

    //TODO test playTurn and, by extension, payout

}
