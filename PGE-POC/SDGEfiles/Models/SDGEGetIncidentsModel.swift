//
//  SDGEGetIncidentsModel.swift
//  SDGE Near Miss
//
//  Created by Naveenkumar.KN on 14/10/19.
//  Copyright © 2019 Incture. All rights reserved.
//

import Foundation

struct SDGEGetIncidentModel:Decodable {
    var message : String?
    var statusCode : Int?
    var obj : SDGEGetIncidentModelData?
    var objList : [SDGEGetIncidentModelData]?
}

struct SDGEGetIncidentModelData:Decodable {
    var incident_id : Int?
    var fileContentURL : [String]?
    var incident_logged_date : String?
    var close_call : String?
    var vehicle_involved : Bool?
    var equipment_involved : Bool?
    var impact : String?
    var what_happened : String?
    var task_performed : String?
    var prevent_in_future : String?
    var training_help : Bool?
    var training_recommendation : String?
    var attachments : Bool?
    var fileName : String?
    var status : String?
    var incident_logged_time : String?
    var isHavingAttachments : Bool?
    var fileContent : String?
}

struct SDGEPostIncidentModel:Decodable{
    var message : String?
    var statusCode : Int?
    var status : String?
}

//struct JsonModel:Decodable{
//    "incident_logged_date" : self.incident.dateOfIncident ?? "",
//                 "incident_logged_time" : self.incident.approTimeOfIncidet ?? "",
//                 "close_call" : self.incident.closeCallCategory ?? "",
//                 "impact" : self.incident.impactCategory ?? "",
//                 "vehicle_involved" : self.incident.vehicalInvolved ?? false,
//                 "equipment_involved" : self.incident.equipmentInvolved ?? false,
//                 "what_happened" : self.incident.whatHappened ?? "",
//                 "task_performed" : self.incident.whatTaskWasPerformed ?? "",
//                 "prevent_in_future" : self.incident.howToPreventInFuture ?? "",
//                 "training_help" : self.incident.wouldAdditionalTrainingHelp ?? false,
//                 "training_recommendation" : self.incident.trainingRecommendation ?? ""
//}
