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
    
    static let cellIdentifer = "reuseCellIdentifiers"
    @IBOutlet weak var homeCollectionView: UICollectionView!
    let searchController = UISearchController(searchResultsController: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        homeCollectionView.collectionViewLayout = createCompositionalLayout()
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
        //homeCollectionView.register(UICollectionViewCell, forCellWithReuseIdentifier: <#T##String#>)
        homeCollectionView.register(UINib(nibName: BannerCell.reuseIdentifer, bundle: nil), forCellWithReuseIdentifier: BannerCell.reuseIdentifer)
        homeCollectionView.register(UINib(nibName: CategoryCell.reuseIdentifer, bundle: nil), forCellWithReuseIdentifier: CategoryCell.reuseIdentifer)
        homeCollectionView.register(UINib(nibName: ProductCell.reuseIdentifer, bundle: nil), forCellWithReuseIdentifier: ProductCell.reuseIdentifer)
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
//MARK: - create CompositionalLayout to handel all diminsions for UICollectionView
extension HomeVC {
    
    enum Section:Int {
        case banners=0, category, products
    }
    private func createCompositionalLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { sectionNumber, env -> NSCollectionLayoutSection? in
            switch Section(rawValue: sectionNumber) {
            case .banners:
                return self.bannersSection()
            case .category:
                return self.categoriesSection()
            case .products:
                return self.productsSection()
            default:
                return nil
            }
        }
    }
    
    private func bannersSection() -> NSCollectionLayoutSection {
        // Item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        //item.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        // Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1/3))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 2.5, bottom: 0, trailing: 2.5)
        section.orthogonalScrollingBehavior = .paging
        
        return section
    }
    private func categoriesSection() -> NSCollectionLayoutSection {
        
        let inset: CGFloat = 2.5
        
        // Items
        let largeItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
        let largeItem = NSCollectionLayoutItem(layoutSize: largeItemSize)
        largeItem.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        
        let smallItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5))
        let smallItem = NSCollectionLayoutItem(layoutSize: smallItemSize)
        smallItem.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        
        // Nested Group
        let nestedGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalHeight(1))
        let nestedGroup = NSCollectionLayoutGroup.vertical(layoutSize: nestedGroupSize, subitems: [smallItem])
        
        // Outer Group
        let outerGroupSize = NSCollectionLayoutSize(widthDimension: .estimated(400), heightDimension: .fractionalWidth(0.5))
        let outerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: outerGroupSize, subitems: [largeItem, nestedGroup, nestedGroup,nestedGroup])
        
        // Section
        let section = NSCollectionLayoutSection(group: outerGroup)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        
        return section
    }
    
    private func productsSection() -> NSCollectionLayoutSection {
        // Item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        // Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(400))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 2.5, bottom: 0, trailing: 2.5)
        //section.orthogonalScrollingBehavior = .paging
        
        return section
    }
}
extension HomeVC:UICollectionViewDelegate,UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 1 {
        return 7
        }
        else
        {
            return 16
        }
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        if indexPath.section == 0
        {
            let cell = homeCollectionView.dequeueReusableCell(withReuseIdentifier: BannerCell.reuseIdentifer, for: indexPath) as! BannerCell
            // cell.backgroundColor = .red
            return cell
        }
        else if indexPath.section == 1
        {
            let cell = homeCollectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.reuseIdentifer, for: indexPath) as! CategoryCell
            //             let cell = homeCollectionView.dequeueReusableCell(withReuseIdentifier: HomeVC.cellIdentifer, for: indexPath)
            cell.backgroundColor = .green
            return cell
        }
        else{
            
            let cell = homeCollectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.reuseIdentifer, for: indexPath) as! ProductCell
             //             let cell = homeCollectionView.dequeueReusableCell(withReuseIdentifier: HomeVC.cellIdentifer, for: indexPath)
            // cell.backgroundColor = .green
             return cell
        }
        
    }
}
