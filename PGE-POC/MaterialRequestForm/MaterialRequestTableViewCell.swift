//
//  MaterialRequestTableViewCell.swift
//  PGE-POC
//
//  Created by Naveen Kumar K N on 08/05/20.
//  Copyright © 2020 incture. All rights reserved.
//

import UIKit

class MaterialRequestTableViewCell: UITableViewCell {
    @IBOutlet weak var reporterNameLbl: UILabel!
    @IBOutlet weak var reporterNameTF: UITextField!
    @IBOutlet weak var landIDLbl: UILabel!
    @IBOutlet weak var landIDTF: UITextField!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var dateTF: UITextField!
    @IBOutlet weak var dateSelectBtn: UIButton!
    var sendEnteredData : ((String,MaterialRequestModelData)->())?
    let datePicker = UIDatePicker()

    override func awakeFromNib() {
        super.awakeFromNib()
        reporterNameTF.delegate = self
        landIDTF.delegate = self
        dateTF.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func showDatePicker(){
           //Formate Date
           datePicker.datePickerMode = .date

          //ToolBar
          let toolbar = UIToolbar();
          toolbar.sizeToFit()
          let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
            let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
         let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));

        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)

        dateTF.inputAccessoryView = toolbar
         dateTF.inputView = datePicker

        }

         @objc func donedatePicker(){

          let formatter = DateFormatter()
          formatter.dateFormat = "dd/MM/yyyy"
           self.sendEnteredData?(formatter.string(from: datePicker.date) , MaterialRequestModelData.reporterDate)
          self.dateTF.endEditing(true)
        }

        @objc func cancelDatePicker(){
           self.dateTF.endEditing(true)
         }
}
extension MaterialRequestTableViewCell:UITextFieldDelegate{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
          if textField == dateTF{
              showDatePicker()
          }
          return true
      }
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if textField == reporterNameTF{
            self.sendEnteredData?(textField.text! , MaterialRequestModelData.reporterName)
        }else if textField == landIDTF{
            self.sendEnteredData?(textField.text! , MaterialRequestModelData.reporterLANID)
        }
        textField.resignFirstResponder()

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
