//
//  DashboardViewModel.swift
//  PGE-POC
//
//  Created by PremKumar on 06/05/20.
//  Copyright © 2020 incture. All rights reserved.
//

import Foundation
import UIKit

enum DashboardSections: String {
    case Material
    case Tools
    case Meter
    case Report
}

class DashboardViewModel {
    
    var getSectionTitles: [DashboardSections]{
        return [.Material, .Tools, .Meter, .Report]
    }
    
    public func getData(section: DashboardSections) -> DashboardModel {
        switch section {
        case .Material, .Meter, .Tools:
            return DashboardModel(sectionTitle: section.rawValue, dataModel: [DashboardDataModel(title: "Electrical", img: "electrical"), DashboardDataModel(title: "Gas", img: "gas"), DashboardDataModel(title: "Substation", img: "substation")])
        case .Report:
            return DashboardModel(sectionTitle: section.rawValue, dataModel: [DashboardDataModel(title: "Report", img: "report")])
        }
    }
    
}

class CategorySigleton {
    static let shared = CategorySigleton()
    var categoryName: DashboardSections?
    private init() {}
}
