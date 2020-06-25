//
//  ProblemInfoViewController.swift
//  PGE-POC
//
//  Created by Naveen Kumar K N on 08/05/20.
//  Copyright © 2020 incture. All rights reserved.
//

import UIKit

class ProblemInfoViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    var model = ProblemInfoModel()
    var imagePickerController = UIImagePickerController()
    var photoCustomView = PhotoPopupView()

    var imageArray = [UIImage]()
    var actionSheetData: [ActionSheetDataModel] = [ActionSheetDataModel(title: "Photo Library", iconImage: "reporterInfo", isSelected: false), ActionSheetDataModel(title: "Material Info", iconImage: "materialInfo", isSelected: false), ActionSheetDataModel(title: "Problem Info", iconImage: "problemInfo", isSelected: false)]
    override func viewDidLoad() {
        // Load custom action sheet
        self.showSheetStatus = true
        
        super.viewDidLoad()
        customNavigationType = .navWithSubit
        tableView.delegate = self
        tableView.dataSource = self
        imagePickerController.delegate = self
        imageArray.append(UIImage(named: "imageAdd")!)
        self.tableView?.register(UINib(nibName: "ProblemInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "ProblemInfoTableViewCell")
        self.tableView?.register(UINib(nibName: "AttachmentTableViewCell", bundle: nil), forCellReuseIdentifier: "AttachmentTableViewCell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.customView.actionSheetData = [ActionSheetDataModel(title: "Reporter Info", iconImage: "reporterInfo", isSelected: true), ActionSheetDataModel(title: "Material Info", iconImage: "materialInfo", isSelected: true), ActionSheetDataModel(title: "Problem Info", iconImage: "problemInfo", isSelected: true)]
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.endEditing(true)
    }
    
//    override func selectedBack(sender: UIButton) {
//        self.navigationController?.popViewController(animated: true)
//    }
    override func submitBtnClicked(sender: UIButton) {
        
        
        let alertController = UIAlertController(title:"", message: "Request created successfully.\n Request #: 43215064", preferredStyle: .alert)

              let YesAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
                  self.navigationController?.popToRootViewController(animated: true)
              }
              alertController.addAction(YesAction)
              self.present(alertController, animated: true, completion: nil)
    }

}

extension ProblemInfoViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
    let cell = tableView.dequeueReusableCell(withIdentifier: "ProblemInfoTableViewCell", for: indexPath) as! ProblemInfoTableViewCell
        cell.selectBtn.addTarget(self, action: #selector(divicisionSelectClicked), for: .touchUpInside)
        cell.sendEnteredData = { value, key in
            switch key {
            case .additional:
                self.model.additionalInfo = value
            case .cause:
                 self.model.causeDesc = value
            case .complaint:
                 self.model.complients = value
            case .correction:
                 self.model.correction = value
            case .eventNumber:
                 self.model.eventNumber = value
            case .installedDate:
                 self.model.installedDate = value
            case .MFDate:
                 self.model.manufaDate = value
            case .materialStored:
                 self.model.materialStored = value
            case .qnty:
                 self.model.qnty = value
            case .shortDesc:
                 self.model.shortDesc = value
            }
            self.tableView.reloadData()
        }
        cell.additionalCostTF.text = self.model.additionalInfo
        cell.manufactureDateTF.text = self.model.manufaDate
        cell.eventNoTF.text = self.model.eventNumber
        cell.materialStoredTF.text = self.model.materialStored
        cell.qntyTF.text = self.model.qnty
        cell.shortDecsTF.text = self.model.shortDesc
        cell.complientTW.text = self.model.complients
        cell.correctionTW.text = self.model.correction
        cell.causeTw.text = self.model.causeDesc
        cell.causeTF.text = self.model.cause
        cell.installedDate.text = self.model.installedDate
        cell.attachmentBtn.addTarget(self, action: #selector(attachmentClicked), for: .touchUpInside)
        return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "AttachmentTableViewCell", for: indexPath) as! AttachmentTableViewCell
            cell.collectionView.delegate = self
            cell.collectionView.dataSource = self
            cell.collectionView.reloadData()
            return cell
        }

    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 60))
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 60))
        button.setTitle("Submit", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.01568627451, green: 0.1254901961, blue: 0.2156862745, alpha: 1)
        button.addTarget(self, action: #selector(submitBtnClicked), for: .touchUpInside)
        view.addSubview(button)
        return view
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.row == 0{
//            return UITableView.automaticDimension
//        }else{
//            return 200
//        }
//    }
}
extension ProblemInfoViewController{
    
    @objc func divicisionSelectClicked(sender:UIButton){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "SelectionViewController") as?
        SelectionViewController
        viewController?.returnSelectedValue = { value in
            self.model.cause = value
            self.tableView.reloadData()
        }
        viewController?.title = "Select Case/Problem"
        viewController?.dataArray = ["Interruption","Failure","Fluctuatuion"]
        self.navigationController?.pushViewController(viewController!, animated: true)
    }
//     @objc func submitBtnClicked(sender:UIButton){
////        let storyboard = UIStoryboard(name: "Main", bundle: nil)
////            let viewController = storyboard.instantiateViewController(identifier: "DashboardVC")
////
////            let navigationController = UINavigationController()
////            navigationController.pushViewController(viewController, animated: false)
////            APP_DELEGATE.window?.rootViewController = navigationController
//

//    }
    @objc func attachmentClicked(sender:UIButton){
        self.popPhotoView()
//        imagePickerController.sourceType = .photoLibrary
//          self.present(imagePickerController, animated: true, completion: nil)
    }
    func popPhotoView(){
        
        
        let bundle = Bundle.main
        photoCustomView = UINib(nibName: "PhotoPopupView", bundle: bundle).instantiate(withOwner: nil, options: nil)[0] as! PhotoPopupView
        photoCustomView.frame = CGRect(x: view.frame.origin.x, y: view.frame.height-250, width: view.frame.width, height: 250)
        photoCustomView.layer.cornerRadius = 8.0
        photoCustomView.layer.masksToBounds = true
        photoCustomView.cancelBtn.addTarget(self, action: #selector(callCancelButton), for: .touchUpInside)
        photoCustomView.returnSelectedIndex = { value in
            switch value {
            case 0:
                self.imagePickerController.sourceType = .photoLibrary
                self.present(self.imagePickerController, animated: true, completion: nil)
                self.callCancelButton()
                break
            case 1:
                if UIImagePickerController.isSourceTypeAvailable(.camera){
                    self.imagePickerController.sourceType = .camera
                    self.present(self.imagePickerController, animated: true, completion: nil)
                     }
                self.callCancelButton()
                break
            case 2:
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyboard.instantiateViewController(identifier: "SelectionViewController") as?
                SelectionViewController
                viewController?.isFromFiles = true
                viewController?.title = "Select Files"
                viewController?.dataArray = ["1.pdf","2.pdf","3.pdf","4.pdf","5.pdf"]
                viewController?.returnSelectedValue = { data in
                    self.imageArray.append(UIImage(named: "Pdf")!)
                    self.tableView.reloadData()
                }
                self.navigationController?.pushViewController(viewController!, animated: true)
                self.callCancelButton()
                break
            default:
                debugPrint("")
            }
        }
            self.view.addSubview(photoCustomView)
            self.view.bringSubviewToFront(photoCustomView)

    }
   @objc func callCancelButton(){
        self.photoCustomView.tableView.isHidden = true
        UIView.transition(with: self.customView, duration: 0.5, options: .curveEaseInOut, animations: {
        self.photoCustomView.frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.height+45, width: self.view.frame.width, height: 180)
        })
    }
}
extension ProblemInfoViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        self.imageArray.append(image)
        self.tableView.reloadData()
        picker.dismiss(animated: true, completion: nil)
    }
}
extension ProblemInfoViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ThumbnailImageCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ThumbnailImageCollectionViewCell"
                   , for: indexPath) as! ThumbnailImageCollectionViewCell
        cell.imgVw.image = imageArray[indexPath.row]
               return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return  CGSize(width: 130.0, height: 130.0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
       }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
         return  10.0
     }
    func collectionView(_ collectionView: UICollectionView,
                           layout collectionViewLayout: UICollectionViewLayout,
                           minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
           return 0.0
       }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0{
            self.popPhotoView()
        }
     }
}
