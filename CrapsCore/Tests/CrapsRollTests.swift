//
//  CrapsRollTests.swift
//  Craps
//
//  Created by Matthew Long on 5/14/26.
//

import XCTest
@testable import CrapsCore


final class CrapsRollTests: XCTestCase {
    func testCrapsRollIsNumberBetween2And12(){
        let roll = CrapsRoller.roll()
        XCTAssert((2...12).contains(roll.total))
    }

    func testCrapsRollTypeIsMutuallyExclusive(){
        let roll = CrapsRoller.roll()
        if (roll.isCrap){
            XCTAssert(roll.isPoint == false)
            XCTAssert(roll.isNatural == false)
        } else if (roll.isPoint){
            XCTAssert(roll.isCrap == false)
            XCTAssert(roll.isNatural == false)
        } else if (roll.isNatural){
            XCTAssert(roll.isCrap == false)
            XCTAssert(roll.isPoint == false)
        }
    }

    func testCrapsRollIsHard(){
        let roll = CrapsRoller.roll()

        if (roll.isHard){
            XCTAssert(roll.left == roll.right)
        } else {
            XCTAssert(roll.left != roll.right)
        }
    }

    

}
