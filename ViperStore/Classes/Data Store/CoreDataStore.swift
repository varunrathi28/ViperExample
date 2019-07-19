//
//  CoreDataStore.swift
//  ViperStore
//
//  Created by Varun Rathi on 19/07/19.
//  Copyright © 2019 Varun Rathi. All rights reserved.
//

import UIKit
import CoreData
import RxSwift


class CoreDataStore:NSObject {
    static let sharedInstance  = CoreDataStore()
    var persistentStoreCoordinator : NSPersistentStoreCoordinator!
    var managedObjectModel : NSManagedObjectModel!
    var managedObjectContext : NSManagedObjectContext!
    var cartItemsArray: Variable<[Product]> = Variable([])
    
    //MARK: Initializer
    
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
    
    //MARK: - READ
    
    func fetchCartItems(_ completionBlock:(([Product])->Void)!){
        self.fetchEnteriesInPredicate(completionBlock)
    }
    
    func fetchEnteriesInPredicate(_ completionBlock:(([Product])->Void)!) {
        
        let fetchRequest : NSFetchRequest<Product> = Product.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "productId", ascending: true)]
        fetchRequest.returnsObjectsAsFaults = false
        
        managedObjectContext.perform {
            let fetchResults = try! self.managedObjectContext.fetch(fetchRequest)
            completionBlock(fetchResults)
        }
    }
    
    //MARK: Save
    
    
    func save(){
    
        do {
            try managedObjectContext.save()
        }
        catch let error{
                print("Error Saving Context :\(error)")
        }
    }
    
    //MARK: Delete
    func deleteObject(cartItem: Product) {
        managedObjectContext.delete(cartItem)
    }
    
    func discardMOCChanges(){
        managedObjectContext.rollback()
    }
    
    //MARK: Insert
    
    func newCartItem()->Product {
        let cartItem = Product(context: managedObjectContext)
        return cartItem
    }
    
    func checkForSimilarCartItemAndDelete(cartItemToCheck: Product) {
        for cartItem in self.cartItemsArray.value {
            if cartItem.productId == cartItemToCheck.productId && cartItemToCheck != cartItem {
                deleteObject(cartItem: cartItem)
            }
        }
    }
    
    func deleteCartItem(withProductId productId: Int16) {
        for cartItem in self.cartItemsArray.value {
            if cartItem.productId == productId {
                deleteObject(cartItem: cartItem)
                save()
                break;
            }
        }
    }
}
