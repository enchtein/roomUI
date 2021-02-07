//
//  Box.swift
//  game v3.0
//
//  Created by enchtein on 04.02.2021.
//

import Foundation

class Box: Room {
    var _box: (x: Int, y: Int) = (x: 3, y: 4)
    var box: (x: Int, y: Int) {
        get {
            return (self._box.x, self._box.y)
        }
        set (newValue) {
            if newValue.x >= 0, newValue.x <= self.room.x {
                self._box.x = newValue.x
            }
            if newValue.y >= 0, newValue.y <= self.room.y {
                self._box.y = newValue.y
            }
        }
    }
    
    init(x: Int, y: Int) {
        super.init()
        if x > 0, x <= self.room.x {
            self._box.x = x
        } else {
            print("Install default value box X")
        }
        if y > 0, y <= self.room.y {
            self._box.y = y
        } else {
            print("Install default value box Y")
        }
    }
}
