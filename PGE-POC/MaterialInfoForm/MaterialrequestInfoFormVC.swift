//
//  MaterialrequestInfoFormVC.swift
//  PGE-POC
//
//  Created by Naveen Kumar K N on 08/05/20.
//  Copyright © 2020 incture. All rights reserved.
//

import UIKit

class MaterialrequestInfoFormVC: BaseViewController {
    
    var requestModel = RequestMaterialModel()
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var materialViewModel: MaterialInfoViewModel?
    var materialInfoModel = MaterialInfoModel()
    
    override func viewDidLoad() {
        // Load custom action sheet
        self.showSheetStatus = true
        
        super.viewDidLoad()
        customNavigationType = .naveWithNext
        materialViewModel = MaterialInfoViewModel(info: materialInfoModel)
        tableView.register(UINib(nibName: "CommonKeyValueCell", bundle: nil), forCellReuseIdentifier: "CommonKeyValueCell")
        tableView.register(UINib(nibName: "KeySwitchCell", bundle: nil), forCellReuseIdentifier: "KeySwitchCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.customView.actionSheetData = [ActionSheetDataModel(title: "Reporter Info", iconImage: "reporterInfo", isSelected: true), ActionSheetDataModel(title: "Material Info", iconImage: "materialInfo", isSelected: true), ActionSheetDataModel(title: "Problem Info", iconImage: "problemInfo", isSelected: false)]
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.endEditing(true)
    }
    
//    override func selectedBack(sender: UIButton) {
//        self.navigationController?.popViewController(animated: true)
//    }
    override func nextBtnClicked(sender: UIButton) {
               self.view.endEditing(true)
         let storyboard = UIStoryboard(name: "Main", bundle: nil)
         let viewController = storyboard.instantiateViewController(identifier: "ProblemInfoViewController") as? ProblemInfoViewController
         viewController?.title = self.title
         self.navigationController?.pushViewController(viewController!, animated: true)
    }
}

extension MaterialrequestInfoFormVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return materialViewModel?.dataArr.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cellDetails = materialViewModel?.dataArr[indexPath.row] else { return UITableViewCell()}
        
        switch cellDetails.type {
        case .materialCode, .materialDesc, .manufactureSerialNo, .purchaseOrder, .leakNumber, .leakGrade:
            return getKeyValueCell(data: cellDetails)
        case .manufacturer, .materialType, .age, .application, .systemPressure, .soilType:
            return getKeyValueDisclosureCell(data: cellDetails)
        case .outage, .failedInService, .grade1Failure:
            return getkeySwitchCell(data: cellDetails)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cellDetails = materialViewModel?.dataArr[indexPath.row]{
            switch cellDetails.type {
            case .manufacturer, .materialType, .age, .application, .systemPressure, .soilType:
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let viewController = storyboard.instantiateViewController(identifier: "SelectionViewController") as?
                    SelectionViewController
                
                switch cellDetails.type {
                case .manufacturer:
                    viewController?.title = "Select Manufacturer"
                    viewController?.dataArray = MaterialInfoLookUps.manufacturer
                case .materialType:
                    viewController?.title = "Select Material Type"

                    viewController?.dataArray = MaterialInfoLookUps.materialType
                case .age:
                    viewController?.title = "Select Age"

                    viewController?.dataArray = MaterialInfoLookUps.age
                case .application:
                    viewController?.title = "Select Application"

                    viewController?.dataArray = MaterialInfoLookUps.application
                case .systemPressure:
                    viewController?.title = "Select System Pressure"

                    viewController?.dataArray = MaterialInfoLookUps.systemPressure
                case .soilType:
                    viewController?.title = "Select Soil Type"
                    viewController?.dataArray = MaterialInfoLookUps.soilType
                default:
                      print("Nothing to do")
                }
                
                    viewController?.returnSelectedValue = { value in
//                        self.requestModel.divisionName = value
//                        self.tableView.reloadData()
                        if let cell = tableView.cellForRow(at: indexPath) as? CommonKeyValueCell{
                            cell.valueTF.text = value
                        }
                        
                    }
                    self.navigationController?.pushViewController(viewController!, animated: true)
            
            default:
                print("Nothing to do")
            }
        }
    }
    
    func getKeyValueCell(data: MaterialInfoItem) -> CommonKeyValueCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CommonKeyValueCell") as? CommonKeyValueCell{
            cell.titleLbl.text = data.key
            cell.valueTF.rightDrawable = nil
            cell.imgVW.isHidden = true
            cell.valueTF.placeholder = data.type == .materialCode ? "MXXXXXX" : "Type here"
            cell.valueTF.text = data.value
            return cell
        }else{
            return CommonKeyValueCell()
        }
    }
    
    func getKeyValueDisclosureCell(data: MaterialInfoItem) -> CommonKeyValueCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CommonKeyValueCell") as? CommonKeyValueCell{
            cell.titleLbl.text = data.key
             cell.imgVW.isHidden = false
           // cell.valueTF.placeholder = "Select  "
           // cell.valueTF.rightDrawable = UIImage(named: "moreArrow")
            cell.valueTF.isUserInteractionEnabled = false
            return cell
        }else{
            return CommonKeyValueCell()
        }
    }
    
    func getkeySwitchCell(data: MaterialInfoItem) -> KeySwitchCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "KeySwitchCell") as? KeySwitchCell{
            cell.titleLbl.text = data.key
            return cell
        }else{
            return KeySwitchCell()
        }
    }
}
