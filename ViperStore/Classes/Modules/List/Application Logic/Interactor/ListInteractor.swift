//
//  ListInteractor.swift
//  ViperStore
//
//  Created by Varun Rathi on 19/07/19.
//  Copyright © 2019 Varun Rathi. All rights reserved.
//

import Foundation
import RxSwift

class ListInteractor {
    
    let dataManager : ListDataManager
    let products : Variable<[StoreProduct]> = Variable([])
    
    init(dataManager: ListDataManager) {
        self.dataManager = dataManager
    }
    
    func fetchProductsFromStore(){
        self.products.value.removeAll()
        for prod in dataManager.arrProducts{
            products.value.append(prod)
        }
    }
    
}
