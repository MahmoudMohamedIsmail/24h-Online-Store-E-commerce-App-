//
//  MyAccountVC.swift
//  24h Online Store
//
//  Created by macboock pro on 10/6/20.
//  Copyright © 2020 macboock pro. All rights reserved.
//

import UIKit

class MyAccountVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.selectedItem?.selectedImage = UIImage(systemName: "person.fill")
    }
}
