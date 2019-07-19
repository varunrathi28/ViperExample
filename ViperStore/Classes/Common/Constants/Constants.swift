//
//  Constants.swift
//  ViperStore
//
//  Created by Varun Rathi on 19/07/19.
//  Copyright © 2019 Varun Rathi. All rights reserved.
//

import Foundation

enum Category : Int {
    
    case Electronics = 1, Furniture
    
    func getTitle()->String {
        switch self {
        case .Electronics:
            return "Electronics"
        default:
            return "Furniture"
        }
    }
}
