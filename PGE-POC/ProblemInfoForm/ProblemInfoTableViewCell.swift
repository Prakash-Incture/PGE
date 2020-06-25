//
//  ProblemInfoTableViewCell.swift
//  PGE-POC
//
//  Created by Naveen Kumar K N on 08/05/20.
//  Copyright © 2020 incture. All rights reserved.
//

import UIKit

class ProblemInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var causeTF: UITextField!
    @IBOutlet weak var selectBtn: UIButton!
    @IBOutlet weak var qntyTF: UITextField!
    @IBOutlet weak var shortDecsTF: UITextField!
    @IBOutlet weak var complientTW: UITextView!
    @IBOutlet weak var causeTw: UITextView!
    @IBOutlet weak var correctionTW: UITextView!
    @IBOutlet weak var manufactureDateTF: UITextField!
    @IBOutlet weak var attachmentBtn: UIButton!
    @IBOutlet weak var additionalCostTF: UITextField!
    @IBOutlet weak var materialStoredTF: UITextField!
    @IBOutlet weak var installedDate: UITextField!
    @IBOutlet weak var eventNoTF: UITextField!
    @IBOutlet weak var complaintTxtCountLbl: UILabel!
    @IBOutlet weak var causeTxtCountLbl: UILabel!
    @IBOutlet weak var correctionTxtCountLbl: UILabel!
    
    var textF = UITextField()
    let datePicker = UIDatePicker()
    var sendEnteredData : ((String,MaterialProblemInfoModelData)->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
            eventNoTF.delegate = self
             additionalCostTF.delegate = self
             materialStoredTF.delegate = self
             installedDate.delegate = self
             manufactureDateTF.delegate = self
             shortDecsTF.delegate = self
             qntyTF.delegate = self
             correctionTW.delegate = self
            complientTW.delegate = self
            correctionTW.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
  
    func showDatePicker(textfield:UITextField){
         //Formate Date
         datePicker.datePickerMode = .date

        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
          let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
       let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));

      toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        textF = textfield
      textfield.inputAccessoryView = toolbar
       textfield.inputView = datePicker

      }

       @objc func donedatePicker(){

        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        if textF == installedDate{
            self.sendEnteredData?(formatter.string(from: datePicker.date) , MaterialProblemInfoModelData.installedDate)
        }else{
         self.sendEnteredData?(formatter.string(from: datePicker.date) , MaterialProblemInfoModelData.MFDate)
        }
        self.textF.endEditing(true)
      }

      @objc func cancelDatePicker(){
         self.textF.endEditing(true)
       }
}

extension ProblemInfoTableViewCell:UITextFieldDelegate{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == manufactureDateTF || textField == installedDate{
            showDatePicker(textfield: textField)
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if textField == qntyTF{
            self.sendEnteredData?(textField.text! , MaterialProblemInfoModelData.qnty)
        }else if textField == shortDecsTF{
            self.sendEnteredData?(textField.text! , MaterialProblemInfoModelData.shortDesc)
        }else if textField == eventNoTF{
            self.sendEnteredData?(textField.text! , MaterialProblemInfoModelData.eventNumber)
        }else if textField == additionalCostTF{
        self.sendEnteredData?(textField.text! , MaterialProblemInfoModelData.additional)
        }else if textField == materialStoredTF{
        self.sendEnteredData?(textField.text! , MaterialProblemInfoModelData.materialStored)
        }
        textField.resignFirstResponder()
    }
}

extension ProblemInfoTableViewCell:UITextViewDelegate{
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView == causeTw{
            self.sendEnteredData?(textView.text! , MaterialProblemInfoModelData.cause)
        }else if textView == correctionTW{
            self.sendEnteredData?(textView.text! , MaterialProblemInfoModelData.correction)
        }else{
            self.sendEnteredData?(textView.text! , MaterialProblemInfoModelData.complaint)
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        switch textView {
        case self.complientTW:
            complaintTxtCountLbl.text = "\(500 - textView.text.count)/500"
        case self.causeTw:
            causeTxtCountLbl.text = "\(500 - textView.text.count)/500"
        case self.correctionTW:
            correctionTxtCountLbl.text = "\(500 - textView.text.count)/500"
        default:
            debugPrint("-")
        }
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        switch textView {
        case self.complientTW:
            return self.complientTW.text.count + (text.count - range.length) <= 500
        case self.causeTw:
            return self.causeTw.text.count + (text.count - range.length) <= 500
        case self.correctionTW:
            return self.correctionTW.text.count + (text.count - range.length) <= 500
        default:
            debugPrint("-")
        }
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
