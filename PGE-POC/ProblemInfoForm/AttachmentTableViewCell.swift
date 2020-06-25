//
//  AttachmentTableViewCell.swift
//  PGE-POC
//
//  Created by Naveen Kumar K N on 09/05/20.
//  Copyright © 2020 incture. All rights reserved.
//

import UIKit

class AttachmentTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        let nib = UINib(nibName: "ThumbnailImageCollectionViewCell", bundle: nil)
             collectionView?.register(nib, forCellWithReuseIdentifier: "ThumbnailImageCollectionViewCell")
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
