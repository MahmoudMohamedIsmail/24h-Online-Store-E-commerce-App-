//
//  UIImageView+Ext.swift
//  24h Online Store
//
//  Created by macboock pro on 9/28/20.
//  Copyright © 2020 macboock pro. All rights reserved.
//

import UIKit
extension UIImageView{
    
    func makeRounded() {
           self.layer.borderWidth = 1.5
           self.layer.masksToBounds = false
           self.layer.borderColor = UIColor(named: "mainColor")?.cgColor//UIColor.black.cgColor
           self.layer.cornerRadius = self.frame.height / 2
           self.clipsToBounds = true
       }
}
