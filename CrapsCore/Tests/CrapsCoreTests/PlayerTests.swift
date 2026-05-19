    //
    //  PlayerTests.swift
    //  Craps
    //
    //  Created by Matthew Long on 5/16/26.
    //

import XCTest
@testable import CrapsCore

final class PlayerTests: XCTestCase{

    var player: Player!
    var simpleStrategy: SimpleActionStrategy!

    override func setUp() {
        simpleStrategy = SimpleActionStrategy(bettingStrategy: DumbPassLineStrategy())
        player = Player(
            name: "Matt",
            balance: 1000,
            strategy: simpleStrategy
        )
    }

}
