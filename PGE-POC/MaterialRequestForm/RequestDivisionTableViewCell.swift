//
//  RequestDivisionTableViewCell.swift
//  PGE-POC
//
//  Created by Naveen Kumar K N on 08/05/20.
//  Copyright © 2020 incture. All rights reserved.
//

import UIKit

class RequestDivisionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var pgeDBtn: UIButton!
    @IBOutlet weak var cellPhoneTF: UITextField!
    @IBOutlet weak var devisionNameLbl: UILabel!
     @IBOutlet weak var devisionNameTF: UITextField!
    @IBOutlet weak var devisionSelectBtn: UIButton!
     @IBOutlet weak var lanIDLbl: UILabel!
     @IBOutlet weak var lanIDTF: UITextField!
     @IBOutlet weak var dateLbl: UILabel!
     @IBOutlet weak var dateTF: UITextField!
     @IBOutlet weak var dateSelectBtn: UIButton!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var phoneTF: UITextField!
    var sendEnteredData : ((String,MaterialRequestModelData)->())?
    let datePicker = UIDatePicker()

    override func awakeFromNib() {
        super.awakeFromNib()
        lanIDTF.delegate = self
        phoneTF.delegate = self
        devisionNameTF.delegate = self
        dateTF.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

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
        self.sendEnteredData?(formatter.string(from: datePicker.date) , MaterialRequestModelData.divisionDate)
       self.dateTF.endEditing(true)
     }

     @objc func cancelDatePicker(){
        self.dateTF.endEditing(true)
      }
}
extension RequestDivisionTableViewCell:UITextFieldDelegate{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
          if textField == dateTF{
             // showDatePicker()
          }
          return true
      }
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if textField == devisionNameTF{
            self.sendEnteredData?(textField.text! , MaterialRequestModelData.divisionName)
        }else if textField == lanIDTF{
            self.sendEnteredData?(textField.text! , MaterialRequestModelData.divisionLANID)
        }else if textField == phoneTF{
            self.sendEnteredData?(textField.text! , MaterialRequestModelData.divisionPhoneNo)
        }else if textField == dateTF{
            self.sendEnteredData?(textField.text! , MaterialRequestModelData.divisionDate)

        }else if textField == cellPhoneTF{
            self.sendEnteredData?(textField.text! , MaterialRequestModelData.cellPhoneDivision)

        }
        textField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
