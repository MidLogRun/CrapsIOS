//
//  ClearBetActionTests.swift
//  CrapsCore
//
//  Created by Matthew Long on 5/26/26.
//




import XCTest
@testable import CrapsCore

final class ActionTests: XCTestCase{

    func testPlayerMakesAndClearsBet() {
        let player = Player(
            name: "doofy",
            balance: 1000,
            strategy: SimpleActionStrategy(
                bettingStrategy:DumbPassLineStrategy())
        )

        let bet = Bet.comeBet(amount: 100)
        let betMade = player.makeBet(bet: bet)
        XCTAssertTrue(betMade)
        let betCleared = player.clearBet(bet: bet)
        XCTAssertTrue(betCleared)
    }



    func testActionMakesAndClearsBets(){
        let player = Player(
            name: "doofy",
            balance: 1000,
            strategy: SimpleActionStrategy(
                bettingStrategy:DumbPassLineStrategy())
        )

        let game = GameEngine(puck: Puck(), player: player, gameState: GameState())

        let bet = Bet.comeBet(amount: 100)
        let makeAction = MakeBetAction(bet: bet, player: player)
        makeAction.execute(on: game)
        XCTAssertTrue(player.hasUnresolvedBets)
        let clearAction = ClearBetAction(bet: bet, player: player)
        clearAction.execute(on: game)
        XCTAssertFalse(player.hasUnresolvedBets)
    }


    func testRollActionRollsDice(){
        let player = Player(
            name: "doofy",
            balance: 1000,
            strategy: SimpleActionStrategy(
                bettingStrategy:DumbPassLineStrategy())
        )

        let game = GameEngine(puck: Puck(), player: player, gameState: GameState())

        let rollAction = RollAction()
        XCTAssertNil(game.getLastRoll())
        rollAction.execute(on: game)
        XCTAssertNotNil(game.getLastRoll())
    }


    func testViewBalanceAction(){
        let player = Player(
            name: "doofy",
            balance: 1000,
            strategy: SimpleActionStrategy(
                bettingStrategy:DumbPassLineStrategy())
        )

        let game = GameEngine(puck: Puck(), player: player, gameState: GameState())

        let viewBalanceAction = ViewBalanceAction(player: player)
        viewBalanceAction.execute(on: game) //Should print "Player balance is:  1000"
    }




}
