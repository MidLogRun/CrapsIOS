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
        let player = Player(name: "hi", balance: 100)
    }

    func testBetTwice(){
        let player = Player(name: "Matt", balance: 1000)
        let betAmount = 25
        let key = 4

        let bet1: Bet = Bet.dontLine(amount: betAmount)
        let bet2: Bet = Bet.fieldBet(amount: betAmount)
        player.makeBet(bet: bet1)
        player.makeBet(bet: bet2)

        let bets = player.listBets()
        XCTAssertEqual(player.getBalance(), 950)
    }

    func testBetThreeTimes(){
        let player = Player(name: "Matt", balance: 1000)
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
        let player = Player(name: "Matt", balance: 1000)
        let betAmount = 25
        let bet = Bet.placeBet(amount: betAmount, on: on)
        player.makeBet(bet: bet)

        let bets = player.listBets()
        let query = bets.first(where: { $0.on == on })

        XCTAssertEqual(query?.amount, betAmount)
    }

}
