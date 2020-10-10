//
//  Helper.swift
//  24h Online Store
//
//  Created by macboock pro on 10/3/20.
//  Copyright © 2020 macboock pro. All rights reserved.
//

import UIKit
class Helper {
    
    
    class func restartApp() {
        guard let window = UIApplication.shared.keyWindow else { return }
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        var vc: UIViewController
        if getApiToken() == nil {
            // go to auth screen
            vc = sb.instantiateInitialViewController()!
        } else {
            // go to main screen
            vc = sb.instantiateViewController(withIdentifier: "main")
        }
        
        window.rootViewController = vc
        
        UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromLeft , animations: nil, completion: nil)
    }
    class func saveApiToken(token:String)
    {
        let def = UserDefaults.standard
        def.setValue(token, forKey: "api_token")
        def.synchronize()
        DispatchQueue.main.async {
        restartApp()
            
        }
       
    }
    
    class func getApiToken() -> String? {
        let def = UserDefaults.standard
        return def.object(forKey: "api_token") as? String
    }
    
}
