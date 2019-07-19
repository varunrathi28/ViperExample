//
//  ListCell.swift
//  ViperStore
//
//  Created by Varun Rathi on 19/07/19.
//  Copyright © 2019 Varun Rathi. All rights reserved.
//

import UIKit

class ListCell: UITableViewCell {
    
    static let Identifier = "ListCell"
    
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var priceLabel: UILabel!
    @IBOutlet internal var productImageView: UIImageView!
    
    func configureWithProduct(product: StoreProduct) {
        guard let productName = product.name else {
            return
        }
        
        nameLabel.text = productName
        productImageView.image = UIImage(named: product.imageName)
    }
    
}
