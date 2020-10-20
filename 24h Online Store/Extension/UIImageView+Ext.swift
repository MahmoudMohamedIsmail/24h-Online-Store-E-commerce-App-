//
//  UIImageView+Ext.swift
//  24h Online Store
//
//  Created by macboock pro on 9/28/20.
//  Copyright © 2020 macboock pro. All rights reserved.
//

import UIKit
extension UIImageView{
    static var imageCache = NSCache<NSString, UIImage>()
    func makeRounded() {
        self.layer.borderWidth = 5
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor(named: "mainColor")?.cgColor//UIColor.black.cgColor
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
    
    func downloaded(from urlName: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        
        if let cachedImage = UIImageView.imageCache.object(forKey: urlName as NSString) {
            self.image = cachedImage
        }
        else{
            DispatchQueue.global().async {
                let urlString = urlName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
             
                guard let url = URL(string: urlString ?? "") else {
                    print(urlName)
                    return}
                URLSession.shared.dataTask(with: url) { data, response, error in
                    guard let data = data, error == nil, let image = UIImage(data: data)
                        else { return }
                    DispatchQueue.main.async() { [weak self] in
                        guard let self = self else {return}
                        UIImageView.imageCache.setObject(image, forKey: urlName as NSString)
                        self.image = image
                    }
                }.resume()
                
                
            }
        }
    }
}


