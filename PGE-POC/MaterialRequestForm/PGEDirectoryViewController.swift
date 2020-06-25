//
//  PGEDirectoryViewController.swift
//  PGE-POC
//
//  Created by Naveen Kumar K N on 12/05/20.
//  Copyright © 2020 incture. All rights reserved.
//

import UIKit

struct PGEDirectoryModel:Decodable {
    var name : String?
    var lanId : String?
    var phone : String?
}
class PGEDirectoryViewController: BaseViewController,UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var sendDataback : ((PGEDirectoryModel)->())?
    var arr = [PGEDirectoryModel]()
    var originalModel = [PGEDirectoryModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.customNavigationType = .navWithBack
        searchBar.backgroundColor = UIColor.white
        searchBar.layer.cornerRadius = 8
        searchBar.clipsToBounds = true
        self.tableView?.register(UINib(nibName: "PGEDirectoryTableViewCell", bundle: nil), forCellReuseIdentifier: "PGEDirectoryTableViewCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.searchBar.delegate = self
        addElementsToArray()
        self.title = "PG&E Directory"

    }
    func addElementsToArray(){
        var obj = PGEDirectoryModel()
        obj.name = "Saphil"
        obj.lanId = "LAN MAT4"
        obj.phone = "14567239"
        self.arr.append(obj)
        obj.name = "Muaphil"
        obj.lanId = "LAN MAT5"
        obj.phone = "94567239"
        self.arr.append(obj)
        obj.name = "Navee"
              obj.lanId = "LAN AT5"
              obj.phone = "9994567239"
              self.arr.append(obj)
        obj.name = "Brafu"
                    obj.lanId = "LAN AT5"
                    obj.phone = "99939567239"
                    self.arr.append(obj)
        obj.name = "Kumar"
                          obj.lanId = "LAN Aer5"
                          obj.phone = "9865345"
                          self.arr.append(obj)
        self.originalModel = self.arr
        self.tableView.reloadData()
    }
    override func selectedBack(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
        func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
            searchBar.resignFirstResponder()
            return true
        }
        
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            self.arr = self.originalModel
            self.tableView.reloadData()
        }
        
        func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            
            
            
            let currentString: NSString = searchBar.text! as NSString
               let newString: NSString = currentString.replacingCharacters(in: range, with: text) as NSString
                self.arr = self.originalModel.filter{($0.name?.contains("\(newString)"))! || ($0.lanId?.contains("\(newString)"))! || ($0.phone?.contains("\(newString)"))!}
                self.tableView.reloadData()

            if newString == ""{
                self.arr = self.originalModel
                self.tableView.reloadData()
                 return true
            }

            return true
        }
    
    
}
extension PGEDirectoryViewController : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PGEDirectoryTableViewCell", for: indexPath) as! PGEDirectoryTableViewCell
        cell.nameLbl.text = "Name : " + (arr[indexPath.row].name ?? "")
        cell.lanId.text = "LAN ID : " + (arr[indexPath.row].lanId ?? "")
        cell.phoneLbl.text = "Phone : " + (arr[indexPath.row].phone ?? "")
        return cell

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.sendDataback?(arr[indexPath.row])
        self.navigationController?.popViewController(animated: true)
    }
    
}
