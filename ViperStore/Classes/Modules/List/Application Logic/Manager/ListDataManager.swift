//
//  ListDataManager.swift
//  ViperStore
//
//  Created by Varun Rathi on 19/07/19.
//  Copyright © 2019 Varun Rathi. All rights reserved.
//

import Foundation

class ListDataManager {

    var dataStore = CoreDataStore.sharedInstance
    var arrProducts = [StoreProduct]()
    
    init() {
        if let products = getStoreProductsDataFromPlist()  {
            arrProducts = products
        }
    }
    
    func getStoreProductsDataFromPlist()->[StoreProduct]? {
        if let fileUrl = Bundle.main.url(forResource: "Products", withExtension: "plist"),
            let data = try? Data(contentsOf: fileUrl) {
            if let result = try? PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String: Any] {
                if let dict = result, let array = (dict["Products"] as? [Any])  {
                    let productsArray = products(from: array)
                    //                    print(productsArray.count)
                    return productsArray
                }
            }
        }
        return nil
    }
    
    func products(from array:[Any]) -> [StoreProduct] {
        var productsArray = [StoreProduct]()
        
        for value in array {
            
            if let dic = value as? [String:Any] {
                let newProduct = StoreProduct()
                newProduct.categoryId = dic["categoryId"] as? NSNumber
                newProduct.productId = dic["productId"] as? NSNumber
                newProduct.imageName = dic["imageName"] as? String
                newProduct.name = dic["name"] as? String
                newProduct.price = dic["price"] as? NSNumber
                
                productsArray.append(newProduct)
            }
            
        }
        return productsArray
    }
    
}
