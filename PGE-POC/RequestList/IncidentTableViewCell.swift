//
//  IncidentTableViewCell.swift
//  SDGE Near Miss
//
//  Created by Ujwal K Raikar on 10/10/19.
//  Copyright © 2019 Incture. All rights reserved.
//

import UIKit

class IncidentTableViewCell: UITableViewCell {

    
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var colorStackView: UIView!
    @IBOutlet weak var incidentNumberLabel: UILabel!
    @IBOutlet weak var reportedTimeLabel: UILabel!
    @IBOutlet weak var closeCallCatLabel: UILabel!
    @IBOutlet weak var closeCallCatValueLabel: UILabel!
    @IBOutlet weak var impactCatLabel: UILabel!
    @IBOutlet weak var impactCatValueLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var dateTimeValueLabel: UILabel!
    @IBOutlet weak var attachmentImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
