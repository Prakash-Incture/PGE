//
//  UIViewController+Extension.swift
//  SDGE Near Miss
//
//  Created by Ujwal K Raikar on 10/10/19.
//  Copyright © 2019 Incture. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
   
}
extension UIFont {
    static func getFont(with type: CustomFontType, size: CGFloat) -> UIFont {
        let font = UIFont(name: type.rawValue, size: size) ?? UIFont()
        return font
    }
}

enum CustomNavType :String{
    case navWithLefttittle
    case navPlain
    case navWithBack
    case navWithFilter
    case naveWithNext
    case navWithSubit
}

class NavLeftTitleButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setTitle("PG&E", for: .normal)
//        self.frame = CGRect(x: 0.0, y: 0.0, width: 100, height: 30.0)
//        self.titleLabel?.font = UIFont.getFont(with: .NunitoRegular, size: 17)
    }
}

class NavBackButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
       self.setImage(UIImage(named: "back"), for: .normal)
    }
}
class NavFilterButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
       self.setImage(UIImage(named: "filter"), for: .normal)
    }
}
class NavNextButton: UIButton {
       override func layoutSubviews() {
        super.layoutSubviews()
        self.setTitle("Next", for: .normal)
        var size = 17.0
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            size = 17.0
        case .pad:
            size = 22.0
        default:
            return
        }
        self.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(size))
        self.setTitleColor(.white, for: .normal)
        self.contentHorizontalAlignment = .right
        self.frame = CGRect(x: 0.0, y: 0.0, width: 100, height: 30.0)
    }
}
class NavSubmitButton: UIButton {
       override func layoutSubviews() {
        super.layoutSubviews()
        self.setTitle("Submit", for: .normal)
        var size = 17.0
             switch UIDevice.current.userInterfaceIdiom {
             case .phone:
                 size = 17.0
             case .pad:
                 size = 22.0
             default:
                 return
             }
        self.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(size))
        self.setTitleColor(.white, for: .normal)
        self.contentHorizontalAlignment = .right

        self.frame = CGRect(x: 0.0, y: 0.0, width: 100, height: 30.0)
    }
}
class NavDeleteButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setImage(UIImage(named: "delete"), for: .normal)
        self.tintColor = .white
    }
}

enum CustomFontType: String {
    case NunitoBold = "Josefin Sans Bold",
    NunitoRegular = "JosefinSans-Regular"
}

