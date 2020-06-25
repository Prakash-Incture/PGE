//
//  CommonKeyValueCell.swift
//  PGE-POC
//
//  Created by PremKumar on 07/05/20.
//  Copyright © 2020 incture. All rights reserved.
//

import UIKit

class CommonKeyValueCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var valueTF: ICTextField!
    @IBOutlet weak var imgVW: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        valueTF.placeholder = ""
        //valueTF.rightDrawable = UIImage(named: "moreArrow")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension CommonKeyValueCell: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
