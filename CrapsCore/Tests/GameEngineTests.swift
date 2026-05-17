    //
    //  GameEngineTests.swift
    //  Craps
    //
    //  Created by Matthew Long on 5/16/26.
    //


import XCTest
@testable import CrapsCore


final class GameEngineTests: XCTestCase {

    func testPlayOneTurn(){
        let player = Player(name: "Jim", balance: 10)
        let puck = Puck()
        let gameState = GameState()
        let game = GameEngine(player: player, puck: puck, )
        let bet = Bet.passLine(amount: 5)
        player.makeBet(bet: bet)


    }



}
