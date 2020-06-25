//
//  Custom1TableViewCell.swift
//  PGE
//
//  Created by Suraj on 07/05/20.
//  Copyright © 2020 Suraj. All rights reserved.
//

import UIKit

class KeySwitchCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var toggleSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
