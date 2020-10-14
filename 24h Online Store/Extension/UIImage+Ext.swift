//
//  UIImage+Ext.swift
//  24h Online Store
//
//  Created by macboock pro on 10/6/20.
//  Copyright © 2020 macboock pro. All rights reserved.
//

import UIKit
extension UIImage{
    //to create top line view in tabBar 
  static func createSelectionIndicator(size: CGSize) -> UIImage {
             UIGraphicsBeginImageContextWithOptions(size, false, 0)
              UIColor(named: "mainColor")?.setFill()
    UIRectFill(CGRect(x: 0, y: 0, width: size.width, height: 1.5))
             let image = UIGraphicsGetImageFromCurrentImageContext()
             UIGraphicsEndImageContext()
             return image!
         }
}
