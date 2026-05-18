//
//  PuckTests.swift
//  Craps
//
//  Created by Matthew Long on 5/14/26.
//

import XCTest
@testable import CrapsCore

final class PuckTests: XCTestCase {
    func testPuckInit(){
        let puck = Puck()
        XCTAssertEqual(puck.isOn, false)
        XCTAssertEqual(puck.point, nil)
    }

    func testPuckFlippedOn(){
        var puck = Puck()
        puck.flip(roll: RollResult(left:3, right: 2).total)
        XCTAssertEqual(puck.isOn, true)
        XCTAssertEqual(puck.point, 5)
    }

    func testSevenFlipsPuckOff(){
        var puck = Puck()
        puck.flip(roll: RollResult(left:3, right: 2).total)
        puck.flip(roll: RollResult(left: 3, right: 4).total)
        XCTAssertEqual(puck.isOn, false)
        XCTAssertEqual(puck.point, nil)
    }

    func testSevenDoesntFlipPuck(){
        var puck = Puck()
        puck.flip(roll: RollResult(left: 3, right: 4).total)
        XCTAssertEqual(puck.isOn, false)
        XCTAssertEqual(puck.point, nil)
    }

    func testElevenDoesntFlipPuck(){
        var puck = Puck()
        puck.flip(roll: RollResult(left:5, right: 6).total)
        XCTAssertEqual(puck.isOn, false)
        XCTAssertEqual(puck.point, nil)
    }

    func testTwoDoesntFlipPuck(){
        var puck = Puck()
        puck.flip(roll: RollResult(left:1, right: 1).total)
        XCTAssertEqual(puck.isOn, false)
        XCTAssertEqual(puck.point, nil)
    }

    func testThreeDoesntFlipPuck(){
        var puck = Puck()
        puck.flip(roll: RollResult(left:1, right: 2).total)
        XCTAssertEqual(puck.isOn, false)
        XCTAssertEqual(puck.point, nil)
    }

    func testTwelveDoesntFlipPuck(){
        var puck = Puck()
        puck.flip(roll: RollResult(left:6, right: 6).total)
        XCTAssertEqual(puck.isOn, false)
        XCTAssertEqual(puck.point, nil)
    }

    func testPuckFlippedOffForSameValue(){
        var puck = Puck()
        puck.flip(roll: RollResult(left:3, right: 2).total)
        puck.flip(roll: RollResult(left: 3, right: 2).total)
        XCTAssertEqual(puck.isOn, false)
        XCTAssertEqual(puck.point, nil)
    }
}
