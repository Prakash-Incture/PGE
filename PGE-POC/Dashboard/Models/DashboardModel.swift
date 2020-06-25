//
//  DashboardModel.swift
//  PGE-POC
//
//  Created by PremKumar on 06/05/20.
//  Copyright © 2020 incture. All rights reserved.
//

import Foundation
import  UIKit

struct DashboardModel: Codable {
    var sectionTitle: String?
    var dataModel: [DashboardDataModel]?
}

struct DashboardDataModel: Codable {
    var title, img: String?
}
