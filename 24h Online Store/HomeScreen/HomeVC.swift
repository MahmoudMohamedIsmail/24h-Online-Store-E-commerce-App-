//
//  HomeVC.swift
//  24h Online Store
//
//  Created by macboock pro on 10/6/20.
//  Copyright © 2020 macboock pro. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class HomeVC: UIViewController {
    
    @IBOutlet weak var homeCollectionView: UICollectionView!
    let searchController = UISearchController(searchResultsController: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.selectedItem?.selectedImage = UIImage(systemName: "house.fill")
    }
    func setupUI(){
        // setup searchController in navigarionBar
        searchController.searchBar.searchTextField.backgroundColor = .white
        searchController.searchBar.searchTextField.tintColor = UIColor(named: "mainColor")
        searchController.searchBar.tintColor = .white
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        // Add top line view in tabBar
        let tabBar = self.tabBarController!.tabBar
        tabBar.selectionIndicatorImage = UIImage.createSelectionIndicator(size: CGSize(width: tabBar.frame.width/CGFloat(tabBar.items!.count), height:  tabBar.frame.height))
    }
    
}
