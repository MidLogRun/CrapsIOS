//
//  Puck.swift
//  Craps
//
//  Created by Matthew Long on 5/14/26.
//


struct Puck {
    var isOn: Bool
    var point: Optional<Int>

    init() {
        self.isOn = false
        self.point = nil
    }

    mutating func flip(roll: Int) {
        if (!self.isOn) {
            if (roll.isPoint){
                self.point = roll
                self.isOn = true
            }
        } else {
            if (roll == self.point || roll == 7){
                self.point = nil
                self.isOn = false
            }
        }
    }


}
