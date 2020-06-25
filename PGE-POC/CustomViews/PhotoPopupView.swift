//
//  PhotoPopupView.swift
//  PGE-POC
//
//  Created by Naveen Kumar K N on 13/05/20.
//  Copyright © 2020 incture. All rights reserved.
//

import UIKit

class PhotoPopupView: UIView {

    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var actionSheetData: [ActionSheetDataModel] = [ActionSheetDataModel(title: "Photo Library", iconImage: "imageGallery", isSelected: false), ActionSheetDataModel(title: "Take Photo", iconImage: "Photo", isSelected: false), ActionSheetDataModel(title: "Files", iconImage: "file", isSelected: false)]
    var returnSelectedIndex : ((Int)->())?
    override init(frame: CGRect) {
          super.init(frame: frame)
      }
      
      required init?(coder: NSCoder) {
          super.init(coder: coder)
      }
}
extension PhotoPopupView: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actionSheetData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.selectionStyle = .none
        cell.textLabel?.text = actionSheetData[indexPath.row].title
        cell.imageView?.image = UIImage(named: actionSheetData[indexPath.row].iconImage!)
        
//        if actionSheetData[indexPath.row].isSelected == true{
//            cell.setSelected(true, animated: true)
//            cell.accessoryType = .checkmark
//        }else{
            cell.accessoryType = .none
     //   }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.returnSelectedIndex!(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    }
}
