//
//  GameViewController.swift
//  game v3.0
//
//  Created by enchtein on 04.02.2021.
//

import UIKit

class GameViewController: UIViewController {
    var delegate: ViewController?
    var cellIdentyfier = "cellIdentyfier"
    var distanceBetwenElements: Int?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var portraitPosLabel: UILabel!
    @IBOutlet weak var landscapePosLabel: UILabel!
    @IBAction func moveButtonClicked(_ sender: UIButton) {
        guard let allData = delegate else {return}
        
        switch sender.tag {
        case 0:
            portraitPosLabel.text = "down"
            landscapePosLabel.text = "down"
            allData.person?.go(whereGo: 0, param: &allData.person!.person.y, mirrorParam: allData.person!.person.x, boxParam: &allData.person!.box!.box.y, mirrorBoxParam: allData.person!.box!.box.x, border: allData.person!.room.y, dotParam: allData.person!.dot.y, mirrorDotParam: allData.person!.dot.x)

            allData.person!.uiMassPart()
            print(allData.person!.userPos())
        case 1:
            portraitPosLabel.text = "left"
            landscapePosLabel.text = "left"
            allData.person?.go(whereGo: 1, param: &allData.person!.person.x, mirrorParam: allData.person!.person.y, boxParam: &allData.person!.box!.box.x, mirrorBoxParam: allData.person!.box!.box.y, border: 1, dotParam: allData.person!.dot.x, mirrorDotParam: allData.person!.dot.y)

            allData.person!.uiMassPart()
            print(allData.person!.userPos())
        case 2:
            portraitPosLabel.text = "right"
            landscapePosLabel.text = "right"
            allData.person?.go(whereGo: 2, param: &allData.person!.person.x, mirrorParam: allData.person!.person.y, boxParam: &allData.person!.box!.box.x, mirrorBoxParam: allData.person!.box!.box.y, border: allData.person!.room.x, dotParam: allData.person!.dot.x, mirrorDotParam: allData.person!.dot.y)

            allData.person!.uiMassPart()
            print(allData.person!.userPos())
        case 3:
            portraitPosLabel.text = "up"
            landscapePosLabel.text = "up"
            allData.person?.go(whereGo: 3, param: &allData.person!.person.y, mirrorParam: allData.person!.person.x, boxParam: &allData.person!.box!.box.y, mirrorBoxParam: allData.person!.box!.box.x, border: 1, dotParam: allData.person!.dot.y, mirrorDotParam: allData.person!.dot.x)

            allData.person!.uiMassPart()
            print(allData.person!.userPos())
        default:
            portraitPosLabel.text = "stop"
            landscapePosLabel.text = "stop"
        }
        collectionView.reloadData()
        
        let alert = UIAlertController(title: "UIAlertController", message: allData.person?.alertMsg, preferredStyle: .alert)
        let msgAction = UIAlertAction(title: "ok", style: .default)
        
        let action = UIAlertAction(title: "ok", style: .default) { (action) in
            if (self.storyboard?.instantiateViewController(withIdentifier: "StartVC") as? ViewController) != nil {
                self.navigationController?.popViewController(animated: true)
            }
        }
        if !(allData.person?.alertMsg.isEmpty ?? false) {
            switch allData.person?.alertMsg {
            case "Be carefull! You almost fell down":
                alert.addAction(msgAction)
                allData.person?.alertMsg = ""
                self.present(alert, animated: true, completion: nil)
            default:
                alert.addAction(action)
//                allData.person?.alertMsg = ""
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        collectionView.register(UINib(nibName: "GameCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellIdentyfier)
        
    }
    
}

extension GameViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var counterCells = 0
        if self.delegate != nil {
            counterCells = (self.delegate?.person?.strUiMass.first!.count)! * (self.delegate?.person!.strUiMass.count)!
        }
        return counterCells
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentyfier, for: indexPath) as? GameCollectionViewCell {
            
            //            print(indexPath.row)
            
            let indexFromIndexPath = self.getIndexPath(index: indexPath.row)
            cell.label.text = self.delegate?.person?.strUiMass[indexFromIndexPath.y][indexFromIndexPath.x]
            
            cell.tag = indexPath.row
            cell.autoresizesSubviews = true
            
            let width = Int(collectionView.bounds.size.width) / self.delegate!.person!.room.x
            let height = Int(collectionView.bounds.size.height) / self.delegate!.person!.room.y
            
            var fontSize: Int {
                width < height ? width-3 : height-3
            }
            
            self.distanceBetwenElements = Int(collectionView.bounds.size.height) - (fontSize * self.delegate!.person!.room.x)
            
            let font = UIFont(name: "Helvetica", size: CGFloat(fontSize)) ?? UIFont()
            cell.label.font = font
            
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    func getIndexPath(index: Int) -> (y: Int, x: Int) {
        var y = 0
        var x = 0
        if self.delegate != nil {
            y = index / self.delegate!.person!.room.x
            x = index - (y * self.delegate!.person!.room.x)
        }
        return (y: y, x: x)
    }
    
}

extension GameViewController: UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        let height = collectionView.bounds.size.height
        let width = collectionView.bounds.size.width
        var result = 0
        if width > height {
            let fontSize = (Int(collectionView.bounds.size.height) / self.delegate!.person!.room.y) - 3
            self.distanceBetwenElements = Int(collectionView.bounds.size.height) - (fontSize * self.delegate!.person!.room.x)
            let distance = self.distanceBetwenElements! / self.delegate!.person!.room.x
            let ost = self.distanceBetwenElements! % self.delegate!.person!.room.x
            result = distance + ost
        } else {
            let fontSize = (Int(collectionView.bounds.size.width) / self.delegate!.person!.room.y) - 3
            self.distanceBetwenElements = Int(collectionView.bounds.size.width) - (fontSize * self.delegate!.person!.room.x)
            let distance = self.distanceBetwenElements! / self.delegate!.person!.room.x
            result = distance-1
        }
        return CGFloat(result)
    }
}
