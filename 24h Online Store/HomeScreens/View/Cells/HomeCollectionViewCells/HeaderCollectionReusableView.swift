//
//  HeaderCollectionReusableView.swift
//  24h Online Store
//
//  Created by macboock pro on 10/15/20.
//  Copyright © 2020 macboock pro. All rights reserved.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {

    static let reuseIdentifer = "HeaderCollectionReusableView"
    @IBOutlet weak var headerName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
