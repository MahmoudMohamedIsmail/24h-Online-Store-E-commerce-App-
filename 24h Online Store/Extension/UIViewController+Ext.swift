//
//  UIViewController+Ext.swift
//  24h Online Store
//
//  Created by macboock pro on 10/4/20.
//  Copyright © 2020 macboock pro. All rights reserved.
//

import UIKit
extension UIViewController {
    
    func makeAlert(title:String, message:String) {
        DispatchQueue.main.async {
            
            let alert = UIAlertController(title: title , message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }}
    
}
