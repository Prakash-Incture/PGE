//
//  AlertHelper.swift
//  SDGE Near Miss
//
//  Created by Ujwal K Raikar on 10/10/19.
//  Copyright © 2019 Incture. All rights reserved.
//

import Foundation
import UIKit

class AlertHelper {
    
    static func displayAlert(with title: String, error: String?, buttonTitle: String = "Ok", viewController: UIViewController, okActionHandler: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: error, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: okActionHandler))
        DispatchQueue.main.async {
            // Present the alertController
            viewController.present(alertController, animated: true)
        }
    }
}
