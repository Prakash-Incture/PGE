//
//  Incident.swift
//  SDGE Near Miss
//
//  Created by Ujwal K Raikar on 09/10/19.
//  Copyright © 2019 Incture. All rights reserved.
//

import Foundation

enum CloseCallCategory: Int,CaseIterable {
    case equipment
    case material
    case animal
    case VehicleBicycle
    case VehicleChilderen
    case VehicleEmployee
    case VehiclePedestrian
    case VehicleWitness
    case Surface
    case Others
    case Doginyard
    case DogLose
    case EmpObservation
    case EquipmentOrMaterial
    case IrateCustomer
    case Personal
    
    var value: String {
        switch self {
        case .equipment:
            return "Equipment"
        case .material:
            return "Material"
        case .animal:
            return "Animal - Not Dog"
        case .VehicleBicycle:
           return "Vehicle - Bicycle"
        case .VehicleChilderen:
            return "Vehicle - Child(ren)"
        case .VehicleEmployee:
            return "Vehicle - Employee"
        case .VehiclePedestrian:
            return "Vehicle - Pedestrian"
        case .VehicleWitness:
            return "Vehicle - Witness"
        case .Surface:
            return "Walking Surface"
        case .Others:
            return "Others"
        case .Doginyard:
             return "Dog - in Yard of House"
        case .DogLose:
            return "Dog - Loose"
        case .EmpObservation:
            return "Employee Observation"
        case .EquipmentOrMaterial:
            return "Equipment or Materials"
        case .IrateCustomer:
            return "Irate Customer"
        case .Personal:
            return "Personal Protective Equipment"
        }
    }
}

enum ImpactCategory: Int, CaseIterable {
    case ee
    case eeOrCustomer
    case eeOrPublic
    case customerOrPublic
    case other
    
    var value: String {
        switch self {
        case .ee:
            return "EE could have been injured"
        case .eeOrCustomer:
            return "EE or customer(s) could have been injured"
        case .eeOrPublic:
            return "EE or public could have been injured"
        case .customerOrPublic:
            return "Customer(s) or public could have been injured"
        case .other:
            return "Other"
        }
    }
}

class Incident {
    var status: Bool?
    var id: String?
    var dateOfIncident: String?
    var approTimeOfIncidet: String?
    var closeCallCategory: String?
    var impactCategory: String?
    var vehicalInvolved: Bool?
    var equipmentInvolved: Bool?
    var whatHappened: String?
    var whatTaskWasPerformed: String?
    var howToPreventInFuture: String?
    var wouldAdditionalTrainingHelp: Bool?
    var trainingRecommendation: String?
    var attachments: [String]?
    var submitAnonymously: Bool?
    var name: String?
    var phoneNumber: String?
    var newTime : Date?
    var newDate : Date?
}
