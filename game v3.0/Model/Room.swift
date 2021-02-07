//
//  Room.swift
//  game v3.0
//
//  Created by enchtein on 04.02.2021.
//

import Foundation

class Room {
    var _room = (x: 10, y: 10)
    var room: (x: Int, y: Int) {
        get {
            return (x: self._room.x, y: self._room.y)
        }
        set (newValue) {
            if newValue.x >= 5, newValue.x <= 15 {
                self._room.x = newValue.x
            }
            if newValue.y >= 5, newValue.y <= 15 {
                self._room.y = newValue.y
            }
        }
    }

    init() {
        
    }
}
