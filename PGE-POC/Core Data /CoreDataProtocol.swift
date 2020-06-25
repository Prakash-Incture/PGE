//
//  CoreDataProtocol.swift
//  PGE-POC
//
//  Created by prakash on 23/06/20.
//  Copyright © 2020 incture. All rights reserved.
//

import Foundation
import CoreData

// Coredata protocol
protocol CoreDataProtocol {
    init(modelName: String)
    var persistantContainer: NSPersistentContainer { get set }
    var viewContext: NSManagedObjectContext { get }
    var isSyncInprogress: Bool { get set }
 //   func saveRequest(_ request: Incident, for purpose: String?)
    func removePreviousData(fetchRequest: NSFetchRequest<NSFetchRequestResult>, predicate: NSPredicate?)
}

extension CoreDataProtocol {
    var viewContext: NSManagedObjectContext {
        return self.persistantContainer.viewContext
    }
    
    func saveChanges() {
        try? self.viewContext.save()
    }
    
    func removeOldData<managedObject: NSManagedObject>(object: managedObject) {
        self.viewContext.delete(object)
        try? self.viewContext.save()
    }
}
