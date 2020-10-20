//
//  ProductDescription.swift
//  24h Online Store
//
//  Created by macboock pro on 10/19/20.
//  Copyright © 2020 macboock pro. All rights reserved.
//

import UIKit

class ProductDescription: UITableViewCell {
    static let reuseIdentfire = "ProductDescription"
    @IBOutlet weak var productDescription: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
