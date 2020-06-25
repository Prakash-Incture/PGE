//
//  PGEDirectoryTableViewCell.swift
//  PGE-POC
//
//  Created by Naveen Kumar K N on 12/05/20.
//  Copyright © 2020 incture. All rights reserved.
//

import UIKit

class PGEDirectoryTableViewCell: UITableViewCell {

    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var lanId: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
