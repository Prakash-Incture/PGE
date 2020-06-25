//
//  BaseViewController.swift
//  SDGE Near Miss
//
//  Created by Naveenkumar.KN on 11/10/19.
//  Copyright © 2019 Incture. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    var navigationType  : CustomNavType           = .navPlain
    var toastType       : ToastType               = .BLACK_MESSAGE
    var presentWindow   : UIWindow?
    
    var customView = CustomActionSheet()
    public var showSheetStatus = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let bundle = Bundle.main
        customView = UINib(nibName: "CustomActionSheet", bundle: bundle).instantiate(withOwner: nil, options: nil)[0] as! CustomActionSheet
        customView.frame = CGRect(x: view.frame.origin.x, y: view.frame.height-100, width: view.frame.width, height: 180)
        customView.layer.cornerRadius = 8.0
        customView.layer.masksToBounds = true
        self.customView.tableView.isHidden = true
        customView.showAndHideBtn.addTarget(self, action: #selector(showAndHideButtonTapped(sender:)), for: .touchUpInside)
        customView.returnSelectedIndex = { value in
            switch value {
            case 0:
                for vc in self.navigationController!.viewControllers{
                    if vc.isKind(of: MaterialRequestFormVC.self){
                        self.navigationController?.popToViewController(vc, animated: true)
                        return
                    }
                }
                if !self.isKind(of: MaterialRequestFormVC.self){
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let viewController = storyboard.instantiateViewController(identifier: "MaterialRequestFormVC")
                            viewController.title = APP_DELEGATE.title
                            self.navigationController?.pushViewController(viewController, animated: true)
                    }
            case 1:
                for vc in self.navigationController!.viewControllers{
                    if vc.isKind(of: MaterialrequestInfoFormVC.self){
                        self.navigationController?.popToViewController(vc, animated: true)
                        return
                    }
                }
                if !self.isKind(of: MaterialrequestInfoFormVC.self){
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let viewController = storyboard.instantiateViewController(identifier: "MaterialrequestInfoFormVC")
                            viewController.title = APP_DELEGATE.title
                            self.navigationController?.pushViewController(viewController, animated: true)
                        }
            case 2:
                for vc in self.navigationController!.viewControllers{
                    if vc.isKind(of: ProblemInfoViewController.self){
                        self.navigationController?.popToViewController(vc, animated: true)
                        return
                    }
                }
                if !self.isKind(of: ProblemInfoViewController.self){
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let viewController = storyboard.instantiateViewController(identifier: "ProblemInfoViewController")
                        viewController.title = APP_DELEGATE.title
                        self.navigationController?.pushViewController(viewController, animated: true)
                    }
            default:
                debugPrint("")
            }
        }
        if showSheetStatus == true{
            self.view.addSubview(customView)
            self.view.bringSubviewToFront(customView)
        }
    }
    
    var customNavigationType : CustomNavType {
        
        get {
            return self.navigationType
        }
        set (customNavigationType) {
            
            self.navigationType = customNavigationType
            //            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,NSAttributedString.Key.font:UIFont.getFont(with: .NunitoRegular, size: 17)]
            var size = 17.0
            switch UIDevice.current.userInterfaceIdiom {
                   case .phone:
                      size = 17.0
                   case .pad:
                      size = 22.0
                   default:
                    return
                   }
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,NSAttributedString.Key.font:UIFont.systemFont(ofSize:CGFloat(size), weight: .bold)]
            switch customNavigationType {
            case .navWithBack:
                let backBtn =  NavBackButton(type: .custom)
                backBtn.addTarget(self, action: #selector(selectedBack(sender:)), for: .touchUpInside)
                navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
                navigationItem.rightBarButtonItem = nil
                break
            case .navPlain:
                self.navigationItem.setHidesBackButton(true, animated:true)
                navigationItem.leftBarButtonItem = nil
                navigationItem.rightBarButtonItem = nil
                break
            case .navWithLefttittle:
                let titleBtn =  NavLeftTitleButton(type: .custom)
                navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleBtn)
                navigationItem.rightBarButtonItem = nil
                break
            case .navWithFilter:
                    let backBtn =  NavBackButton(type: .custom)

                     backBtn.addTarget(self, action: #selector(selectedBack(sender:)), for: .touchUpInside)
                     navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
                     
                     let filterBtn =  NavFilterButton(type: .custom)
                     filterBtn.addTarget(self, action: #selector(filterBtnClicked(sender:)), for: .touchUpInside)
                     navigationItem.rightBarButtonItem = UIBarButtonItem(customView: filterBtn)
                break
            case .naveWithNext:
                        let backBtn =  NavBackButton(type: .custom)

                             backBtn.addTarget(self, action: #selector(selectedBack(sender:)), for: .touchUpInside)
                             navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
                             
                             let nextBtn =  NavNextButton(type: .custom)
                             nextBtn.addTarget(self, action: #selector(nextBtnClicked(sender:)), for: .touchUpInside)
                             navigationItem.rightBarButtonItem = UIBarButtonItem(customView: nextBtn)
                        break
            case .navWithSubit:
                    let backBtn =  NavBackButton(type: .custom)

                                         backBtn.addTarget(self, action: #selector(selectedBack(sender:)), for: .touchUpInside)
                                         navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
                                         
                                         let sBtn =  NavSubmitButton(type: .custom)
                                         sBtn.addTarget(self, action: #selector(submitBtnClicked(sender:)), for: .touchUpInside)
                                         navigationItem.rightBarButtonItem = UIBarButtonItem(customView: sBtn)
                                    break
            }
        }
    }
    @objc func selectedBack(sender: UIButton) {
        DLog(message: "Overide")
        
        if self.isKind(of: ProblemInfoViewController.self) || self.isKind(of: MaterialrequestInfoFormVC.self) || self.isKind(of: MaterialRequestFormVC.self){
        let alertController = UIAlertController(title:"", message: "Do you want save as draft?", preferredStyle: .alert)
             let noAction = UIAlertAction(title: "No", style: .default) { (action:UIAlertAction) in
                    }
             let YesAction = UIAlertAction(title: "Yes", style: .default) { (action:UIAlertAction) in
                 let alertController1 = UIAlertController(title:"", message: "Data saved to draft successfully.", preferredStyle: .alert)
                 let YesAction1 = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
                    if self.isKind(of: ProblemInfoViewController.self) {
                        NotificationCenter.default.post(name: Notification.Name("StoringProblemInfo"), object: nil, userInfo: nil)
                    }else if  self.isKind(of: MaterialrequestInfoFormVC.self){
                        NotificationCenter.default.post(name: Notification.Name("StoringProblemInfo"), object: nil, userInfo: nil)
                    }else if self.isKind(of: MaterialRequestFormVC.self){
                        NotificationCenter.default.post(name: Notification.Name("StoringProblemInfo"), object: nil, userInfo: nil)
                    }
                     self.navigationController?.popViewController(animated: true)
                 }
                 alertController1.addAction(YesAction1)
                 self.present(alertController1, animated: true, completion: nil)
                 self.navigationController?.popViewController(animated: true)
             }
              alertController.addAction(noAction)
             alertController.addAction(YesAction)
             self.present(alertController, animated: true, completion: nil)
             self.navigationController?.popViewController(animated: true)
        
        }
        
    }
    @objc func filterBtnClicked(sender: UIButton) {
           DLog(message: "Overide")
           
       }
    @objc func nextBtnClicked(sender: UIButton) {
            DLog(message: "Overide")
            
        }
    @objc func submitBtnClicked(sender: UIButton) {
               DLog(message: "Overide")
               
           }
}

extension BaseViewController{
    @objc func showAndHideButtonTapped(sender: UIButton) {
        self.view.endEditing(true)
        customView.showAndHideBtn.isSelected = !customView.showAndHideBtn.isSelected
        if customView.showAndHideBtn.isSelected{
            self.customView.tableView.isHidden = false
            UIView.transition(with: self.customView, duration: 0.5, options: .curveEaseInOut, animations: {
                self.customView.frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.height-180, width: self.view.frame.width, height: 180)
            })
        }else{
            self.customView.tableView.isHidden = true
            UIView.transition(with: self.customView, duration: 0.5, options: .curveEaseInOut, animations: {
                self.customView.frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.height-45, width: self.view.frame.width, height: 180)
            })
        }
    }
}
