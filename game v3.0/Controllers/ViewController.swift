//
//  ViewController.swift
//  game v3.0
//
//  Created by enchtein on 04.02.2021.
//

import UIKit

class ViewController: UIViewController {
    var delegate: ViewController?
    
    var box: Box?
    var person: Person?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        box = Box(boxX: 3, boxY: 5)
        self.box = Box(x: 3, y: 4)
        self.person = Person(x: 5, y: 6, box: self.box!)
//        person = Person(userX: 1, userY: 2, boxCoord: box!)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("вызвана перезагрузка")
        if self.person?.alertMsg == "Congratulations, you dropped the box!" {
            self.person?.alertMsg = ""
            self.box?.box.x = 3
            self.box?.box.y = 4
            self.person?.person.x = 5
            self.person?.person.y = 6
            self.person?.dot.x = 7
            self.person?.dot.y = 7
            self.person?.box = self.box
//            self.person?.uiMassPart()
            self.person?.uiMass()
        } else {
            self.person?.uiMass()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let vc = segue.destination as? GameVC {
//            vc.delegateVC = self
        if let vc = segue.destination as? GameViewController {
            vc.delegate = self
//            vc.delegateVC = self
        } else if let vc = segue.destination as? PropertiesViewController {
            vc.delegate = self
//            vc.delegateVC = self
        }
    }

}
