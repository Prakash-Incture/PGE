//
//  CreateMaterialVC.swift
//  PGE-POC
//
//  Created by PremKumar on 07/05/20.
//  Copyright © 2020 incture. All rights reserved.
//

import UIKit

class CreateMaterialVC: BaseViewController {
    
    let materialArray = ["Electrical Materials", "Electrical Tools", "Electrical Meter"]
    let toolsArray = ["Gas Materials", "Gas Tools", " Gas Meter"]
    let meterArray = ["Sub Station Materials", "Sub Station Tools", "Sub Station Meter"]
    
    var categoryArr = [""]
    var requestPersistance = RequestListCoreData(modelName: "RequestListCoreData")

    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.customNavigationType = .navWithBack
        self.title = "Request List"
        searchBar.backgroundColor = UIColor.white
        searchBar.layer.cornerRadius = 8
        searchBar.clipsToBounds = true
        // Set current category array
        let currentCategory = CategorySigleton.shared.categoryName
        switch currentCategory {
        case .Material:
            categoryArr = materialArray
        case .Tools:
            categoryArr = toolsArray
        case .Meter:
            categoryArr = meterArray
        case .Report:
            debugPrint("Nothing to load")
        case .none:
            debugPrint("Nothing to load")
        }
    }
    
    override func selectedBack(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension CreateMaterialVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 53+12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CreateMaterialCell") as? CreateMaterialCell{
            cell.titleLbl.text = categoryArr[indexPath.row]
            if indexPath.row == 0{
                cell.imgVw.image = UIImage(named: "ele")
            }else if indexPath.row == 1{
                cell.imgVw.image = UIImage(named: "gas1")
            }else{
                cell.imgVw.image = UIImage(named: "substation")
            }
            return cell
        }else{
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "MaterialRequestFormVC") as? MaterialRequestFormVC
        viewController?.title = categoryArr[indexPath.row]
        APP_DELEGATE.title = categoryArr[indexPath.row]
        viewController?.requestPersistance = self.requestPersistance
        self.navigationController?.pushViewController(viewController!, animated: true)
    }
    
}

