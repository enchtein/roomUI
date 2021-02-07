//
//  GameTableViewCell.swift
//  game v3.0
//
//  Created by enchtein on 04.02.2021.
//

import UIKit

class GameTableViewCell: UITableViewCell {
    
//    var delegate: PropertiesViewController?
    private var userProperties: Properties?

    @IBOutlet weak var propertyName: UILabel!
    @IBOutlet weak var propertyValue: UITextField!
    
    func setupCell(with model: Properties) {
        self.userProperties = model
        self.propertyName.text = self.userProperties?.name
        self.propertyValue.text = String(self.userProperties?.value ?? 0)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
