//
//  SDGEConstants.swift
//  SDGE Near Miss
//
//  Created by Naveenkumar.KN on 11/10/19.
//  Copyright © 2019 Incture. All rights reserved.
//

import Foundation
import UIKit

let baseURL = "https://incidentsmanagementurful4uomy.hana.ondemand.com/incidents_management/incidents/"
let imgBaseURL = "https://incidentsmanagementurful4uomy.hana.ondemand.com/incidents_management/incidents/"

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}
enum ContentType: String {
    case json = "application/json"
}

struct K {
    struct ServerURL {
        static let serverbaseURL = baseURL
        static let imageBaseURL = imgBaseURL
    }
}

let APP_DELEGATE : AppDelegate = UIApplication.shared.delegate as! AppDelegate
let applicvation_Color = UIColor(red: 12.0, green: 38.0, blue: 90.0, alpha: 1.0)
let Application_Blue_Color = UIColor(red: 62.0, green: 114.0, blue: 196.0, alpha: 1.0)
let Application_SKYBlue_Color = UIColor(red: 0.0, green: 122.0, blue: 255.0, alpha: 1.0)
