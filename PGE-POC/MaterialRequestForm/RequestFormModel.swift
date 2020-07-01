//
//  RequestFormModel.swift
//  PGE-POC
//
//  Created by PremKumar on 07/05/20.
//  Copyright © 2020 incture. All rights reserved.
//

import Foundation

struct RequestModel:Codable {
    var materialRequest : RequestMaterialModel?
    var problemInfo:ProblemInfoModel?
    var incidentModelRequest:GetIncidentModelData?
    var materialInfo : MaterialInfoModel?
    init(){}
}

struct RequestMaterialModel:Codable {
    var reporterName : String? = "Samar Satpalkar"
    var reporterLANID : String? = "SQS7"
    var reporterDate : String? = "11/05/2020"
    var divisionPhoneNo : String?
    var divisionName : String?
    var divisionLANID : String?
    var divisionDate : String?
     var divisionCellPhone : String?
    var supervisorPhoneNo : String?
    var supervisorName : String?
    var supervisorLANID : String?
    var supervisorDate : String?
    var superVisorCellPhone : String?

}

struct ProblemInfoModel:Codable {
    var cause:String?
    var qnty:String?
    var shortDesc:String?
    var complients:String?
    var causeDesc:String?
    var correction:String?
    var manufaDate:String?
    var installedDate:String?
    var materialStored:String?
    var additionalInfo:String?
    var eventNumber:String?
}

struct MaterialInfoModel: Codable {
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

struct GetIncidentModelData:Codable {
    var incident_id : String?
    var location : String?
    var materialName : String?
    var landID : String?
    var status : String?
    var incident_logged_time : String?
    var incId : String?
}
