    //
    //  PlayerTests.swift
    //  Craps
    //
    //  Created by Matthew Long on 5/16/26.
    //

import XCTest
@testable import CrapsCore

final class PlayerTests: XCTestCase{

    func testInit(){
        let player = Player(
            name: "hi",
            balance: 100,
            strategy: DumbPassLineStrategy()
        )
    }

    func testBetTwice(){
        let player = Player(name: "Matt", balance: 1000,  strategy: DumbPassLineStrategy())
        let betAmount = 25

        let bet1: Bet = Bet.dontLine(amount: betAmount)
        let bet2: Bet = Bet.fieldBet(amount: betAmount)
        player.makeBet(bet: bet1)
        player.makeBet(bet: bet2)

        let bets = player.listBets()
        XCTAssertEqual(player.getBalance(), 950)
    }

    func testBetThreeTimes(){
        let player = Player(name: "Matt", balance: 1000,  strategy: DumbPassLineStrategy())
        let betAmount = 25
        let key = 4

        let bet1: Bet = Bet.dontLine(amount: betAmount)
        let bet2: Bet = Bet.fieldBet(amount: betAmount)
        let bet3: Bet = Bet.placeBet(amount: betAmount, on: key)
        player.makeBet(bet: bet1)
        player.makeBet(bet: bet2)
        player.makeBet(bet: bet3)

        let bets = player.listBets()
        XCTAssertEqual(player.getBalance(), 925)
    }


    func testPlayerCannotBetWithNoMoney(){
        let player = Player(name: "Broke boi", balance: 0,  strategy: DumbPassLineStrategy())
        let betAmount = 25

        let bet: Bet = Bet.passLine(amount: betAmount)
        let isValid = player.makeBet(bet: bet)

        XCTAssertFalse(isValid, "Player should not be able to make a bet with no money.")
    }

    func testPlayerCanMakeOneValidBetsWithDeclaredBalance(){
        let player = Player(name: "Joe Schmo", balance: 10,  strategy: DumbPassLineStrategy())
        let betAmount1 = 10

        let bet1: Bet = Bet.passLine(amount: betAmount1)
        var isValid = player.makeBet(bet: bet1)

        XCTAssertTrue(isValid, "Player should be able to make this bet.")
        let betAmount2 = 11
        let bet2: Bet = Bet.passLine(amount: betAmount2)
        isValid = player.makeBet(bet: bet2)
        XCTAssertFalse(isValid, "Player should not be able to make this bet.")

    }


    func testPlaceValidPlaceBetOnFour() {
        assertPlaceBet(on: 4)
    }

    func testPlaceValidPlaceBetOnFive() {
        assertPlaceBet(on: 5)
    }

    func testPlaceValidPlaceBetOnSix() {
        assertPlaceBet(on: 6)
    }

    func testPlaceValidPlaceBetOnEight() {
        assertPlaceBet(on: 8)
    }

    func testPlaceValidPlaceBetOnNine() {
        assertPlaceBet(on: 9)
    }

    func testPlaceValidPlaceBetOnTen() {
        assertPlaceBet(on: 10)
    }

    private func assertPlaceBet(on: Int) {
        let player = Player(name: "Matt", balance: 1000,  strategy: DumbPassLineStrategy())
        let betAmount = 25
        let bet = Bet.placeBet(amount: betAmount, on: on)
        player.makeBet(bet: bet)

        let bets = player.listBets()
        let query = bets.first(where: { $0.on == on })

        XCTAssertEqual(query?.amount, betAmount)
    }

}
