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

    var requestModel = RequestMaterialModel()
    var requestFormViewModel = RequestFormViewModel()
    var materialRequestModel = RequestModel()
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
        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "StoringProblemInfo"), object: nil, queue: nil) { notification in
            self.materialRequestModel.materialRequest = self.requestModel
            self.requestPersistance.saveRequest(self.materialRequestModel, withDate: Date(), type: "")
            self.removeObserver()
        }
    }
    func removeObserver(){
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "StoringProblemInfo"), object: nil)
    }

    override func nextBtnClicked(sender: UIButton) {
                self.view.endEditing(true)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "MaterialrequestInfoFormVC") as? MaterialrequestInfoFormVC
        viewController?.requestModel = self.requestModel
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
             cell.dateTF.text = requestModel.reporterDate
             cell.reporterNameTF.text = requestModel.reporterName
             cell.landIDTF.text = requestModel.reporterLANID
             cell.sendEnteredData = { value, key in
                     switch key {
                           case .reporterName:
                               self.requestModel.reporterName = value
                            case .reporterDate:
                                self.requestModel.reporterDate = value
                           default:
                               self.requestModel.reporterLANID = value
                           }
                           self.tableView.reloadData()
                        }

            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "RequestDivisionTableViewCell", for: indexPath) as! RequestDivisionTableViewCell
            cell.devisionSelectBtn.addTarget(self, action: #selector(divicisionSelectClicked), for: .touchUpInside)
            cell.dateTF.text = requestModel.divisionDate
            cell.devisionNameTF.text = requestModel.divisionName
            cell.lanIDTF.text = requestModel.divisionLANID
            cell.phoneTF.text = requestModel.divisionPhoneNo
            cell.cellPhoneTF.text = requestModel.divisionCellPhone
            cell.sendEnteredData = { value, key in
                    switch key {
                          case .divisionName:
                              self.requestModel.divisionName = value
                          case .divisionPhoneNo:
                              self.requestModel.divisionPhoneNo = value
                        case .divisionDate:
                        self.requestModel.divisionDate = value
                    case .cellPhoneDivision:
                        self.requestModel.divisionCellPhone = value
                          default:
                              self.requestModel.divisionLANID = value
                          }
                          self.tableView.reloadData()
                       }
            cell.pgeDBtn.addTarget(self, action: #selector(pgeDirectoryClickedForDivision), for: .touchUpInside)
            return cell
        default:
             let cell = tableView.dequeueReusableCell(withIdentifier: "MaterialRequestSuperTableViewCell", for: indexPath) as! MaterialRequestSuperTableViewCell
                    cell.dateTF.text = requestModel.supervisorDate
                    cell.superviorNameTF.text = requestModel.supervisorName
                    cell.lanIDTF.text = requestModel.supervisorLANID
                    cell.phoneTF.text = requestModel.supervisorPhoneNo
                cell.cellPhoneTF.text = requestModel.superVisorCellPhone
             cell.sendEnteredData = { value, key in
                switch key {
                case .supervisorName:
                    self.requestModel.supervisorName = value
                case .supervisorPhoneNo:
                    self.requestModel.supervisorPhoneNo = value
                case .supervisorDate:
                    self.requestModel.supervisorDate = value
                case .cellPhoneSupervisor:
                     self.requestModel.superVisorCellPhone = value
                default:
                    self.requestModel.supervisorLANID = value
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
            self.requestModel.divisionName = value
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
            self.requestModel.supervisorDate = data.name
            self.requestModel.supervisorPhoneNo = data.phone
            self.requestModel.supervisorLANID = data.lanId
            self.tableView.reloadData()
        }
        
    self.navigationController?.pushViewController(viewController!, animated: true)
    }
 @objc func pgeDirectoryClickedForDivision(sender:UIButton){
     let storyboard = UIStoryboard(name: "RequestForm", bundle: nil)
            let viewController = storyboard.instantiateViewController(identifier: "PGEDirectoryViewController") as?
            PGEDirectoryViewController
     viewController?.sendDataback = { data in
         self.requestModel.divisionDate = data.name
         self.requestModel.divisionPhoneNo = data.phone
         self.requestModel.divisionLANID = data.lanId
        self.tableView.reloadData()
         
     }
    self.navigationController?.pushViewController(viewController!, animated: true)
 }

}

