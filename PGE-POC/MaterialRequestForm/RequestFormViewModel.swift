//
//  RequestFormViewModel.swift
//  PGE-POC
//
//  Created by PremKumar on 07/05/20.
//  Copyright © 2020 incture. All rights reserved.
//

import Foundation
import UIKit

enum HeaderTitles: String {
    case requesterInfo = "1. Requester Info"
    case materialInfo = "2. Material Info"
    case problemInfo = "3. Problem Info"
}


enum MaterialRequestModelData: String {
    case reporterName = "RName"
    case reporterLANID  = "RLanId"
    case divisionPhoneNo = "Dphone"
    case divisionName = "DName"
    case divisionLANID = "DlanID"
    case supervisorPhoneNo = "Sphone"
    case supervisorName = "Sname"
    case supervisorLANID = "SLanID"
    case supervisorDate = "Sdate"
    case divisionDate = "Ddate"
    case reporterDate  = "Rdate"
    case cellPhoneDivision = "CPhone"
    case cellPhoneSupervisor = "SPhone"
}

enum MaterialProblemInfoModelData: String {
    case qnty = "qnt"
    case shortDesc  = "Short"
    case complaint = "complaint"
    case cause = "cause"
    case correction = "correction"
    case eventNumber = "eventNumber"
    case additional = "additional"
    case materialStored = "materialStored"
    case MFDate = "MFDate"
    case installedDate = "installedDate"
}


class RequestFormViewModel {
    
    public func getHeaderTitles() -> [HeaderTitles] {
        return [.requesterInfo, .materialInfo, .problemInfo]
    }
}

enum CreateMaterialViewModelItemType {
    
    case materialCode
    case manufacturer
    case materialType
    case age
    case application
    case materialDescription
    case manuSerialNo
    case purchaseOrder
    case outage
    case failedInService
    case operating
}
