//
//  UKWSToast + self.swift
//  MyOrders
//
//  Created by Swamy Manju on 15/02/18.
//  Copyright © 2018 Mindtree. All rights reserved.
//

import UIKit

// MARK: - Toast type
enum ToastType : String{
    
    case BLACK_MESSAGE
    case PEACH_MESSAGE_INFO

}

/*
 *  Infix overload method
 */
func /(lhs: CGFloat, rhs: Int) -> CGFloat {
    return lhs / CGFloat(rhs)
}

/*
 *  Toast Config
 */
public struct ToastConfig {
    var ToastDefaultDuration  =   2.0
    var ToastFadeDuration     =   0.2
    var ToastHorizontalMargin : CGFloat  =   10.0
    var ToastVerticalMargin   : CGFloat  =   10.0

    var ToastPositionVerticalOffset : CGFloat = 60.0 // Change to ypos for top position
    var ToastPosition                         = ToastPositionDefault

    // activity
    var ToastActivityWidth  :  CGFloat  = 100.0
    var ToastActivityHeight :  CGFloat  = 100.0
    var ToastActivityPositionDefault    = "center"

    // image size
    var ToastImageViewWidth :  CGFloat  = 80.0
    var ToastImageViewHeight:  CGFloat  = 80.0

    // label setting
    var ToastMaxWidth       :  CGFloat  = 0.8;      // 80% of parent view width
    var ToastMaxHeight      :  CGFloat  = 0.8;
    var ToastFontSize       :  CGFloat  = 16.0
    var ToastMaxTitleLines              = 0
    var ToastMaxMessageLines            = 0

    // shadow appearance
    var ToastShadowOpacity  : CGFloat   = 0.8
    var ToastShadowRadius   : CGFloat   = 6.0
    var ToastShadowOffset   : CGSize    = CGSize(width: CGFloat(4.0), height: CGFloat(4.0))

    var ToastOpacity        : CGFloat   = 0.9
    var ToastCornerRadius   : CGFloat   = 10.0

    /*
     *  Custom Config
     */
    var ToastHidesOnTap       =   true
    var ToastDisplayShadow    =   true
    
    var toastType: ToastType = .BLACK_MESSAGE
    
    var isAttributedString = false
    var hasCancelButton = false
    var isFullWidth = false
    var noTimer = false
    var isTextAlignmentLeft = false
    var hasRightButton = false
    var hasInfoButton = false
    var isFontBlack = false
    
    public init() {}
}

let ToastPositionDefault  =   "bottom"
let ToastPositionTop      =   "top"
let ToastPositionCenter   =   "center"
let ToastPositionAboveTab  =   "abovetab"

var ToastActivityView: UnsafePointer<UIView>?    =   nil
var ToastTimer: UnsafePointer<Timer>?          =   nil
var ToastView: UnsafePointer<UIView>?            =   nil
var ToastThemeColor : UnsafePointer<UIColor>?    =   nil
var ToastTitleFontName: UnsafePointer<String>?   =   nil
var ToastFontName: UnsafePointer<String>?        =   nil
var ToastFontColor: UnsafePointer<UIColor>?      =   nil

let defaults = ToastConfig()


//Toast (UIView + Toast using Swift)

public extension UIView {
    
    
    
    /*
     *  public methods
     */
     class func hr_setToastThemeColor(color: UIColor) {
        objc_setAssociatedObject(self, &ToastThemeColor, color, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
     class func hr_toastThemeColor() -> UIColor {
        var color = objc_getAssociatedObject(self, &ToastThemeColor) as! UIColor?
        if color == nil {
            color = UIColor.black
            UIView.hr_setToastThemeColor(color: color!)
        }
        return color!
    }
    
     class func hr_setToastTitleFontName(fontName: String) {
        objc_setAssociatedObject(self, &ToastTitleFontName, fontName, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
     class func hr_toastTitleFontName() -> String {
        var name = objc_getAssociatedObject(self, &ToastTitleFontName) as! String?
        if name == nil {
            let font = UIFont.getFont(with: .NunitoRegular, size: 12)
            name = font.fontName
            UIView.hr_setToastTitleFontName(fontName: name!)
        }
        
        return name!
    }
    
     class func hr_setToastFontName(fontName: String) {
        objc_setAssociatedObject(self, &ToastFontName, fontName, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
     class func hr_toastFontName() -> String {
        var name = objc_getAssociatedObject(self, &ToastFontName) as! String?
        if name == nil {
            let font = UIFont.getFont(with: .NunitoRegular, size: 12)
            name = font.fontName
            UIView.hr_setToastFontName(fontName: name!)
        }
        
        return name!
    }
    
     class func hr_setToastFontColor(color: UIColor) {
        objc_setAssociatedObject(self, &ToastFontColor, color, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
     class func hr_toastFontColor() -> UIColor {
        var color = objc_getAssociatedObject(self, &ToastFontColor) as! UIColor?
        if color == nil {
            color = UIColor.white
            UIView.hr_setToastFontColor(color: color!)
        }
        
        return color!
    }
    
    func makeToast(message msg: String, withConfiguration config: ToastConfig = ToastConfig()) {
        makeToast(message: msg, duration: config.ToastDefaultDuration, position: config.ToastPosition as AnyObject, withConfiguration: config)
    }
    //Without title and with position
    func makeToast(message msg: String, position: AnyObject, withConfiguration config: ToastConfig = ToastConfig()) {
        makeToast(message: msg, duration: config.ToastDefaultDuration, position: position as AnyObject, withConfiguration: config)
    }
    
    func makeToast(message msg: String, duration: Double, position: AnyObject, withConfiguration config: ToastConfig = ToastConfig()) {
        let toast = self.viewForMessage(msg, title: nil, image: nil, withConfiguration: config)
        showToast(toast: toast!, duration: duration, position: position, withConfiguration: config)
    }
    
    func makeConfigToast(message msg: String, duration: Double, position: AnyObject, withConfiguration config: ToastConfig) {
        let toast = self.viewForMessage(msg, title: nil, image: nil, withConfiguration: config)
        showToast(toast: toast!, duration: duration, position: position, withConfiguration: config)
    }
    
    func makeToast(message msg: String, duration: Double, position: AnyObject, title: String, withConfiguration config: ToastConfig = ToastConfig()) {
        let toast = self.viewForMessage(msg, title: title, image: nil, withConfiguration: config)
        showToast(toast: toast!, duration: duration, position: position, withConfiguration: config)
    }
    
    
    func makeBlackViewCartToast(message msg: String, duration: Double, position: AnyObject, withConfiguration config: ToastConfig = ToastConfig()) {
        var customConfig: ToastConfig = ToastConfig()
        customConfig.isAttributedString = true
        customConfig.isTextAlignmentLeft = true
        let toast = self.viewForMessage(msg, title: nil, image: nil, withConfiguration: customConfig)
        showToast(toast: toast!, duration: duration, position: position, withConfiguration: customConfig)
    }
    
    
    func makePeachInfoToast(message msg: String, duration: Double, position: AnyObject, title: String, withConfiguration config: ToastConfig = ToastConfig()) {
        var customConfig: ToastConfig = ToastConfig()
        customConfig.isFullWidth = true
        customConfig.ToastPosition = position as! String
        customConfig.ToastDisplayShadow = false
        customConfig.ToastCornerRadius = 0
        customConfig.noTimer = true
        customConfig.isTextAlignmentLeft = true
        customConfig.hasInfoButton = true
        customConfig.isFontBlack = true
        customConfig.toastType = .PEACH_MESSAGE_INFO
        let toast = self.viewForMessage(msg, title: nil, image: nil, withConfiguration: customConfig)
        showToast(toast: toast!, duration: duration, position: position, withConfiguration: customConfig)
    }
    
    
    func makeToast(message msg: String, duration: Double, position: AnyObject, image: UIImage, withConfiguration config: ToastConfig = ToastConfig()) {
        let toast = self.viewForMessage(msg, title: nil, image: image, withConfiguration: config)
        showToast(toast: toast!, duration: duration, position: position, withConfiguration: config)
    }
    
    func makeToast(message msg: String, duration: Double, position: AnyObject, title: String, image: UIImage, withConfiguration config: ToastConfig = ToastConfig()) {
        let toast = self.viewForMessage(msg, title: title, image: image, withConfiguration: config)
        showToast(toast: toast!, duration: duration, position: position, withConfiguration: config)
    }
    
    func showToast(toast: UIView, withConfiguration config: ToastConfig = ToastConfig()) {
        showToast(toast: toast, duration: config.ToastDefaultDuration, position: config.ToastPosition as AnyObject, withConfiguration: config)
    }
    
    fileprivate func showToast(toast: UIView, duration: Double, position: AnyObject, withConfiguration config: ToastConfig) {
        let existToast = objc_getAssociatedObject(self, &ToastView) as! UIView?
        if existToast != nil {
            if let timer: Timer = objc_getAssociatedObject(existToast as Any, &ToastTimer) as? Timer {
                timer.invalidate()
            }
            hideToast(toast: existToast!, force: false, withConfiguration: config);
           // DLog(message: "hide exist!")
        }
        
        toast.alpha = 0.0
        
        if config.ToastHidesOnTap {
            let tapRecognizer = UITapGestureRecognizer(target: toast, action: #selector(handleToastTapped(_:)))
            toast.addGestureRecognizer(tapRecognizer)
            toast.isUserInteractionEnabled = true;
            toast.isExclusiveTouch = true;
        }
        
        addSubview(toast)
        let desiredSize = toast.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        var padding =  CGFloat(0)
        if !config.isFullWidth {
            padding = (1 - config.ToastMaxWidth) / 2
        }
        
        let sidePadding = self.bounds.width * padding
        toast.leftAnchor.constraint(equalTo: self.leftAnchor, constant: sidePadding).isActive = true
        toast.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -sidePadding).isActive = true
        
//        if config.toastType == .PEACH_MESSAGE_COMPLETE_ACCOUNT {
//            desiredSize = CGSize(width: desiredSize.width, height: CGFloat(46.0))
//          //toast.heightAnchor.constraint(equalToConstant: 46).isActive = true
//        } else {
//
//        }
        
        toast.heightAnchor.constraint(equalToConstant: desiredSize.height).isActive = true
        
        let yPosition = yPositionForToastPosition(position, toastSize: desiredSize, withConfiguration: config)
        toast.centerYAnchor.constraint(equalTo: self.topAnchor, constant: yPosition).isActive = true
        
        if config.hasCancelButton {
            
            let button:UIButton = UIButton(frame: CGRect(x: (self.bounds.width - ((sidePadding * 2) + 40)), y: 0, width: 40, height: 40))
            button.setImage(UIImage(named:"Small_Cross"), for: .normal)
            button.contentEdgeInsets = UIEdgeInsets(top: -5, left: 7, bottom: 5, right: 7);
            button.backgroundColor = UIColor.clear
            button.addTarget(self, action:#selector(self.buttonClicked), for: .touchUpInside)
            toast.addSubview(button)
        }
        
        if config.hasRightButton {
            
            let button:UIButton = UIButton(frame: CGRect(x: (self.bounds.width - ((sidePadding * 2) + 50)), y: 7, width: 40, height: 40))
            button.setImage(UIImage(named:"arrow"), for: .normal)
            button.contentEdgeInsets = UIEdgeInsets(top: -5, left: 7, bottom: 5, right: 7);
            button.backgroundColor = UIColor.clear
            button.addTarget(self, action:#selector(self.buttonClicked), for: .touchUpInside)
            toast.addSubview(button)
        }
        
        if config.hasInfoButton {
            
            let button:UIButton = UIButton(frame: CGRect(x: 10, y: 5, width: 40, height: 40))
            button.setImage(UIImage(named:"informative_message_black"), for: .normal)
            button.contentEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0);
            button.backgroundColor = UIColor.clear
            button.addTarget(self, action:#selector(self.buttonClicked), for: .touchUpInside)
            toast.addSubview(button)
        }
        
        
        objc_setAssociatedObject(self, &ToastView, toast, .OBJC_ASSOCIATION_RETAIN)
        
        UIView.animate(withDuration: config.ToastFadeDuration,
                       delay: 0.0, options: ([.curveEaseOut, .allowUserInteraction]),
                       animations: {
                        toast.alpha = 1.0
        },
                       completion: { (finished: Bool) in
                        
                        if !config.noTimer {
                            let timer = Timer.scheduledTimer(timeInterval: duration, target: self, selector: #selector(self.toastTimerDidFinish(_:)), userInfo: toast, repeats: false)
                            objc_setAssociatedObject(toast, &ToastTimer, timer, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                        }
        })
    }
    
    @objc func buttonClicked(sender : UIButton) {
        self.hideToast(toast: sender.superview!)
    }
    
    func makeToastActivity(withConfiguration config: ToastConfig = ToastConfig()) {
        makeToastActivity(position: config.ToastActivityPositionDefault as AnyObject, withConfiguration: config)
    }
    
    func makeToastActivity(message msg: String, withConfiguration config: ToastConfig = ToastConfig()){
        makeToastActivity(position: config.ToastActivityPositionDefault as AnyObject, message: msg, withConfiguration: config)
    }
    
    fileprivate func makeToastActivity(position pos: AnyObject, message msg: String = "", withConfiguration config: ToastConfig) {
        let existingActivityView: UIView? = objc_getAssociatedObject(self, &ToastActivityView) as? UIView
        if existingActivityView != nil { return }
        
        let activityView = UIView(frame: CGRect(x: 0, y: 0, width: config.ToastActivityWidth, height: config.ToastActivityHeight))
        activityView.layer.cornerRadius = config.ToastCornerRadius
        
        activityView.center = self.centerPointForPosition(pos, toast: activityView, withConfiguration: config)
        activityView.backgroundColor = UIView.hr_toastThemeColor().withAlphaComponent(config.ToastOpacity)
        activityView.alpha = 0.0
        activityView.autoresizingMask = ([.flexibleLeftMargin, .flexibleTopMargin, .flexibleRightMargin, .flexibleBottomMargin])
        
        if config.ToastDisplayShadow {
            activityView.layer.shadowColor = UIView.hr_toastThemeColor().cgColor
            activityView.layer.shadowOpacity = Float(config.ToastShadowOpacity)
            activityView.layer.shadowRadius = config.ToastShadowRadius
            activityView.layer.shadowOffset = config.ToastShadowOffset
        }
        
        let activityIndicatorView = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicatorView.center = CGPoint(x: activityView.bounds.size.width / 2, y: activityView.bounds.size.height / 2)
        activityView.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
        
        if (!msg.isEmpty){
            activityIndicatorView.frame.origin.y -= 10
            let activityMessageLabel = UILabel(frame: CGRect(x: activityView.bounds.origin.x, y: (activityIndicatorView.frame.origin.y + activityIndicatorView.frame.size.height + 10), width: activityView.bounds.size.width, height: 20))
            activityMessageLabel.textColor = UIView.hr_toastFontColor()
            activityMessageLabel.font = (msg.count<=10) ? UIFont(name:UIView.hr_toastFontName(), size: 16) : UIFont(name:UIView.hr_toastFontName(), size: 13)
            activityMessageLabel.textAlignment = .center
            activityMessageLabel.text = msg
            activityView.addSubview(activityMessageLabel)
        }
        
        addSubview(activityView)
        
        // associate activity view with self
        objc_setAssociatedObject(self, &ToastActivityView, activityView, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        UIView.animate(withDuration: config.ToastFadeDuration,
                       delay: 0.0,
                       options: UIView.AnimationOptions.curveEaseOut,
                       animations: {
                        activityView.alpha = 1.0
        },
                       completion: nil)
    }
    
    func hideToastActivity(withConfiguration config: ToastConfig = ToastConfig()) {
        let existingActivityView = objc_getAssociatedObject(self, &ToastActivityView) as! UIView?
        if existingActivityView == nil { return }
        UIView.animate(withDuration: config.ToastFadeDuration,
                       delay: 0.0,
                       options: UIView.AnimationOptions.curveEaseOut,
                       animations: {
                        existingActivityView!.alpha = 0.0
        },
                       completion: { (finished: Bool) in
                        existingActivityView!.removeFromSuperview()
                        objc_setAssociatedObject(self, &ToastActivityView, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        })
    }
    
    /*
     *  private methods (helper)
     */
    func hideToast(toast: UIView) {
        hideToast(toast: toast, force: false, withConfiguration: ToastConfig());
    }
    
    func hideToast(toast: UIView, force: Bool, withConfiguration config: ToastConfig) {
        let completeClosure = { (finish: Bool) -> () in
            toast.removeFromSuperview()
            objc_setAssociatedObject(self, &ToastTimer, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
        if force {
            completeClosure(true)
        } else {
            UIView.animate(withDuration: config.ToastFadeDuration,
                           delay: 0.0,
                           options: ([.curveEaseIn, .beginFromCurrentState]),
                           animations: {
                            toast.alpha = 0.0
            },
                           completion:completeClosure)
        }
    }
    
    @objc func toastTimerDidFinish(_ timer: Timer) {
        hideToast(toast: timer.userInfo as! UIView)
    }
    
    @objc func handleToastTapped(_ recognizer: UITapGestureRecognizer) {
        let timer = objc_getAssociatedObject(self, &ToastTimer) as? Timer
        
        if let timer = timer {
            timer.invalidate()
        }
        
        hideToast(toast: recognizer.view!)
        
        
    }
    
    fileprivate func yPositionForToastPosition(_ position: AnyObject, toastSize: CGSize, withConfiguration config: ToastConfig) -> CGFloat {
        let viewSize  = self.bounds.size
        
        if position is String {
            if position.lowercased == ToastPositionTop {
                return toastSize.height/2 + config.ToastPositionVerticalOffset
            } else if position.lowercased == ToastPositionDefault {
                return viewSize.height - toastSize.height/2 - config.ToastPositionVerticalOffset
            } else if position.lowercased == ToastPositionCenter {
                return viewSize.height/2
            }else if position.lowercased == ToastPositionAboveTab {
                let tabBarController = UITabBarController()
               // DLog(message: "\(tabBarController.tabBar.frame.size.height)")
//                if config.toastType == .PEACH_MESSAGE_CHECK_IT_NOW || config.toastType == .PEACH_MESSAGE_CHECK_CART {
//                return viewSize.height - toastSize.height/2  - tabBarController.tabBar.frame.size.height
//                }else{
                return viewSize.height - toastSize.height/2  - tabBarController.tabBar.frame.size.height - 10
               // }
            }
        } else if position is CGFloat {
            return position as! CGFloat
        }
       // DLog(message: "[Toast-Swift]: Warning! Invalid position for toast.")
        return viewSize.height/2
    }
    
    fileprivate func centerPointForPosition(_ position: AnyObject, toast: UIView, withConfiguration config: ToastConfig) -> CGPoint {
        if position is String {
            let toastSize = toast.bounds.size
            let viewSize  = self.bounds.size
            if position.lowercased == ToastPositionTop {
                return CGPoint(x: viewSize.width/2, y: toastSize.height/2 + config.ToastVerticalMargin)
            } else if position.lowercased == ToastPositionDefault {
                return CGPoint(x: viewSize.width/2, y: viewSize.height - toastSize.height/2 - config.ToastVerticalMargin)
            } else if position.lowercased == ToastPositionCenter {
                return CGPoint(x: viewSize.width/2, y: viewSize.height/2)
            }else if position.lowercased == ToastPositionAboveTab {
                let tabBarController = UITabBarController()
               // DLog(message: "\(tabBarController.tabBar.frame.size.height)")
                return CGPoint(x: viewSize.width/2, y: viewSize.height - toastSize.height/2 - config.ToastVerticalMargin - tabBarController.tabBar.frame.size.height)
            }
        } else if position is NSValue {
            return position.cgPointValue
        }
        
       // DLog(message: "[Toast-Swift]: Warning! Invalid position for toast.")
        return self.centerPointForPosition(config.ToastPosition as AnyObject, toast: toast, withConfiguration: config)
    }
    
    fileprivate func viewForMessage(_ msg: String?, title: String?, image: UIImage?, withConfiguration config: ToastConfig) -> UIView? {
        if msg == nil && title == nil && image == nil { return nil }
        
        let someTextBeingShown = (msg != nil || title != nil)
        let wrapperView = createInitialView(withConfiguration: config)
        let contentsStackView = addContentsStackView(toWrapperView: wrapperView, withConfiguration: config)
        
        if let image = image {
            addImage(image, toStackView: contentsStackView)
        }
        
        if someTextBeingShown {
            addMessage(msg, andTitle: title, toStackView: contentsStackView, withConfiguration: config)
        }
        
        return wrapperView
    }
    
    fileprivate func createInitialView(withConfiguration config: ToastConfig) -> UIView {
        let initialView = UIView()
        initialView.translatesAutoresizingMaskIntoConstraints = false
        initialView.layer.cornerRadius = config.ToastCornerRadius
        initialView.backgroundColor = UIView.hr_toastThemeColor().withAlphaComponent(config.ToastOpacity)
        
        if config.ToastDisplayShadow {
            initialView.layer.shadowColor = UIView.hr_toastThemeColor().cgColor
            initialView.layer.shadowOpacity = Float(config.ToastShadowOpacity)
            initialView.layer.shadowRadius = config.ToastShadowRadius
            initialView.layer.shadowOffset = config.ToastShadowOffset
        }
        
        return initialView
    }
    
    fileprivate func addContentsStackView(toWrapperView wrapperView: UIView, withConfiguration config: ToastConfig) -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = UIColor.clear
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = config.ToastVerticalMargin
        stackView.setContentHuggingPriority(UILayoutPriority(rawValue: 1000), for: .vertical)
        stackView.setContentHuggingPriority(UILayoutPriority(rawValue: 1000), for: .horizontal)
        
        wrapperView.addSubview(stackView)
        stackView.centerXAnchor.constraint(equalTo: wrapperView.centerXAnchor).isActive = true
        let leftSideConstraint = stackView.leftAnchor.constraint(greaterThanOrEqualTo: wrapperView.leftAnchor, constant: config.ToastHorizontalMargin)
        leftSideConstraint.priority = UILayoutPriority(rawValue: 1000)
        leftSideConstraint.isActive = true
        let rightSideConstraint = stackView.rightAnchor.constraint(lessThanOrEqualTo: wrapperView.rightAnchor, constant: -config.ToastHorizontalMargin)
        rightSideConstraint.priority = UILayoutPriority(rawValue: 1000)
        rightSideConstraint.isActive = true
        let leftSideEqualConstraint = stackView.leftAnchor.constraint(equalTo: wrapperView.leftAnchor, constant: config.ToastHorizontalMargin)
        leftSideEqualConstraint.priority = UILayoutPriority(rawValue: 250)
        leftSideEqualConstraint.isActive = true
        let rightSideEqualConstraint = stackView.rightAnchor.constraint(equalTo: wrapperView.rightAnchor, constant: -config.ToastHorizontalMargin)
        rightSideEqualConstraint.priority = UILayoutPriority(rawValue: 250)
        rightSideEqualConstraint.isActive = true
        stackView.topAnchor.constraint(equalTo: wrapperView.topAnchor, constant: config.ToastVerticalMargin).isActive = true
        stackView.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor, constant: -config.ToastVerticalMargin).isActive = true
        
        return stackView
    }
    
    
    fileprivate func addButton(_ image: UIImage, toStackView stackView: UIStackView) {
        
        let btn = UIButton(type: .custom)
        btn.setImage(image, for: .normal)
        
        //let imageView = UIImageView(image: image)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setContentHuggingPriority(UILayoutPriority(rawValue: 1000), for: .horizontal)
        btn.setContentHuggingPriority(UILayoutPriority(rawValue: 1000), for: .vertical)
        
        stackView.addArrangedSubview(btn)
    }
    
    fileprivate func addImage(_ image: UIImage, toStackView stackView: UIStackView) {
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.setContentHuggingPriority(UILayoutPriority(rawValue: 1000), for: .horizontal)
        imageView.setContentHuggingPriority(UILayoutPriority(rawValue: 1000), for: .vertical)
        
        stackView.addArrangedSubview(imageView)
    }
    
    fileprivate func addMessage(_ msg: String?, andTitle title: String?, toStackView parentStackView: UIStackView, withConfiguration config: ToastConfig) {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = UIColor.clear
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = config.ToastVerticalMargin
        parentStackView.addArrangedSubview(stackView)
        
        stackView.setContentHuggingPriority(UILayoutPriority(rawValue: 1000), for: .vertical)
        stackView.setContentHuggingPriority(UILayoutPriority(rawValue: 1000), for: .horizontal)
        
        if let title = title {
            let titleLabel = UILabel()
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            titleLabel.numberOfLines = config.ToastMaxTitleLines
            titleLabel.font = UIFont(name: UIView.hr_toastFontName(), size: config.ToastFontSize)
            titleLabel.textAlignment = .center
            titleLabel.lineBreakMode = .byWordWrapping
            titleLabel.textColor = UIView.hr_toastFontColor()
            titleLabel.backgroundColor = UIColor.clear
            titleLabel.alpha = 1.0
            titleLabel.text = title
            
            titleLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 751), for: .vertical)
            stackView.addArrangedSubview(titleLabel)
        }
        
        if let msg = msg {
            let msgLabel = UILabel()
            msgLabel.translatesAutoresizingMaskIntoConstraints = false
            msgLabel.numberOfLines = config.ToastMaxMessageLines
            //msgLabel.font = UIFont(name: UIView.hr_toastFontName(), size: config.ToastFontSize)
            let font  = UIFont.getFont(with: .NunitoRegular, size: 14)
            msgLabel.font = font
            msgLabel.lineBreakMode = .byWordWrapping
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 2
            if !config.isTextAlignmentLeft {
                msgLabel.textAlignment = .center
            } else {
                msgLabel.textAlignment = .left
            }
            //msgLabel.textAlignment = .center
            msgLabel.textColor = UIView.hr_toastFontColor()
            if config.isFontBlack {
               // msgLabel.textColor = Application_Black_Gray
            }
            msgLabel.backgroundColor = UIColor.clear
            msgLabel.alpha = 1.0
            
            if config.isAttributedString == true {
                //let font  = UIFont.getFont(with: .NunitoBold, size: 13)
              
                var boldAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.getFont(with: .NunitoBold, size: 14)]
                
                var tempStr = ""
                if msg.contains("View cart") {
                   // DLog(message: "Tests....")
                    tempStr = "View Cart >"
                }
                else if msg.contains("Check my cart") {
                    tempStr = "Check my cart >"
                    boldAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont.getFont(with: .NunitoBold, size: 14)]
                }
                else if msg.contains("Check it now") {
                    tempStr = "Check it now >"
                    boldAttributes = [NSAttributedString.Key.foregroundColor:UIColor.gray, NSAttributedString.Key.font: UIFont.getFont(with: .NunitoBold, size: 14)]
                }
                

                let strComm = NSMutableAttributedString(string: tempStr, attributes: boldAttributes)
                var mutStr = msg.replacingOccurrences(of: "Check it now", with: "")
                mutStr = mutStr.replacingOccurrences(of: "Check my cart", with: "")
                mutStr = mutStr.replacingOccurrences(of: "View cart", with: "")
                
                let attributedStr = NSMutableAttributedString(string:mutStr)
                attributedStr.append(strComm)
                attributedStr.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedStr.length))
                msgLabel.attributedText = attributedStr
            } else {
                msgLabel.text = msg
            }
            var padding =  CGFloat(0)
            if !config.isFullWidth {
                padding = (1 - config.ToastMaxWidth) / 2
            }
            
            let sidePadding = self.bounds.width * padding
            var labelPadding = CGFloat(40)
            if  config.hasCancelButton || config.hasInfoButton {
                labelPadding = 80
            }
           // DLog(message: "\(self.bounds.width - ((sidePadding * 2) + labelPadding))")
            msgLabel.preferredMaxLayoutWidth = (self.bounds.width - ((sidePadding * 2) + labelPadding))
            msgLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 751), for: .vertical)

            stackView.addArrangedSubview(msgLabel)
           
        }
    }
    
}
