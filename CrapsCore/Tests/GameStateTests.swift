//
//  GameStateTests.swift
//  Craps
//
//  Created by Matthew Long on 5/14/26.
//

import XCTest
@testable import CrapsCore


final class GameStateTests: XCTestCase {

    func testRollHistoryUpdateAfter100Rolls() {
        let state = GameState()
        for _ in 1...100 {
            let result = CrapsRoller.roll()
            state.updateRollHistory(roll: result)
        }

        let rollHistory = state.getRollHistory()
        XCTAssertEqual(rollHistory.count, 100)
        rollHistory.forEach {
            XCTAssertNotNil($0)
        }
    }

    func testRollHistoryUpdateAfter100Rolls2() {
        let state = GameState()
        for _ in 1...100 {
            let result = CrapsRoller.roll()
            state.updateRollHistory(roll: result)
        }

        let rollHistory = state.getRollHistoryTotals()
        rollHistory.forEach {
            XCTAssertNotNil($0)
        }
    }


}

