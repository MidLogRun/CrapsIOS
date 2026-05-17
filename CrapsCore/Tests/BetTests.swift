    //
    //  BetTests.swift
    //  Craps
    //
    //  Created by Matthew Long on 5/16/26.
    //


import XCTest
@testable import CrapsCore

final class BetTests: XCTestCase{

    func testPayoutMultiplierOfPassLineBet() {
        let bet = Bet.passLine(amount: 100)
        XCTAssertEqual(bet.payoutMultiplier, 1.0)
    }

    func testPassLinePayoutFor100() {
        let bet = Bet.passLine(amount: 100)
        XCTAssertEqual(bet.winnings, 100)
        XCTAssertEqual(bet.payout, 200)
    }

    func testDontLinePayoutFor100() {
        let bet = Bet.dontLine(amount: 100)
        XCTAssertEqual(bet.winnings, 100)
        XCTAssertEqual(bet.payout, 200)
    }

    func testFieldPayoutFor100() {
        let bet = Bet.fieldBet(amount: 100)
        XCTAssertEqual(bet.winnings, 100)
        XCTAssertEqual(bet.payout, 200)
    }

    func testLowHornPayoutFor100() {
        let bet = Bet.lowHornBet(amount: 100)
        XCTAssertEqual(bet.winnings, 100)
        XCTAssertEqual(bet.payout, 200)
    }

    func testHighHornPayoutFor100() {
        let bet = Bet.highHornBet(amount: 100)
        XCTAssertEqual(bet.winnings, 100)
        XCTAssertEqual(bet.payout, 200)
    }

    func testPlaceBetOnFourPayoutFor100() {
        let bet = Bet.placeBet(amount: 100, on: 4)
        XCTAssertEqual(bet.winnings, 180)
        XCTAssertEqual(bet.payout, 280)
    }

    func testPlaceBetOnFivePayoutFor100() {
        let bet = Bet.placeBet(amount: 100, on: 5)
        XCTAssertEqual(bet.winnings, 140)
        XCTAssertEqual(bet.payout, 240)
    }

    func testPlaceBetOnSixPayoutFor100() {
        let bet = Bet.placeBet(amount: 100, on: 6)
        XCTAssertEqual(bet.winnings, 116)
        XCTAssertEqual(bet.payout, 216)
    }

    func testPlaceBetOnEightPayoutFor100() {
        let bet = Bet.placeBet(amount: 100, on: 8)
        XCTAssertEqual(bet.winnings, 116)
        XCTAssertEqual(bet.payout, 216)
    }

    func testPlaceBetOnNinePayoutFor100() {
        let bet = Bet.placeBet(amount: 100, on: 9)
        XCTAssertEqual(bet.winnings, 140)
        XCTAssertEqual(bet.payout, 240)
    }

    func testPlaceBetOnTenPayoutFor100() {
        let bet = Bet.placeBet(amount: 100, on: 10)
        XCTAssertEqual(bet.winnings, 180)
        XCTAssertEqual(bet.payout, 280)
    }


}
