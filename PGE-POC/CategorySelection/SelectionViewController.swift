//
//  SelectionViewController.swift
//  PGE-POC
//
//  Created by Naveen Kumar K N on 08/05/20.
//  Copyright © 2020 incture. All rights reserved.
//

import UIKit

class SelectionViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
var isFromFiles = false
var dataArray = ["Category1","Category2","Category3"]
    var returnSelectedValue : ((String)->())?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.customNavigationType = .navWithBack
        tableView.dataSource = self
        tableView.delegate = self
    }
    override func selectedBack(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
extension SelectionViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     if let cell = tableView.dequeueReusableCell(withIdentifier: "SelectCell") as? SelectionTableViewCell{
        cell.titleLbl.text = dataArray[indexPath.row]
        if isFromFiles{
            cell.imgVw.isHidden = false
            cell.imgWidthConstraint.constant = 25
        }else{
            cell.imgVw.isHidden = true
            cell.imgWidthConstraint.constant = 0

        }
        return cell
     }else{
        return UITableViewCell()
    }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.returnSelectedValue?( dataArray[indexPath.row])
        self.navigationController?.popViewController(animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isFromFiles {
            return 60
        }
        return 40.0
    }
}
