//
//  main.swift
//  CrapsCore
//
//  Created by Matthew Long on 5/18/26.
//

import CrapsCore

let actionStrategy = BetRollActionStrategy(
    bettingStrategy: BankrollAwarePassLineStrategy(maxPercent: 0.05)
)

let player = Player(
    name: "Smarty pants",
    balance: 1000,
    strategy: actionStrategy
)
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

    while !game.shouldStop(){
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
