//
//  CoreDataStore.swift
//  ViperStore
//
//  Created by Varun Rathi on 19/07/19.
//  Copyright © 2019 Varun Rathi. All rights reserved.
//

import UIKit
import CoreData

class CoreDataStore:NSObject {
    static let sharedInstance  = CoreDataStore()
    var persistentStoreCoordinator : NSPersistentStoreCoordinator!
    var managedObjectModel : NSManagedObjectModel!
    var managedObjectContext : NSManagedObjectContext!
    
    
    override init() {
        managedObjectModel = NSManagedObjectModel.mergedModel(from: nil)
        persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        let domains = FileManager.SearchPathDomainMask.userDomainMask
        let directory = FileManager.SearchPathDirectory.documentDirectory
        let applicationDocumentsDirectory = FileManager.default.urls(for: directory, in: domains).first!
        let options = [NSMigratePersistentStoresAutomaticallyOption : true, NSInferMappingModelAutomaticallyOption : true]
        let storeURL = applicationDocumentsDirectory.appendingPathComponent("Product.sqlite")
        
        try! persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: options)
        
        managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
        managedObjectContext.undoManager = nil
        
        super.init()
        
    }
    
    
}
