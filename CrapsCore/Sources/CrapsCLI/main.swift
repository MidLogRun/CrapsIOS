//
//  main.swift
//  CrapsCore
//
//  Created by Matthew Long on 5/17/26.
//

import CrapsCore

let player = Player(name: "Smarty pants", balance: 100, strategy: CLIStrategy())
let puck = Puck()
let gameState = GameState(balance: 1_000)

let game = GameEngine(
    puck: puck,
    player: player,
    gameState: gameState
)

var highestBalance = player.getBalance()
var turnWhenBalanceHighest = 1

@MainActor
func shouldStop(player: Player, game: GameEngine) -> Bool {
    player.getBalance() == 0 && game.isComeOutRoll
}

@MainActor
func gameLoop(player: Player, game: GameEngine) -> Int {
    var turns = 1
    while !shouldStop(player:player, game: game){
        game.makeBet()
        game.playTurn()

        if (player.getBalance() > highestBalance){
            highestBalance = player.getBalance()
            turnWhenBalanceHighest = turns
        }

        turns += 1
    }
    return turns
}


var turn = gameLoop(player: player, game: game)

print(
    "Played \(turn) turns. Should've quit on turn \(turnWhenBalanceHighest) $\(highestBalance)"
)


//
//enum PlaceBetDistribution {
//    case even
//    case bestPayoutFirst
//}
//
//let placePoints = [4, 5, 6, 8, 9, 10]
//
//func payoutPriority(for point: Int) -> Int {
//    switch point {
//        case 4, 10:
//            return 0
//        case 5, 9:
//            return 1
//        case 6, 8:
//            return 2
//        default:
//            return 3
//    }
//}
//
//@MainActor
//func distributePlaceBets(
//    totalAmount: Int,
//    strategy: PlaceBetDistribution
//) -> [Bet] {
//    let availableBalance = player.getBalance()
//    let budget = min(totalAmount, availableBalance)
//
//    guard budget > 0 else {
//        return []
//    }
//
//    let points: [Int]
//
//    switch strategy {
//        case .even:
//            points = placePoints
//
//        case .bestPayoutFirst:
//            points = placePoints.sorted {
//                payoutPriority(for: $0) < payoutPriority(for: $1)
//            }
//    }
//
//    var remaining = budget
//    var bets: [Bet] = []
//
//    switch strategy {
//        case .even:
//            let baseAmount = budget / points.count
//            var remainder = budget % points.count
//
//            for point in points {
//                var amount = baseAmount
//
//                if remainder > 0 {
//                    amount += 1
//                    remainder -= 1
//                }
//
//                guard amount > 0 else {
//                    continue
//                }
//
//                bets.append(Bet.placeBet(amount: amount, on: point))
//            }
//
//        case .bestPayoutFirst:
//            for point in points {
//                guard remaining > 0 else {
//                    break
//                }
//
//                let amount = remaining / (points.count - bets.count)
//
//                if amount > 0 {
//                    bets.append(Bet.placeBet(amount: amount, on: point))
//                    remaining -= amount
//                }
//            }
//    }
//
//    return bets
//}



