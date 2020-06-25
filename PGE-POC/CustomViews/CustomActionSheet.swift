//
//  CustomActionSheet.swift
//  PGE-POC
//
//  Created by PremKumar on 11/05/20.
//  Copyright © 2020 incture. All rights reserved.
//

import UIKit

class CustomActionSheet: UIView {

    @IBOutlet weak var showAndHideBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var actionSheetData: [ActionSheetDataModel] = [ActionSheetDataModel(title: "Reporter Info", iconImage: "reporterInfo", isSelected: false), ActionSheetDataModel(title: "Material Info", iconImage: "materialInfo", isSelected: false), ActionSheetDataModel(title: "Problem Info", iconImage: "problemInfo", isSelected: false)]
    
    var returnSelectedIndex : ((Int)->())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNib()
    }
    
    func loadNib() {
//        tableView.register(UINib(nibName: "CustomActionSheetCell", bundle: nil), forCellReuseIdentifier: "CustomActionSheetCell") as! CustomActionSheetCell
    }
}

struct ActionSheetDataModel {
    var title: String?
    var iconImage: String?
    var isSelected: Bool?
}


extension CustomActionSheet: UITableViewDelegate, UITableViewDataSource{
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
        
        if actionSheetData[indexPath.row].isSelected == true{
            cell.setSelected(true, animated: true)
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.returnSelectedIndex!(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    }
}

