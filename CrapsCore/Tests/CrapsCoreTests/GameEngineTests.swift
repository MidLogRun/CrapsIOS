    //
    //  GameEngineTests.swift
    //  Craps
    //
    //  Created by Matthew Long on 5/16/26.
    //

import XCTest
@testable import CrapsCore

final class GameEngineTests: XCTestCase {
    var player: Player!
    var puck: Puck!
    var gameState: GameState!
    var game: GameEngine!

    let playerStartingBalance = 100
    let gameStartingBalance = 1_000

    override func setUp() {
        super.setUp()

        player = Player(
            name: "Jim",
            balance: playerStartingBalance,
            strategy: DumbPassLineStrategy()
        )
        puck = Puck()
        gameState = GameState(balance: gameStartingBalance)
        game = GameEngine(puck: puck, player: player, gameState: gameState)
    }

    override func tearDown() {
        player = nil
        puck = nil
        gameState = nil
        game = nil

        super.tearDown()
    }

        // MARK: - Pass Line Outcome

    func testBetOutcomePassLineWinsOnComeOutNaturalSeven() {
        let bet = Bet.passLine(amount: 5)
        let result = RollResult(left: 3, right: 4)

        XCTAssertEqual(game.betOutcome(bet: bet, result: result), .win)
    }

    func testBetOutcomePassLineWinsOnComeOutNaturalEleven() {
        let bet = Bet.passLine(amount: 5)
        let result = RollResult(left: 5, right: 6)

        XCTAssertEqual(game.betOutcome(bet: bet, result: result), .win)
    }

    func testBetOutcomePassLineLosesOnComeOutCrapTwo() {
        let bet = Bet.passLine(amount: 5)
        let result = RollResult(left: 1, right: 1)

        XCTAssertEqual(game.betOutcome(bet: bet, result: result), .lose)
    }

    func testBetOutcomePassLineLosesOnComeOutCrapThree() {
        let bet = Bet.passLine(amount: 5)
        let result = RollResult(left: 1, right: 2)

        XCTAssertEqual(game.betOutcome(bet: bet, result: result), .lose)
    }

    func testBetOutcomePassLineLosesOnComeOutCrapTwelve() {
        let bet = Bet.passLine(amount: 5)
        let result = RollResult(left: 6, right: 6)

        XCTAssertEqual(game.betOutcome(bet: bet, result: result), .lose)
    }

    func testBetOutcomePassLineNoActionOnComeOutPointNumber() {
        let bet = Bet.passLine(amount: 5)
        let result = RollResult(left: 3, right: 3)

        XCTAssertEqual(game.betOutcome(bet: bet, result: result), .noAction)
    }

    func testBetOutcomePassLineWinsWhenEstablishedPointRepeats() {
        game.puck.flip(roll: 6)

        let bet = Bet.passLine(amount: 5)
        let result = RollResult(left: 3, right: 3)

        XCTAssertEqual(game.betOutcome(bet: bet, result: result), .win)
    }

    func testBetOutcomePassLineLosesWhenSevenOutAfterPointEstablished() {
        game.puck.flip(roll: 6)

        let bet = Bet.passLine(amount: 5)
        let result = RollResult(left: 3, right: 4)

        XCTAssertEqual(game.betOutcome(bet: bet, result: result), .lose)
    }

    func testBetOutcomePassLineNoActionWhenPointIsEstablishedAndDifferentNumberRolls() {
        game.puck.flip(roll: 6)

        let bet = Bet.passLine(amount: 5)
        let result = RollResult(left: 2, right: 3)

        XCTAssertEqual(game.betOutcome(bet: bet, result: result), .noAction)
    }

        // MARK: - Don't Line Outcome

    func testBetOutcomeDontLineLosesOnComeOutNaturalSeven() {
        let bet = Bet.dontLine(amount: 5)
        let result = RollResult(left: 3, right: 4)

        XCTAssertEqual(game.betOutcome(bet: bet, result: result), .lose)
    }

    func testBetOutcomeDontLineLosesOnComeOutNaturalEleven() {
        let bet = Bet.dontLine(amount: 5)
        let result = RollResult(left: 5, right: 6)

        XCTAssertEqual(game.betOutcome(bet: bet, result: result), .lose)
    }

    func testBetOutcomeDontLineWinsOnComeOutCrapTwo() {
        let bet = Bet.dontLine(amount: 5)
        let result = RollResult(left: 1, right: 1)

        XCTAssertEqual(game.betOutcome(bet: bet, result: result), .win)
    }

    func testBetOutcomeDontLineWinsOnComeOutCrapThree() {
        let bet = Bet.dontLine(amount: 5)
        let result = RollResult(left: 1, right: 2)

        XCTAssertEqual(game.betOutcome(bet: bet, result: result), .win)
    }

    func testBetOutcomeDontLineWinsOnComeOutCrapTwelveAccordingToCurrentImplementation() {
        let bet = Bet.dontLine(amount: 5)
        let result = RollResult(left: 6, right: 6)

        XCTAssertEqual(game.betOutcome(bet: bet, result: result), .win)
    }

    func testBetOutcomeDontLineNoActionOnComeOutPointNumber() {
        let bet = Bet.dontLine(amount: 5)
        let result = RollResult(left: 3, right: 3)

        XCTAssertEqual(game.betOutcome(bet: bet, result: result), .noAction)
    }

    func testBetOutcomeDontLineWinsWhenSevenOutAfterPointEstablished() {
        game.puck.flip(roll: 6)

        let bet = Bet.dontLine(amount: 5)
        let result = RollResult(left: 3, right: 4)

        XCTAssertEqual(game.betOutcome(bet: bet, result: result), .win)
    }

    func testBetOutcomeDontLineLosesWhenEstablishedPointRepeats() {
        game.puck.flip(roll: 6)

        let bet = Bet.dontLine(amount: 5)
        let result = RollResult(left: 3, right: 3)

        XCTAssertEqual(game.betOutcome(bet: bet, result: result), .lose)
    }

    func testBetOutcomeDontLineNoActionWhenPointIsEstablishedAndDifferentNumberRolls() {
        game.puck.flip(roll: 6)

        let bet = Bet.dontLine(amount: 5)
        let result = RollResult(left: 2, right: 3)

        XCTAssertEqual(game.betOutcome(bet: bet, result: result), .noAction)
    }

        // MARK: - Come Outcome

    func testBetOutcomeComeWinsOnComeOutNatural() {
        let bet = Bet(type: .come, amount: 5, isActive: true)
        let result = RollResult(left: 3, right: 4)

        XCTAssertEqual(game.betOutcome(bet: bet, result: result), .win)
    }

    func testBetOutcomeComeLosesOnComeOutCrap() {
        let bet = Bet(type: .come, amount: 5, isActive: true)
        let result = RollResult(left: 1, right: 1)

        XCTAssertEqual(game.betOutcome(bet: bet, result: result), .lose)
    }

    func testBetOutcomeComeNoActionOnComeOutPointNumber() {
        let bet = Bet(type: .come, amount: 5, isActive: true)
        let result = RollResult(left: 3, right: 3)

        XCTAssertEqual(game.betOutcome(bet: bet, result: result), .noAction)
    }

    func testBetOutcomeComeLosesOnSevenWhenPuckIsOn() {
        game.puck.flip(roll: 6)

        let bet = Bet(type: .come, amount: 5, isActive: true)
        let result = RollResult(left: 3, right: 4)

        XCTAssertEqual(game.betOutcome(bet: bet, result: result), .lose)
    }

    func testBetOutcomeComeWinsWhenPuckPointRepeats() {
        game.puck.flip(roll: 6)

        let bet = Bet(type: .come, amount: 5, isActive: true)
        let result = RollResult(left: 3, right: 3)

        XCTAssertEqual(game.betOutcome(bet: bet, result: result), .win)
    }

    func testBetOutcomeComeNoActionWhenPuckIsOnAndDifferentNumberRolls() {
        game.puck.flip(roll: 6)

        let bet = Bet(type: .come, amount: 5, isActive: true)
        let result = RollResult(left: 2, right: 3)

        XCTAssertEqual(game.betOutcome(bet: bet, result: result), .noAction)
    }

        // MARK: - Field Outcome

    func testBetOutcomeFieldWinsOnTwo() {
        let bet = Bet.fieldBet(amount: 5)
        let result = RollResult(left: 1, right: 1)

        XCTAssertEqual(game.betOutcome(bet: bet, result: result), .win)
    }

    func testBetOutcomeFieldWinsOnThree() {
        let bet = Bet.fieldBet(amount: 5)
        let result = RollResult(left: 1, right: 2)

        XCTAssertEqual(game.betOutcome(bet: bet, result: result), .win)
    }

    func testBetOutcomeFieldWinsOnFour() {
        let bet = Bet.fieldBet(amount: 5)
        let result = RollResult(left: 2, right: 2)

        XCTAssertEqual(game.betOutcome(bet: bet, result: result), .win)
    }

    func testBetOutcomeFieldLosesOnFive() {
        let bet = Bet.fieldBet(amount: 5)
        let result = RollResult(left: 2, right: 3)

        XCTAssertEqual(game.betOutcome(bet: bet, result: result), .lose)
    }

    func testBetOutcomeFieldLosesOnSix() {
        let bet = Bet.fieldBet(amount: 5)
        let result = RollResult(left: 3, right: 3)

        XCTAssertEqual(game.betOutcome(bet: bet, result: result), .lose)
    }

    func testBetOutcomeFieldLosesOnSeven() {
        let bet = Bet.fieldBet(amount: 5)
        let result = RollResult(left: 3, right: 4)

        XCTAssertEqual(game.betOutcome(bet: bet, result: result), .lose)
    }

    func testBetOutcomeFieldLosesOnEight() {
        let bet = Bet.fieldBet(amount: 5)
        let result = RollResult(left: 4, right: 4)

        XCTAssertEqual(game.betOutcome(bet: bet, result: result), .lose)
    }

    func testBetOutcomeFieldWinsOnNine() {
        let bet = Bet.fieldBet(amount: 5)
        let result = RollResult(left: 4, right: 5)

        XCTAssertEqual(game.betOutcome(bet: bet, result: result), .win)
    }

    func testBetOutcomeFieldWinsOnTen() {
        let bet = Bet.fieldBet(amount: 5)
        let result = RollResult(left: 5, right: 5)

        XCTAssertEqual(game.betOutcome(bet: bet, result: result), .win)
    }

    func testBetOutcomeFieldWinsOnEleven() {
        let bet = Bet.fieldBet(amount: 5)
        let result = RollResult(left: 5, right: 6)

        XCTAssertEqual(game.betOutcome(bet: bet, result: result), .win)
    }

    func testBetOutcomeFieldWinsOnTwelve() {
        let bet = Bet.fieldBet(amount: 5)
        let result = RollResult(left: 6, right: 6)

        XCTAssertEqual(game.betOutcome(bet: bet, result: result), .win)
    }

        // MARK: - Place Outcome

    func testBetOutcomePlaceBetWinsWhenRollMatchesOnValue() {
        let bet = Bet.placeBet(amount: 5, on: 6)
        let result = RollResult(left: 3, right: 3)

        XCTAssertEqual(game.betOutcome(bet: bet, result: result), .win)
    }

    func testBetOutcomePlaceBetLosesOnSeven() {
        let bet = Bet.placeBet(amount: 5, on: 6)
        let result = RollResult(left: 3, right: 4)

        XCTAssertEqual(game.betOutcome(bet: bet, result: result), .lose)
    }

    func testBetOutcomePlaceBetNoActionWhenDifferentNumberRolls() {
        let bet = Bet.placeBet(amount: 5, on: 6)
        let result = RollResult(left: 2, right: 3)

        XCTAssertEqual(game.betOutcome(bet: bet, result: result), .noAction)
    }

        // MARK: - Buy Outcome

    func testBetOutcomeBuyBetWinsWhenRollMatchesOnValue() {
        let bet = Bet(type: .buy, amount: 5, isActive: true)
        let result = RollResult(left: 3, right: 3)

        XCTAssertEqual(game.betOutcome(bet: Bet(on: 6, amount: bet.amount, isActive: bet.isActive), result: result), .win)
    }

    func testBetOutcomeBuyBetLosesOnSeven() {
        let bet = Bet(on: 6, amount: 5, isActive: true)
        let buyBet = Bet(type: .buy, amount: bet.amount, isActive: bet.isActive)
        let result = RollResult(left: 3, right: 4)

        XCTAssertEqual(game.betOutcome(bet: buyBet, result: result), .lose)
    }

    func testBetOutcomeBuyBetNoActionWhenDifferentNumberRolls() {
        let bet = Bet(type: .buy, amount: 5, isActive: true)
        let result = RollResult(left: 2, right: 3)

        XCTAssertEqual(game.betOutcome(bet: bet, result: result), .noAction)
    }

        // MARK: - Lay Outcome

    func testBetOutcomeLayBetWinsOnSeven() {
        let bet = Bet(type: .lay, amount: 5, isActive: true)
        let result = RollResult(left: 3, right: 4)

        XCTAssertEqual(game.betOutcome(bet: bet, result: result), .win)
    }

    func testBetOutcomeLayBetNoActionWhenDifferentNumberRolls() {
        let bet = Bet(type: .lay, amount: 5, isActive: true)
        let result = RollResult(left: 2, right: 3)

        XCTAssertEqual(game.betOutcome(bet: bet, result: result), .noAction)
    }

        // MARK: - Horn Outcome

    func testBetOutcomeLowHornWinsOnThree() {
        let bet = Bet.lowHornBet(amount: 5)
        let result = RollResult(left: 1, right: 2)

        XCTAssertEqual(game.betOutcome(bet: bet, result: result), .win)
    }

    func testBetOutcomeLowHornWinsOnEleven() {
        let bet = Bet.lowHornBet(amount: 5)
        let result = RollResult(left: 5, right: 6)

        XCTAssertEqual(game.betOutcome(bet: bet, result: result), .win)
    }

    func testBetOutcomeLowHornLosesOnOtherNumber() {
        let bet = Bet.lowHornBet(amount: 5)
        let result = RollResult(left: 3, right: 3)

        XCTAssertEqual(game.betOutcome(bet: bet, result: result), .lose)
    }

    func testBetOutcomeHighHornWinsOnTwo() {
        let bet = Bet.highHornBet(amount: 5)
        let result = RollResult(left: 1, right: 1)

        XCTAssertEqual(game.betOutcome(bet: bet, result: result), .win)
    }

    func testBetOutcomeHighHornWinsOnTwelve() {
        let bet = Bet.highHornBet(amount: 5)
        let result = RollResult(left: 6, right: 6)

        XCTAssertEqual(game.betOutcome(bet: bet, result: result), .win)
    }

    func testBetOutcomeHighHornLosesOnOtherNumber() {
        let bet = Bet.highHornBet(amount: 5)
        let result = RollResult(left: 3, right: 3)

        XCTAssertEqual(game.betOutcome(bet: bet, result: result), .lose)
    }

        // MARK: - playTurn / payout / puck integration

    func testPlayTurnWinningPassLineBetPaysPlayerAndFlipsPuckOff() {
        let amount = 5
        let bet = Bet.passLine(amount: amount)

        XCTAssertTrue(player.makeBet(bet: bet))
        game.playTurn(roll: RollResult(left: 3, right: 4))

        XCTAssertEqual(player.getBalance(), playerStartingBalance + amount)
        XCTAssertFalse(game.puck.isOn)
        XCTAssertNil(game.puck.point)
    }

    func testPlayTurnLosingPassLineBetPaysHouseAndFlipsPuckOff() {
        let amount = 5
        let bet = Bet.passLine(amount: amount)

        XCTAssertTrue(player.makeBet(bet: bet))
        game.playTurn(roll: RollResult(left: 1, right: 1))

        XCTAssertEqual(player.getBalance(), playerStartingBalance - amount)
        XCTAssertFalse(game.puck.isOn)
        XCTAssertNil(game.puck.point)
    }

    func testPlayTurnNoActionPassLineBetEstablishesPoint() {
        let amount = 5
        let bet = Bet.passLine(amount: amount)

        XCTAssertTrue(player.makeBet(bet: bet))
        game.playTurn(roll: RollResult(left: 3, right: 3))

        XCTAssertEqual(player.getBalance(), playerStartingBalance - amount)
        XCTAssertTrue(game.puck.isOn)
        XCTAssertEqual(game.puck.point, 6)
    }

    func testPlayTurnInactiveBetDoesNotPayPlayerOrHouse() {
        let bet = Bet(type: .field, amount: 5, isActive: false)
        XCTAssertTrue(player.makeBet(bet: bet))
        game.playTurn(roll: RollResult(left: 1, right: 1))
        XCTAssertEqual(player.getBalance(), playerStartingBalance - 5)
    }

    func testPasslineBetNoActionOnFirstThenLoses() {
        //Hate when this happens
        let bet = Bet.passLine(amount: 5)
        XCTAssertTrue(player.makeBet(bet: bet))
        game.playTurn(roll: RollResult(left:3, right: 5))
        XCTAssertEqual(player.getBalance(), playerStartingBalance - 5)
        XCTAssertEqual(gameState.getBalance(), gameStartingBalance)

        game.playTurn(roll: RollResult(left: 5, right: 2))
        XCTAssertEqual(player.getBalance(), playerStartingBalance - 5)
        XCTAssertEqual(gameState.getBalance(), gameStartingBalance + 5)
    }

    func testGameEngineWithPlayerBettingStrat() {
        let newPlayer = Player(
            name: "dumby",
            balance: 100,
            strategy: DumbPassLineStrategy()
        )

        let newGame = GameEngine(puck: Puck() ,player: newPlayer, gameState: gameState )
        newGame.makeBet()
        let roll = newGame.playTurn()

        if (roll.isNatural){
            XCTAssertEqual(newPlayer.getBalance(), 200)
        } else {
            XCTAssertEqual(newPlayer.getBalance(), 0)
        }
    }

    func shouldStop(player: Player, game: GameEngine) -> Bool {
        player.getBalance() == 0 && game.isComeOutRoll
    }

    func gameLoop(player: Player, game: GameEngine) -> Int{
        var turns = 1
        while !shouldStop(player:player, game: game){
            game.makeBet()
            game.playTurn()
            turns += 1
        }
        return turns
    }

    func testConservativeStrategyLastsLonger() {
        let gameState1 = GameState(balance: 1000)
        let gameState2 = GameState(balance: 1000)

        let dumbass = Player(
            name: "dumby",
            balance: 100,
            strategy: DumbPassLineStrategy()
        )

        let game1 = GameEngine(puck: Puck(), player: dumbass, gameState: gameState1)
        let turns1 = gameLoop(player: dumbass, game: game1)

        let smartyPants = Player(
            name: "dumby",
            balance: 100,
            strategy: BankrollAwarePassLineStrategy(maxPercent: 0.5)
        )

        let game2 =  GameEngine(puck: Puck() ,player: smartyPants, gameState: gameState2)
        let turns2 = gameLoop(player: smartyPants, game: game2)

        print("dumbass played for", turns1, "turns")
        print("smartyPants played for", turns2, "turns")

        XCTAssertGreaterThan(turns2, turns1)
    }


}

