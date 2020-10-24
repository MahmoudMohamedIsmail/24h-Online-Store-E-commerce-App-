//
//  CartVC.swift
//  24h Online Store
//
//  Created by macboock pro on 10/6/20.
//  Copyright © 2020 macboock pro. All rights reserved.
//

import UIKit

class CartVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("cart did loaded-------cart")

    }
    override func viewWillAppear(_ animated: Bool) {
           tabBarController?.tabBar.selectedItem?.selectedImage = UIImage(systemName: "cart.fill")
        print("cart will appear #######")
       }
}
