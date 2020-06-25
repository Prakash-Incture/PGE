//
//  DashboardTableViewCell.swift
//  PGE-POC
//
//  Created by Naveen Kumar K N on 11/05/20.
//  Copyright © 2020 incture. All rights reserved.
//

import UIKit

class DashboardTableViewCell: UITableViewCell {
    @IBOutlet weak var imgVw: UIImageView!
    
    @IBOutlet weak var titleLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
