//
//  MaterialRequestFormVC.swift
//  PGE-POC
//
//  Created by PremKumar on 07/05/20.
//  Copyright © 2020 incture. All rights reserved.
//

import UIKit

class MaterialRequestFormVC: BaseViewController {
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var tableView: UITableView!

    var requestMaterialModel = RequestMaterialModel()
    var requestFormViewModel = RequestFormViewModel()
    var mainRequestModel = RequestModel()
    var requestPersistance = RequestListCoreData(modelName: "RequestListCoreData")

    override func viewDidLoad() {
        // Load custom action sheet
        self.showSheetStatus = true
        
        super.viewDidLoad()
        self.customNavigationType = .naveWithNext
        self.tableView?.register(UINib(nibName: "MaterialRequestTableViewCell", bundle: nil), forCellReuseIdentifier: "MaterialRequestTableViewCell")
             self.tableView?.register(UINib(nibName: "RequestDivisionTableViewCell", bundle: nil), forCellReuseIdentifier: "RequestDivisionTableViewCell")
         self.tableView?.register(UINib(nibName: "MaterialRequestSuperTableViewCell", bundle: nil), forCellReuseIdentifier: "MaterialRequestSuperTableViewCell")
        self.observeTheNotificationData()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.customView.actionSheetData = [ActionSheetDataModel(title: "Reporter Info", iconImage: "reporterInfo", isSelected: true), ActionSheetDataModel(title: "Material Info", iconImage: "materialInfo", isSelected: false), ActionSheetDataModel(title: "Problem Info", iconImage: "problemInfo", isSelected: false)]
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.endEditing(true)
    }
    func observeTheNotificationData(){
        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "StoringRequestInfo"), object: nil, queue: nil) { notification in
            self.mainRequestModel.materialRequest = self.requestMaterialModel
            self.requestPersistance.saveRequest(self.mainRequestModel, withDate: Date(), type: "")
            self.removeObserver()
        }
    }
    func removeObserver(){
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "StoringRequestInfo"), object: nil)
    }

    override func nextBtnClicked(sender: UIButton) {
                self.view.endEditing(true)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "MaterialrequestInfoFormVC") as? MaterialrequestInfoFormVC
//        viewController?.requestModel = self.requestMaterialModel
        viewController?.mainRequestModel = self.mainRequestModel
        viewController?.requestPersistance = self.requestPersistance
        viewController?.title = self.title

        self.navigationController?.pushViewController(viewController!, animated: true)

    }
    
}

extension MaterialRequestFormVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        switch indexPath.row {
        case 0:
             let cell = tableView.dequeueReusableCell(withIdentifier: "MaterialRequestTableViewCell", for: indexPath) as! MaterialRequestTableViewCell
             cell.dateTF.text = requestMaterialModel.reporterDate
             cell.reporterNameTF.text = requestMaterialModel.reporterName
             cell.landIDTF.text = requestMaterialModel.reporterLANID
             cell.sendEnteredData = { value, key in
                     switch key {
                           case .reporterName:
                               self.requestMaterialModel.reporterName = value
                            case .reporterDate:
                                self.requestMaterialModel.reporterDate = value
                           default:
                               self.requestMaterialModel.reporterLANID = value
                           }
                           self.tableView.reloadData()
                        }

            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "RequestDivisionTableViewCell", for: indexPath) as! RequestDivisionTableViewCell
            cell.devisionSelectBtn.addTarget(self, action: #selector(divicisionSelectClicked), for: .touchUpInside)
            cell.dateTF.text = requestMaterialModel.divisionDate
            cell.devisionNameTF.text = requestMaterialModel.divisionName
            cell.lanIDTF.text = requestMaterialModel.divisionLANID
            cell.phoneTF.text = requestMaterialModel.divisionPhoneNo
            cell.cellPhoneTF.text = requestMaterialModel.divisionCellPhone
            cell.sendEnteredData = { value, key in
                    switch key {
                          case .divisionName:
                              self.requestMaterialModel.divisionName = value
                          case .divisionPhoneNo:
                              self.requestMaterialModel.divisionPhoneNo = value
                        case .divisionDate:
                        self.requestMaterialModel.divisionDate = value
                    case .cellPhoneDivision:
                        self.requestMaterialModel.divisionCellPhone = value
                          default:
                              self.requestMaterialModel.divisionLANID = value
                          }
                          self.tableView.reloadData()
                       }
            cell.pgeDBtn.addTarget(self, action: #selector(pgeDirectoryClickedForDivision), for: .touchUpInside)
            return cell
        default:
             let cell = tableView.dequeueReusableCell(withIdentifier: "MaterialRequestSuperTableViewCell", for: indexPath) as! MaterialRequestSuperTableViewCell
                    cell.dateTF.text = requestMaterialModel.supervisorDate
                    cell.superviorNameTF.text = requestMaterialModel.supervisorName
                    cell.lanIDTF.text = requestMaterialModel.supervisorLANID
                    cell.phoneTF.text = requestMaterialModel.supervisorPhoneNo
                cell.cellPhoneTF.text = requestMaterialModel.superVisorCellPhone
             cell.sendEnteredData = { value, key in
                switch key {
                case .supervisorName:
                    self.requestMaterialModel.supervisorName = value
                case .supervisorPhoneNo:
                    self.requestMaterialModel.supervisorPhoneNo = value
                case .supervisorDate:
                    self.requestMaterialModel.supervisorDate = value
                case .cellPhoneSupervisor:
                     self.requestMaterialModel.superVisorCellPhone = value
                default:
                    self.requestMaterialModel.supervisorLANID = value
                }
                self.tableView.reloadData()
             }
             cell.pgeDBtn.addTarget(self, action: #selector(pgeDirectoryClicked), for: .touchUpInside)

            return cell
        }
               
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 150
        case 1:
            return 320
        default:
            return 290
        }
    }
}

extension MaterialRequestFormVC{
    
    @objc func divicisionSelectClicked(sender:UIButton){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "SelectionViewController") as?
        SelectionViewController
        viewController?.returnSelectedValue = { value in
            self.requestMaterialModel.divisionName = value
            self.tableView.reloadData()
        }
        viewController?.title = "Select Division/Dept"
        viewController?.dataArray = ["Installation","Inspection","Maintenance"]
        self.navigationController?.pushViewController(viewController!, animated: true)
    }
    @objc func pgeDirectoryClicked(sender:UIButton){
        let storyboard = UIStoryboard(name: "RequestForm", bundle: nil)
               let viewController = storyboard.instantiateViewController(identifier: "PGEDirectoryViewController") as?
               PGEDirectoryViewController
        
        viewController?.sendDataback = { data in
            self.requestMaterialModel.supervisorDate = data.name
            self.requestMaterialModel.supervisorPhoneNo = data.phone
            self.requestMaterialModel.supervisorLANID = data.lanId
            self.tableView.reloadData()
        }
        
    self.navigationController?.pushViewController(viewController!, animated: true)
    }
 @objc func pgeDirectoryClickedForDivision(sender:UIButton){
     let storyboard = UIStoryboard(name: "RequestForm", bundle: nil)
            let viewController = storyboard.instantiateViewController(identifier: "PGEDirectoryViewController") as?
            PGEDirectoryViewController
     viewController?.sendDataback = { data in
         self.requestMaterialModel.divisionDate = data.name
         self.requestMaterialModel.divisionPhoneNo = data.phone
         self.requestMaterialModel.divisionLANID = data.lanId
        self.tableView.reloadData()
         
     }
    self.navigationController?.pushViewController(viewController!, animated: true)
 }

}

