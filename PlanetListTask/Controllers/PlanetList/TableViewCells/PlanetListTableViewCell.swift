//
//  PlanetListTableViewCell.swift
//  PlanetListTask
//
//  Created by Prajakta on 09/05/23.
//

import UIKit

class PlanetListTableViewCell: UITableViewCell {

    @IBOutlet weak var climateLbl: UILabel!
    @IBOutlet weak var planetNameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUpCell(Planet: Planet) {
        self.planetNameLbl.text = Planet.name
        self.climateLbl.text = Planet.climate
    }
    
}
