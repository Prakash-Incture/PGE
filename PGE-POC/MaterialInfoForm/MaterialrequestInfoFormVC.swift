//
//  MaterialrequestInfoFormVC.swift
//  PGE-POC
//
//  Created by Naveen Kumar K N on 08/05/20.
//  Copyright © 2020 incture. All rights reserved.
//

import UIKit

class MaterialrequestInfoFormVC: BaseViewController {
    
//    var requestModel = RequestMaterialModel()
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var materialViewModel: MaterialInfoViewModel?
    var materialInfoModel = MaterialInfoModel()
    var mainRequestModel : RequestModel?
    var requestPersistance : RequestListCoreData?

    
    override func viewDidLoad() {
        // Load custom action sheet
        self.showSheetStatus = true
        
        super.viewDidLoad()
        customNavigationType = .naveWithNext
        materialViewModel = MaterialInfoViewModel(info: materialInfoModel)
        tableView.register(UINib(nibName: "CommonKeyValueCell", bundle: nil), forCellReuseIdentifier: "CommonKeyValueCell")
        tableView.register(UINib(nibName: "KeySwitchCell", bundle: nil), forCellReuseIdentifier: "KeySwitchCell")
        observeTheNotificationData()
        
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
    
    func observeTheNotificationData(){
        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "StoringMaterialInfo"), object: nil, queue: nil) { notification in
            self.mainRequestModel?.materialInfo = self.materialInfoModel
            self.requestPersistance?.saveRequest(self.mainRequestModel!, withDate: Date(), type: "")
            self.removeObserver()
        }
    }
    
    func removeObserver(){
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "StoringMaterialInfo"), object: nil)
    }
    
    override func nextBtnClicked(sender: UIButton) {
               self.view.endEditing(true)
         let storyboard = UIStoryboard(name: "Main", bundle: nil)
         let viewController = storyboard.instantiateViewController(identifier: "ProblemInfoViewController") as? ProblemInfoViewController
        viewController?.mainRequestModel = self.mainRequestModel
        viewController?.requestPersistance = self.requestPersistance
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
            return getKeyValueCell(data: cellDetails, indexPath : indexPath)
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
                            
                            switch cellDetails.type {
                            case .manufacturer:
                                self.materialInfoModel.manufacturer = value
                            case .materialType:
                                self.materialInfoModel.materialType = value
                            case .age:
                                self.materialInfoModel.age = value
                            case .application:
                                self.materialInfoModel.application = value
                            case .systemPressure:
                                self.materialInfoModel.systemPressure = value
                            case .soilType:
                                self.materialInfoModel.soilType = value
                            default:
                                return
                            }
                            
                        }
                        
                    }
                    self.navigationController?.pushViewController(viewController!, animated: true)
            
            default:
                print("Nothing to do")
            }
        }
    }
    
    func getKeyValueCell(data: MaterialInfoItem, indexPath: IndexPath) -> CommonKeyValueCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CommonKeyValueCell") as? CommonKeyValueCell{
            cell.titleLbl.text = data.key
            cell.valueTF.rightDrawable = nil
            cell.imgVW.isHidden = true
            cell.valueTF.placeholder = data.type == .materialCode ? "MXXXXXX" : "Type here"
//            cell.valueTF.text = data.value
            cell.valueTF.delegate = self
            cell.valueTF.tag = indexPath.row
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
            
            switch data.type {
            case .outage:
                self.materialInfoModel.outage = cell.toggleSwitch.isOn ? "Yes" : "No"
            case .failedInService:
                self.materialInfoModel.failedInService = cell.toggleSwitch.isOn ? "Yes" : "No"
            case .grade1Failure:
                self.materialInfoModel.grade1Failure = cell.toggleSwitch.isOn ? "Yes" : "No"
            default:
                return KeySwitchCell()
            }
            
            return cell
        }else{
            return KeySwitchCell()
        }
    }
}

extension MaterialrequestInfoFormVC: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
//        for value in materialViewModel?.dataArr ?? [] {
//
//            switch value.type {
//            case .materialCode:
//                self.materialInfoModel.materialCode = textField.text!
//            case .materialDesc:
//                self.materialInfoModel.materialDesc = textField.text!
//            case .manufactureSerialNo:
//                self.materialInfoModel.manufactureSerialNo = textField.text!
//            case .purchaseOrder:
//                self.materialInfoModel.purchaseOrder = textField.text!
//            case .leakNumber:
//                self.materialInfoModel.leakNumber = textField.text!
//            case .leakGrade:
//                self.materialInfoModel.leakGrade = textField.text!
//            default:
//                return
//            }
//
//        }
        
        switch textField.tag {
        case 0:
            self.materialInfoModel.materialCode = textField.text!
        case 5:
            self.materialInfoModel.materialDesc = textField.text!
        case 6:
            self.materialInfoModel.manufactureSerialNo = textField.text!
        case 7:
            self.materialInfoModel.purchaseOrder = textField.text!
        case 11:
            self.materialInfoModel.leakNumber = textField.text!
        case 12:
            self.materialInfoModel.leakGrade = textField.text!
        default:
            return
        }


    }
}
