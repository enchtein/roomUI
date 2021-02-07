//
//  Person.swift
//  game v3.0
//
//  Created by enchtein on 04.02.2021.
//

import Foundation

class Person: Room {
    
    let emptyImage = "🌫"
    let boxImage = "📦"
    let dotImage = "⚫️"
    let userImage = "🤦‍♂️"
    
    enum NewStep: Int, CaseIterable {
        case up
        case down
        case right
        case left

        var userStep: Int {
            switch self {
            case .up: return 1
            case .down: return -1
            case .right: return 1
            case .left: return -1
            }
        }
    }
    

    var _person: (x: Int, y: Int) = (x: 5, y: 6)
    var person: (x: Int, y: Int) {
        get {
            return (self._person.x, self._person.y)
        }
        set (newValue) {
            if newValue.x > 0, newValue.x <= self.room.x {
                self._person.x = newValue.x
            }
            if newValue.y > 0, newValue.y <= self.room.y {
                self._person.y = newValue.y
            }
        }
    }
    var box: Box?
    var dot = (x: 7, y: 7)
//    var maxSize: Int
    var alertMsg = ""
    var strUiMass = [[String]]()
//    var resRow = String()
    
    init(x: Int, y: Int) {
        super.init()
        if x > 0, x <= self.room.x {
            self._person.x = x
        } else {
            print("Install default value person X")
        }
        if y > 0, y <= self.room.y {
            self._person.y = y
        } else {
            print("Install default value person Y")
        }
        self.strUiMass = Array(repeating: Array(repeating: self.emptyImage, count: self.room.x), count: self.room.y)
        
        self.uiMass()
        
        print(self.userPos())
    }
    init(x: Int, y: Int, box: Box) {
        super.init()
        if x > 0, x <= self.room.x && (x, y) != box.box {
            self._person.x = x
        } else {
            print("Install default value person X")
        }
        if y > 0, y <= self.room.y && (x, y) != box.box {
            self._person.y = y
        } else {
            print("Install default value person Y")
        }
        self.box = box
        self.strUiMass = Array(repeating: Array(repeating: self.emptyImage, count: self.room.x), count: self.room.y)
        
        self.uiMass()
        
        print(self.userPos())
    }
    
    func uiMass() {
        for col in 0..<self.strUiMass.count {
            for row in 0..<self.strUiMass[col].count {
                self.strUiMass[col][row] = self.emptyImage
                if (col+1) == self.person.y, (row+1) == self.person.x {
                    self.strUiMass[col][row] = self.userImage
                } else if (col+1) == self.dot.y, (row+1) == self.dot.x {
                    self.strUiMass[col][row] = self.dotImage
                } else if (col+1) == self.box?.box.y, (row+1) == self.box?.box.x {
                    self.strUiMass[col][row] = self.boxImage
                }
            }
        }
//        self.toRow()
    }
    /* обновление только изменяемых точек */
    func uiMassPart() {
        for col in 0..<self.strUiMass.count {
            let replUIm = self.strUiMass[col].firstIndex(of: self.userImage)
            let replBIm = self.strUiMass[col].firstIndex(of: self.boxImage)
            
            if replUIm != nil {
                self.strUiMass[col][replUIm!] = self.emptyImage
            } else if replBIm != nil {
                self.strUiMass[col][replBIm!] = self.emptyImage
            }
        }
        if (self.person.y-1) >= 0, (self.person.x-1) >= 0 {
            self.strUiMass[(self.person.y-1)][(self.person.x-1)] = self.userImage
        }
        
        if self.box != nil && (self.box!.box.y-1) >= 0, (self.box!.box.x-1) >= 0 {
            self.strUiMass[(self.box!.box.y-1)][(self.box!.box.x-1)] = self.boxImage
        }
//        self.toRow()
    }
    /* обновление только изменяемых точек */
    func userPos() -> String {
        if box == nil {
            return "User x = \(self.person.x) and User y = \(self.person.y)"
        } else {
            var str = "User x = \(self.person.x) and User y = \(self.person.y)\n Box x = \(String(describing: self.box!.box.x)) and Box y = \(String(describing: self.box!.box.y))"
            if self.box!.box.x == dot.x, self.box!.box.y == dot.y {
                str = "Congratulations, you dropped the box!"
                self.alertMsg = "Congratulations, you dropped the box!"
            }
            return str
        }
    }
    func go(whereGo: NewStep.RawValue, param: inout Int, mirrorParam: Int, boxParam: inout Int, mirrorBoxParam: Int, border: Int, dotParam: Int, mirrorDotParam: Int) {
        if self.box == nil {
            param += NewStep(rawValue: whereGo)!.userStep
//            print("Work first value")
        } else if param == dotParam-NewStep(rawValue: whereGo)!.userStep && mirrorParam == mirrorDotParam {
            self.alertMsg = "Be carefull! You almost fell down"
        } else if param == boxParam-NewStep(rawValue: whereGo)!.userStep, boxParam != border && mirrorParam == mirrorBoxParam {
            param += NewStep(rawValue: whereGo)!.userStep
            boxParam += NewStep(rawValue: whereGo)!.userStep
//            print("Work second value")
        } else if param != boxParam-NewStep(rawValue: whereGo)!.userStep, boxParam != border {
            param += NewStep(rawValue: whereGo)!.userStep
//            print("Work third value")
        } else if mirrorParam != mirrorBoxParam {
            param += NewStep(rawValue: whereGo)!.userStep
//            print("Work fourght value")
        }
    }
    func getIndexPath(index: Int) -> (y: Int, x: Int) {
        let y = index / self.room.x
        let x = index - (y * self.room.x)
        
        return (y: y, x: x)
    }
}
