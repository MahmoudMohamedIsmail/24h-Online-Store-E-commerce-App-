//
//  UIButton+Ext.swift
//  24h Online Store
//
//  Created by macboock pro on 9/28/20.
//  Copyright © 2020 macboock pro. All rights reserved.
//

import UIKit
extension UIButton {
    
    static var dotsLayer = CAReplicatorLayer()

    func makeRounded() {
        self.layer.cornerRadius = self.frame.height/2
        self.layer.shadowColor = UIColor(named: "mainColor")?.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 4) //CGSize.zero
        self.layer.shadowOpacity = 0.5
    }
    func showAnimatingDots() {
         DispatchQueue.main.async {
        var x = (self.frame.width - (4*(0.40*self.frame.height)+15))/2
        let y = (0.5*self.frame.height) - (0.20*self.frame.height)
        x = x > self.frame.width ? 0:x
        UIButton.dotsLayer = CAReplicatorLayer()
        // lay.frame = CGRect(x: 0, y: 8, width: 15, height: 7) //yPos == 12
        UIButton.dotsLayer.frame = CGRect(x: x, y: y, width: 0, height: 0)
        let circle = CALayer()
        circle.frame = CGRect(x: 0, y: 0, width: (0.40*self.frame.height), height: (0.40*self.frame.height))
        circle.cornerRadius = circle.frame.width / 2
        circle.backgroundColor = UIColor(named: "mainColor")?.cgColor
        
        UIButton.dotsLayer.addSublayer(circle)
        UIButton.dotsLayer.instanceCount = 4
        UIButton.dotsLayer.instanceTransform = CATransform3DMakeTranslation((0.40*self.frame.height)+5, 0, 0)
        let anim = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        anim.fromValue = 1.0
        anim.toValue = 0.2
        anim.duration = 1
        anim.repeatCount = .infinity
        circle.add(anim, forKey: nil)
        UIButton.dotsLayer.instanceDelay = anim.duration / Double(UIButton.dotsLayer.instanceCount)
        
       
            self.backgroundColor = .white
            self.layer.shadowColor = UIColor.white.cgColor
            self.isEnabled = false
        self.layer.addSublayer(UIButton.dotsLayer)
        }
    }
    
    func hideAnimatingDots() {
        DispatchQueue.main.async {
        self.backgroundColor = UIColor(named: "mainColor")
        self.layer.shadowColor = UIColor(named: "mainColor")?.cgColor
        self.isEnabled = true
        UIButton.dotsLayer.removeFromSuperlayer()
        }
    }
}

