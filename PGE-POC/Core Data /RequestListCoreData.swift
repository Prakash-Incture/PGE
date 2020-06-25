//
//  RequestListCoreData.swift
//  PGE-POC
//
//  Created by prakash on 23/06/20.
//  Copyright © 2020 incture. All rights reserved.
//

import Foundation
import CoreData
class RequestListCoreData:CoreDataProtocol {
  
    var persistantContainer: NSPersistentContainer
    var isSyncInprogress: Bool = false
    
    required init(modelName: String) {
        self.persistantContainer = NSPersistentContainer(name: modelName)
    }
    
    func load(completion: (()-> Void)? = nil) {
        self.persistantContainer.loadPersistentStores { (storeDescription, error) in
            guard error == nil else { fatalError("unable to initialise") }
            completion?()
        }
    }
    func saveRequest(_ request: RequestModel,  withDate date: Date,type : String) {
        let offlineUpdate = RequestList(context: self.viewContext)
        offlineUpdate.date = Date()
        offlineUpdate.requestType = CategorySigleton.shared.categoryName.map { $0.rawValue }
        offlineUpdate.requestModel = RequestListCoreData.self.archive(incidentData: request)
        self.saveChanges()
    }
    
    func removePreviousData(fetchRequest: NSFetchRequest<NSFetchRequestResult>, predicate: NSPredicate?) {
        fetchRequest.predicate = predicate
        
        if let result = try? self.viewContext.fetch(fetchRequest), !result.isEmpty {
            for object in result {
                self.removeOldData(object: object as! NSManagedObject)
            }
        }
    }
    func fetchAllData() -> [NSManagedObject] {
        return get(withPredicate: NSPredicate(value:true))
    }
    
     func get(withPredicate queryPredicate: NSPredicate) -> [NSManagedObject]{
           let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "RequestList")
           
           fetchRequest.predicate = queryPredicate
           
           do {
            let response = try self.viewContext.fetch(fetchRequest)
               return response as! [RequestList]
               
           } catch let error as NSError {
               // failure
               print(error)
               return [RequestList]()
           }
       }
       
    
}
extension RequestListCoreData{
    static func archive(incidentData: RequestModel) -> Data {
        var incident = Data()
        do{
            incident = try JSONEncoder().encode(incidentData)
        }catch{
            print("Encoding error !")
        }
        return incident
    }
    
    func unarchive(incident: Data) -> RequestModel {
        var incidentData = RequestModel()
        do{
            incidentData = try JSONDecoder().decode(RequestModel.self, from: incident)
        }catch{
            print("Decoding error !")
        }
        return incidentData
    }
}
    
    
