//
//  ProductDetailsCell.swift
//  24h Online Store
//
//  Created by macboock pro on 10/19/20.
//  Copyright © 2020 macboock pro. All rights reserved.
//

import UIKit

class ProductDetailsCell: UITableViewCell {

    static let reuseIdentfire = "ProductDetailsCell"
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productOldPrice: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productDiscount: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        productDiscount.layer.cornerRadius = 5
        productDiscount.layer.masksToBounds = true
       
        
    }
}
