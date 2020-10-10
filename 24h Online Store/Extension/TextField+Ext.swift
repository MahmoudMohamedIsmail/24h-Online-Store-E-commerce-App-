//
//  TextField+Ext.swift
//  24h Online Store
//
//  Created by macboock pro on 9/28/20.
//  Copyright © 2020 macboock pro. All rights reserved.
//

import UIKit
extension UITextField
{
    func makeRounded() {
        self.layer.cornerRadius = self.frame.height/2
        self.layer.borderColor = UIColor(named: "mainColor")?.cgColor
        self.layer.borderWidth = 1.5
        self.layer.shadowColor = UIColor(named: "mainColor")?.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowOpacity = 0.3
    }
    
    func setLeftView(_ view: UIImageView, padding: CGFloat=10) {
        view.translatesAutoresizingMaskIntoConstraints = true
        
        let outerView = UIImageView()
        outerView.translatesAutoresizingMaskIntoConstraints = false
        outerView.addSubview(view)
        
        outerView.frame = CGRect(
            origin: .zero,
            size: CGSize(
                width: view.frame.size.width + padding,
                height: view.frame.size.height + padding
            )
        )
        
        view.center = CGPoint(
            x: outerView.bounds.size.width / 2,
            y: outerView.bounds.size.height / 2
        )
        
        rightView = outerView
    }
    func setIcon(_ imageName: String="eye.fill") {
        
        let image = UIImage(systemName: imageName);
        let iconView = UIImageView(frame:
            CGRect(x: 10, y: 2.5, width: 25, height: 25))
        iconView.image = image?.withRenderingMode(.alwaysTemplate);
        iconView.tintColor = .darkGray
        iconView.contentMode = .scaleAspectFit
        
        let iconContainerView: UIView = UIView(frame:
            CGRect(x: 0, y: 0, width: 45, height: 30))
        iconContainerView.addSubview(iconView)
                rightView = iconContainerView
                rightViewMode = .whileEditing
    }
}

