//
//  AppTheme.swift
//  SDGE Near Miss
//
//  Created by Ujwal K Raikar on 10/10/19.
//  Copyright © 2019 Incture. All rights reserved.
//

import Foundation
import UIKit

struct AppTheme {
    static let themeColor = UIColor.blue

    static func configureTheme() {
        configureNavigationbarTheme()
    }
    
    static func configureNavigationbarTheme() {
        
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithDefaultBackground()
            UINavigationBar.appearance().tintColor = .white
            UINavigationBar.appearance().barTintColor = .white
            UINavigationBar.appearance().isTranslucent = false
            UINavigationBar.appearance().barTintColor = UIColor(rgb: 0x042037)
        } else {
            // Fallback on earlier versions
            UINavigationBar.appearance().tintColor = .white
            UINavigationBar.appearance().barTintColor = .blue
            UINavigationBar.appearance().isTranslucent = false
            UISearchBar.appearance().tintColor = UIColor(rgb: 0x042037)
        }
    }
}
