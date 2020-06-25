//
//  ProblemInfoViewModel.swift
//  PGE-POC
//
//  Created by PremKumar on 08/05/20.
//  Copyright © 2020 incture. All rights reserved.
//

import Foundation

enum MaterialInfoType {
    case materialCode
    case manufacturer
    case materialType
    case age
    case application
    case materialDesc
    case manufactureSerialNo
    case purchaseOrder
    case outage
    case failedInService
    case systemPressure
    case leakNumber
    case leakGrade
    case soilType
    case grade1Failure
}

protocol CellType {
    var type: MaterialInfoType { get }
}

protocol KeyValueItem {
    var key: String { get }
    var value: String { get }
    var isMandatory: Bool { get }
}

struct MaterialInfoViewModel {
    var dataArr: [MaterialInfoItem] = []
    init(info: MaterialInfoModel) {
        let materialCode = MaterialInfoItem(type: .materialCode, key: "Material Code", value: info.materialCode ?? "", isMandatory: false)
        let manufacturer = MaterialInfoItem(type: .manufacturer, key: "Manufacturer*", value: info.manufacturer ?? "", isMandatory: true)
        let materialType = MaterialInfoItem(type: .materialType, key: "Material Type*", value: info.materialType ?? "", isMandatory: true)
        let age = MaterialInfoItem(type: .age, key: "Age*", value: info.age ?? "", isMandatory: true)
        let application = MaterialInfoItem(type: .application, key: "Application", value: info.application ?? "", isMandatory: false)
        let materialDesc = MaterialInfoItem(type: .materialDesc, key: "Material's Description", value: info.materialDesc ?? "", isMandatory: false)
        let manufactureSerialNo = MaterialInfoItem(type: .manufactureSerialNo, key: "Manufacturer's Serial No", value: info.manufactureSerialNo ?? "", isMandatory: false)
        let purchaseOrder = MaterialInfoItem(type: .purchaseOrder, key: "Purchase Order", value: info.purchaseOrder ?? "", isMandatory: false)
        let outage = MaterialInfoItem(type: .outage, key: "Outage", value: info.outage ?? "", isMandatory: true)
        let failedInService = MaterialInfoItem(type: .failedInService, key: "Failed in Service", value: info.failedInService ?? "", isMandatory: false)
        let systemPressure = MaterialInfoItem(type: .systemPressure, key: "System Pressure", value: info.systemPressure ?? "", isMandatory: false)
        let leakNumber = MaterialInfoItem(type: .leakNumber, key: "Leak #*", value: info.leakNumber ?? "", isMandatory: true)
        let leakGrade = MaterialInfoItem(type: .leakGrade, key: "Leak Grade*", value: info.leakGrade ?? "", isMandatory: true)
        let soilType = MaterialInfoItem(type: .soilType, key: "Soil Type", value: info.soilType ?? "", isMandatory: false)
        let grdade1Failure = MaterialInfoItem(type: .grade1Failure, key: "Material 1 Machanical Filling Failure?*", value: info.grade1Failure ?? "", isMandatory: true)
        
        dataArr = [materialCode, manufacturer, materialType, age, application, materialDesc, manufactureSerialNo, purchaseOrder, outage, failedInService, systemPressure, leakNumber, leakGrade, soilType, grdade1Failure]
    }
}

struct MaterialInfoItem: CellType, KeyValueItem {
    var type: MaterialInfoType
    var key: String
    var value: String
    var isMandatory: Bool
}

struct MaterialInfoModel {
    var materialCode: String?
    var manufacturer: String?
    var materialType: String?
    var age: String?
    var application: String?
    var materialDesc: String?
    var manufactureSerialNo: String?
    var purchaseOrder: String?
    var outage: String?
    var failedInService: String?
    var systemPressure: String?
    var leakNumber: String?
    var leakGrade: String?
    var soilType: String?
    var grade1Failure: String?
}

struct MaterialInfoLookUps {
    static var manufacturer = ["Borer-Larkin", "Ruecker and Sons", "Ward - Abbott"]
    static var materialType = ["Steel", "Iron", "Copper"]
    static var age = ["< 2 yrs", "2 - 5 yrs", "> 5 yrs"]
    static var application = ["Company", "Factory", "Residential"]
    static var systemPressure = ["22 Hg", "36 Hg", "48 Hg"]
    static var soilType = ["Sandy", "Clay", "Silt"]
}
