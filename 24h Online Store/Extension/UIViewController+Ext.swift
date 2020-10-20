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
extension UIView {
    static var loaderLayer = CAReplicatorLayer()
    
    func  makeRoundedBorder() {
        self.layer.cornerRadius = 3
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 0.5
    }
    
    func showAnimatingLoader() {
        
        DispatchQueue.main.async {
            
            UIView.loaderLayer = CAReplicatorLayer()
            var x = (self.frame.size.width - 95)/2
            let y = self.frame.size.height/2
            x = x > self.frame.size.width  ? 0:x
            UIView.loaderLayer.frame = CGRect(x: x, y: y, width: 0, height: 0)
            
            let circle = CALayer()
            circle.frame = CGRect(x: 0, y: 0, width:20, height: 20)
            circle.cornerRadius = circle.frame.width / 2
            circle.backgroundColor = UIColor(named: "mainColor")?.cgColor
            
            UIView.loaderLayer.addSublayer(circle)
            UIView.loaderLayer.instanceCount = 4
            UIView.loaderLayer.instanceTransform = CATransform3DMakeTranslation(25, 0, 0)
            
            let anim = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
            anim.fromValue = 1.0
            anim.toValue = 0.2
            anim.duration = 1
            anim.repeatCount = .infinity
            circle.add(anim, forKey: nil)
            UIView.loaderLayer.instanceDelay = anim.duration / Double(UIView.loaderLayer.instanceCount)
            
            self.layer.addSublayer(UIView.loaderLayer)
        }
        
    }
    
    func hideAnimatingLoader() {
        DispatchQueue.main.async {
            UIView.loaderLayer.removeFromSuperlayer()
        }
    }
}
extension UICollectionView
{
    static var tabBar = UITabBar()
}
