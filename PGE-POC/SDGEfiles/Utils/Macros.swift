//
//  Macros.swift
//  SDGE Near Miss
//
//  Created by Naveenkumar.KN on 11/10/19.
//  Copyright © 2019 Incture. All rights reserved.
//

import Foundation

func DLog( message: @autoclosure () -> String, filename: String = #file, function: String = #function, line: Int = #line){
    #if RELEASE_STAGING || RELEASE_QA || RELEASE_DEV || DEBUG_DEV || RELEASE_PROD
        let lastPathComponent = (filename as NSString).lastPathComponent
        NSLog("\(lastPathComponent):\(line): \(function): %@", message())
    #endif
}
