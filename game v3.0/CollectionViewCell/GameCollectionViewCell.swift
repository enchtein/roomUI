//
//  GameCollectionViewCell.swift
//  game v3.0
//
//  Created by enchtein on 04.02.2021.
//

import UIKit

class GameCollectionViewCell: UICollectionViewCell {
    var delegate: GameViewController?

    @IBOutlet weak var label: UILabel!
    
    func setupCell() {
//        self.constraints
        self.label.text = self.delegate?.delegate?.person?.strUiMass[0][0]
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
