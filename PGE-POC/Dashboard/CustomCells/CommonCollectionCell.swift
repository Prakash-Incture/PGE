//
//  CommonCollectionCell.swift
//  CoreAnimationSamples
//
//  Created by PremKumar on 06/05/20.
//  Copyright © 2020 Prem. All rights reserved.
//

import UIKit

class CommonCollectionCell: UICollectionViewCell {

    @IBOutlet weak var contentBackView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        contentBackView.dropShadow()
        contentBackView.layer.cornerRadius = 8.0
    }

}
