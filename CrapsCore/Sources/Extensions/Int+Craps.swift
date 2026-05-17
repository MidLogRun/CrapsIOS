//
//  Int+Craps.swift
//  Craps
//
//  Created by Matthew Long on 5/15/26.
//



extension Int {
    var isCraps: Bool {
        self == 2 || self == 3 || self == 12
    }

    var isNatural: Bool {
        self == 7 || self == 11
    }

    var isPoint: Bool {
        self.isCraps == false && self.isNatural == false
    }
}
