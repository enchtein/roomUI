//
//  PropertiesViewController.swift
//  game v3.0
//
//  Created by enchtein on 04.02.2021.
//

import UIKit
import PKHUD

class PropertiesViewController: UIViewController {
    var delegate: ViewController?
    var cellIdentyfier = "cellIdentyfier"
    
    private var propertyData = [Properties]()

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.register(UINib(nibName: "GameTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentyfier)
        self.allProperties()
    }
    
    fileprivate func allProperties() {
        propertyData = [
            Properties(name: "dot x", value: self.delegate?.person?.dot.x),
            Properties(name: "dot y", value: self.delegate?.person?.dot.y),
            Properties(name: "user x", value: self.delegate?.person?.person.x),
            Properties(name: "user y", value: self.delegate?.person?.person.y),
            Properties(name: "box x", value: self.delegate?.box?.box.x),
            Properties(name: "box y", value: self.delegate?.box?.box.y),
        ]
    }
}

extension PropertiesViewController: UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print(self.propertyData.count)
        return self.propertyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.tableView.dequeueReusableCell(withIdentifier: cellIdentyfier, for: indexPath) as? GameTableViewCell {
            cell.propertyValue.delegate = self
            cell.propertyValue.placeholder = propertyData[indexPath.row].name
            
            cell.setupCell(with: self.propertyData[indexPath.row])
            
            return cell
        }
        return UITableViewCell()
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        var oldValue = Int()
        var newValue = Int()
        switch textField.placeholder {
        case "dot x":
            oldValue = (self.delegate?.person?.dot.x)!
            self.delegate?.person?.dot.x = Int(textField.text!)!
            newValue = (self.delegate?.person?.dot.x)!
        case "dot y":
            oldValue = (self.delegate?.person?.dot.y)!
            self.delegate?.person?.dot.y = Int(textField.text!)!
            newValue = (self.delegate?.person?.dot.y)!
        case "user x":
            oldValue = (self.delegate?.person?.person.x)!
            self.delegate?.person?.person.x = Int(textField.text!)!
            newValue = (self.delegate?.person?.person.x)!
        case "user y":
            oldValue = (self.delegate?.person?.person.y)!
            self.delegate?.person?.person.y = Int(textField.text!)!
            newValue = (self.delegate?.person?.person.y)!
        case "box x":
            oldValue = (self.delegate?.box?.box.x)!
            self.delegate?.box?.box.x = Int(textField.text!)!
            newValue = (self.delegate?.box?.box.x)!
        case "box y":
            oldValue = (self.delegate?.box?.box.y)!
            self.delegate?.box?.box.y = Int(textField.text!)!
            newValue = (self.delegate?.box?.box.y)!
        default:
            print("nothig to change")
        }
        self.checkChanges(oldValue: oldValue, newValue: newValue)
    }
    func checkChanges(oldValue: Int, newValue: Int) {
        allProperties()
        if oldValue == newValue {
            print("Новое значение не установленно")
            HUD.flash(.error, delay: 1.0)
            self.tableView.reloadData()
        } else {
            print("Новое значение установлено")
            HUD.flash(.success, delay: 1.0)
        }
    }
    
}
