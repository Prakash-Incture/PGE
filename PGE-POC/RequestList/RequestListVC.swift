//
//  RequestListVC.swift
//  PGE-POC
//
//  Created by PremKumar on 07/05/20.
//  Copyright © 2020 incture. All rights reserved.
//

import UIKit

class RequestListVC: BaseViewController,UISearchBarDelegate {

    @IBOutlet weak var statusSegmentControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var createBtn: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var buttonWidth: NSLayoutConstraint!
    @IBOutlet weak var buttonHeight: NSLayoutConstraint!
    
    var originalModel = [GetIncidentModelData]()
    var model = [GetIncidentModelData]()
    var segmentModel = [GetIncidentModelData]()
    var inProgressrequests = [RequestMaterialModel]()
    var requestPersistance = RequestListCoreData(modelName: "RequestListCoreData")

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadOfflineStores()
        createBtn.layer.cornerRadius = createBtn.frame.width/2
        self.customNavigationType = .navWithFilter
        self.title = "Request List"
        searchBar.backgroundColor = UIColor.white
        searchBar.layer.cornerRadius = 8
        searchBar.clipsToBounds = true
        searchBar.delegate = self
        self.tableView?.register(UINib(nibName: "IncidentTableViewCell", bundle: nil), forCellReuseIdentifier: "IncidentTableViewCell")
        
        // Segment control attributes
//        statusSegmentControl.ensureiOS12Style()
        var size = 14.0
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            size = 14.0
        case .pad:
            size = 22.0
            buttonWidth.constant = 80
            buttonHeight.constant = 80
            createBtn.layer.cornerRadius  = buttonWidth.constant/2
        default:
            size = 14.0
        }
        let font = UIFont.systemFont(ofSize: CGFloat(size))
        statusSegmentControl.setTitleTextAttributes([.foregroundColor: UIColor.white,NSAttributedString.Key.font : font], for: .normal)
        statusSegmentControl.setTitleTextAttributes([.foregroundColor: UIColor(rgb: 0x042037)], for: .selected)
        statusSegmentControl.selectedSegmentIndex = 0
        
        addDatatoModelArr()

    }
    
    override func selectedBack(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func createBtnTapped(_ sender: Any) {
        navigateToCreateVC()
    }
    
    // Segment control action
    @IBAction func statusSegmentTapped(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            //In progress list
            self.segmentModel = self.originalModel.filter{($0.status?.contains("Open") ?? false)}
            self.model = self.segmentModel
        case 1:
            // Open list
            self.segmentModel = self.originalModel.filter{($0.status?.contains("In Process") ?? false)}
            self.loadOfflineData()
            self.model = self.segmentModel
        case 2:
            // Completed list
            self.segmentModel = self.originalModel.filter{($0.status?.contains("Completed") ?? false)}
            self.model = self.segmentModel
        default:
            debugPrint("No incident")
        }
        tableView.reloadData()
    }
    //Load Offline Data
    func loadOfflineData(){
        if let getResult = requestPersistance.fetchAllData() as? [RequestList]{
            self.inProgressrequests.removeAll()
            for model in getResult{
                let test = self.requestPersistance.unarchive(incident:model.requestModel!) as? RequestModel
                self.inProgressrequests.append(test?.materialRequest ?? RequestMaterialModel())
                print(test as Any)
            }
        }
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.resignFirstResponder()
        return true
    }

    func searchBar(_ searchBar: UISearchBar,
                   textDidChange searchText: String){
        if searchText == "" {
                self.model = self.segmentModel
                   searchBar.text = ""
                   searchBar.resignFirstResponder()
                   self.tableView.reloadData()
          }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.model = self.segmentModel
        searchBar.text = ""
        searchBar.resignFirstResponder()
        self.tableView.reloadData()
    }
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        
        
        let currentString: NSString = searchBar.text! as NSString
           let newString: NSString = currentString.replacingCharacters(in: range, with: text) as NSString
//           if searchKeyData.count > 0{
            self.model = self.segmentModel.filter{($0.incident_id?.contains("\(newString)"))! || ($0.landID?.contains("\(newString)"))! || ($0.status?.contains("\(newString)"))! || ($0.location?.contains("\(newString)"))!}
            self.tableView.reloadData()

      //  }
        
//
        if newString == ""{
            self.model = self.segmentModel
            self.tableView.reloadData()
             return true
        }
//        if searchBar.text?.count ?? 0 > 2{
//
//        }
        return true
    }
    func addDatatoModelArr(){
      var obj =  GetIncidentModelData()
        obj.incident_id = "INX255128A"
        obj.status = "Completed"
        obj.incident_logged_time = "19 Apr ‘20, 09:15 PM"
        obj.landID = "LAN ID : EMP_12"
        obj.location = "Location : Plant T9A"
        obj.materialName = "Material : Electrical Material Information"
        obj.incId = "M"
        self.model.append(obj)
        obj.incident_id = "INX255128A"
             obj.status = "Completed"
             obj.incident_logged_time = "19 Apr ‘20, 09:15 PM"
             obj.landID = "LAN ID : EMP_12"
             obj.location = "Location : Plant T9A"
             obj.materialName = "Material : Electrical Material Information"
             obj.incId = "M"
             self.model.append(obj)
        obj.incident_id = "INX255128A"
             obj.status = "Completed"
             obj.incident_logged_time = "19 Apr ‘20, 09:15 PM"
             obj.landID = "LAN ID : EMP_12"
             obj.location = "Location : Plant T9A"
             obj.materialName = "Material : Electrical Material Information"
             obj.incId = "M"
             self.model.append(obj)
        obj.incident_id = "INX255128A"
             obj.status = "Completed"
             obj.incident_logged_time = "19 Apr ‘20, 09:15 PM"
             obj.landID = "LAN ID : EMP_12"
             obj.location = "Location : Plant T9A"
             obj.materialName = "Material : Electrical Material Information"
             obj.incId = "M"
             self.model.append(obj)
        obj.incident_id = "INX255128A"
             obj.status = "Completed"
             obj.incident_logged_time = "19 Apr ‘20, 09:15 PM"
             obj.landID = "LAN ID : EMP_12"
             obj.location = "Location : Plant T9A"
             obj.materialName = "Material : Electrical Material Information"
             obj.incId = "M"
             self.model.append(obj)
        obj.incident_id = "MIR375118C"
          obj.status = "In Process"
          obj.incident_logged_time = "1 Apr ‘20, 09:15 PM"
          obj.landID = "LAN ID : EMP_11"
          obj.location = "Location : Plant GT8"
          obj.materialName = "Material : Gas Material Information"
          obj.incId = "M"
        self.model.append(obj)
        obj.incident_id = "MIR375118C"
                obj.status = "In Process"
                obj.incident_logged_time = "1 Apr ‘20, 09:15 PM"
                obj.landID = "LAN ID : EMP_11"
                obj.location = "Location : Plant GT8"
                obj.materialName = "Material : Gas Material Information"
                obj.incId = "M"
              self.model.append(obj)
        obj.incident_id = "MIR375118C"
                obj.status = "In Process"
                obj.incident_logged_time = "1 Apr ‘20, 09:15 PM"
                obj.landID = "LAN ID : EMP_11"
                obj.location = "Location : Plant GT8"
                obj.materialName = "Material : Gas Material Information"
                obj.incId = "M"
              self.model.append(obj)
        obj.incident_id = "MIR375118C"
                obj.status = "In Process"
                obj.incident_logged_time = "1 Apr ‘20, 09:15 PM"
                obj.landID = "LAN ID : EMP_11"
                obj.location = "Location : Plant GT8"
                obj.materialName = "Material : Gas Material Information"
                obj.incId = "M"
              self.model.append(obj)
        obj.incident_id = "INX346958A"
        obj.status = "Completed"
        obj.incident_logged_time = "9 Apr ‘20, 07:15 PM"
        obj.landID = "LAN ID : EMP_01"
        obj.location = "Location : Plant TA5"
        obj.materialName = "Tool: Sub Station Information"
        obj.incId = "T"
        self.model.append(obj)
          obj.incident_id = "MIR184988C"
        obj.status = "Open"
        obj.incident_logged_time = "18 Mar ‘20, 08:00 PM"
        obj.landID = "LAN ID : EMP_90"
        obj.location = "Location : Plant T9A"
        obj.materialName = "Material : Electrical Problem Information"
        obj.incId = "M"
        self.model.append(obj)
        obj.incident_id = "MIR184988C"
           obj.status = "Open"
           obj.incident_logged_time = "18 Mar ‘20, 08:00 PM"
           obj.landID = "LAN ID : EMP_90"
           obj.location = "Location : Plant T9A"
           obj.materialName = "Material : Electrical Problem Information"
           obj.incId = "M"
           self.model.append(obj)
        obj.incident_id = "MIR184988C"
           obj.status = "Open"
           obj.incident_logged_time = "18 Mar ‘20, 08:00 PM"
           obj.landID = "LAN ID : EMP_93"
           obj.location = "Location : Plant T9A"
           obj.materialName = "Material : Electrical Problem Information"
           obj.incId = "M"
           self.model.append(obj)
        obj.incident_id = "MIR184988C"
           obj.status = "Open"
           obj.incident_logged_time = "18 Mar ‘20, 08:00 PM"
           obj.landID = "LAN ID : EMP_92"
           obj.location = "Location : Plant T9A"
           obj.materialName = "Material : Electrical Problem Information"
           obj.incId = "M"
           self.model.append(obj)
        obj.incident_id = "MIR184988C"
           obj.status = "Open"
           obj.incident_logged_time = "18 Mar ‘20, 08:00 PM"
           obj.landID = "LAN ID : EMP_91"
           obj.location = "Location : Plant T9A"
           obj.materialName = "Material : Electrical Problem Information"
           obj.incId = "M"
           self.model.append(obj)
        obj.incident_id = "MIR184988C"
                 obj.status = "Open"
                 obj.incident_logged_time = "18 Mar ‘20, 08:00 PM"
                 obj.landID = "LAN ID : EMP_95"
                 obj.location = "Location : Plant T9A"
                 obj.materialName = "Material : Electrical Problem Information"
                 obj.incId = "M"
                 self.model.append(obj)
          obj.incident_id = "MIR184988C"
        obj.status = "In Process"
        obj.incident_logged_time = "19 Mar ‘20, 08:00 PM"
        obj.landID = "LAN ID : EMP_80"
        obj.location = "Location : Plant T129A"
        obj.materialName = "Material : Electrical Problem Information"
        obj.incId = "M"
        self.model.append(obj)
    obj.incident_id = "INX346678D"
      obj.status = "Completed"
      obj.incident_logged_time = "18 Mar ‘20, 07:50 PM"
      obj.landID = "LAN ID : EMP_51"
      obj.location = "Location : Plant TA8"
      obj.materialName = "Meter: Sub Station Information"
      obj.incId = "ME"
      self.model.append(obj)
        obj.incident_id = "INX346678D"
        obj.status = "Completed"
        obj.incident_logged_time = "18 Mar ‘20, 07:50 PM"
        obj.landID = "LAN ID : EMP_11"
        obj.location = "Location : Plant TA5"
        obj.materialName = "Meter: Sub Station Information"
        obj.incId = "ME"
        self.model.append(obj)
          obj.incident_id = "MIR184988C"
          obj.status = "In Process"
          obj.incident_logged_time = "18 Mar ‘20, 07:50 PM"
          obj.landID = "LAN ID : EMP_20"
          obj.location = "Location : Plant TM5"
          obj.materialName = "Tool: Gas Reporter Information"
          obj.incId = "T"
          self.model.append(obj)
        obj.incident_id = "METERIX346958A"
              obj.status = "In Process"
              obj.incident_logged_time = "17 Mar ‘20, 07:50 PM"
              obj.landID = "LAN ID : EMP_011"
              obj.location = "Location : Plant METR5"
              obj.materialName = "Meter: Gas Information"
              obj.incId = "ME"
        self.model.append(obj)
        obj.incident_id = "METERIR184988C"
           obj.status = "Open"
           obj.incident_logged_time = "16 Mar ‘20, 08:00 PM"
           obj.landID = "LAN ID : EMP_23"
           obj.location = "Location : Plant TMER9A"
           obj.materialName = "Meter : Electrical Problem Information"
           obj.incId = "ME"
           self.model.append(obj)
        obj.incident_id = "MIX346958A"
        obj.status = "Completed"
        obj.incident_logged_time = "18 Mar ‘20, 07:50 PM"
        obj.landID = "LAN ID : EMP_01"
        obj.location = "Location : Plant MT5"
        obj.materialName = "Meter: Gas Information"
        obj.incId = "ME"
        self.model.append(obj)
        obj.incident_id = "MIX346234958A"
        obj.status = "Open"
        obj.incident_logged_time = "13 Mar ‘20, 07:50 PM"
        obj.landID = "LAN ID : EMP_21"
        obj.location = "Location : Plant TAE95"
        obj.materialName = "Tool: Sub Station Information"
        obj.incId = "T"
        self.model.append(obj)
        obj.incident_id = "MIX346234958A"
        obj.status = "Open"
        obj.incident_logged_time = "13 Mar ‘20, 07:50 PM"
        obj.landID = "LAN ID : EMP_21"
        obj.location = "Location : Plant TAE95"
        obj.materialName = "Tool: Electrical Problem Information"
        obj.incId = "T"
        self.model.append(obj)
        obj.incident_id = "MIT346958A"
            obj.status = "In Process"
            obj.incident_logged_time = "15 Mar ‘20, 07:50 PM"
            obj.landID = "LAN ID : EMP_65"
            obj.location = "Location : Plant TA8"
            obj.materialName = "Tool: Gas Information"
            obj.incId = "T"
            self.model.append(obj)
        obj.incident_id = "MERIX346958A"
              obj.status = "In Process"
              obj.incident_logged_time = "15 Mar ‘20, 07:50 PM"
              obj.landID = "LAN ID : EMP_241"
              obj.location = "Location : Plant METR9"
              obj.materialName = "Meter: Sub Station Information"
              obj.incId = "ME"
        self.model.append(obj)
        obj.incident_id = "INX255128A"
          obj.status = "Completed"
          obj.incident_logged_time = "19 Apr ‘20, 09:15 PM"
          obj.landID = "LAN ID : EMP_12"
          obj.location = "Location : Plant T9A"
          obj.materialName = "Material : Electrical Material Information"
          obj.incId = "M"
          self.model.append(obj)
        
        let currentCategory = CategorySigleton.shared.categoryName
               switch currentCategory {
               case .Material:
               self.model =  self.model.filter{$0.incId == "M"}
               case .Tools:
                 self.model =  self.model.filter{$0.incId == "T"}
               case .Meter:
               self.model =    self.model.filter{$0.incId == "ME"}
               case .Report:
                   debugPrint("Nothing to load")
               case .none:
                   debugPrint("Nothing to load")
               }
        self.originalModel = self.model
        self.statusSegmentTapped(self.statusSegmentControl)
        //self.tableView.reloadData()
    }
}

extension RequestListVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch UIDevice.current.userInterfaceIdiom {
               case .phone:
                   return 150
               case .pad:
                   return 220
               default:
                   return 0
               }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "IncidentTableViewCell") as? IncidentTableViewCell{
            let item = model[indexPath.row]
            cell.closeCallCatLabel.text = item.materialName
            cell.dateTimeLabel.text = item.location
            cell.impactCatLabel.text = item.landID
            cell.incidentNumberLabel.text = item.incident_id
            cell.reportedTimeLabel.text = item.incident_logged_time
            cell.statusLbl.text = item.status
            if item.status == "Completed"{
                cell.colorStackView.backgroundColor = #colorLiteral(red: 0, green: 0.7882352941, blue: 0.1176470588, alpha: 1)
                cell.statusLbl.textColor = #colorLiteral(red: 0, green: 0.7882352941, blue: 0.1176470588, alpha: 1)
                
            }else if item.status == "Open"{
                cell.colorStackView.backgroundColor = #colorLiteral(red: 1, green: 0.3843137255, blue: 0.3843137255, alpha: 1)
                cell.statusLbl.textColor = #colorLiteral(red: 1, green: 0.3843137255, blue: 0.3843137255, alpha: 1)
            }else{
                cell.colorStackView.backgroundColor = #colorLiteral(red: 1, green: 0.7490196078, blue: 0.3450980392, alpha: 1)
                cell.statusLbl.textColor = #colorLiteral(red: 1, green: 0.7490196078, blue: 0.3450980392, alpha: 1)
            }
            return cell
        }else{
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //CreateMaterialVC
//        navigateToCreateVC()
    }
    
    private func navigateToCreateVC(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "CreateMaterialVC") as? CreateMaterialVC
        viewController?.requestPersistance = self.requestPersistance
        self.navigationController?.pushViewController(viewController!, animated: true)
    }
}
extension RequestListVC {
    func loadOfflineStores() {
        self.requestPersistance.load { [weak self] in
        }
    }
}
