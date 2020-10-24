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
    //MARK: - IBOutlet
    @IBOutlet weak var homeCollectionView: UICollectionView!
    //MARK: - Properties
    var homeSearchTVC :HomeSearchTVC{
        guard let  searchVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(identifier: "HomeSearch") as? HomeSearchTVC else {return HomeSearchTVC()}
        homeViewModel.search().bind(to: searchVC.searchViewModel.items).disposed(by: disposeBag)
        searchVC.product.subscribe(onNext: { (item) in
            self.presentProductDetailsVC(productItem:item)
        }).disposed(by: disposeBag)
        return searchVC
    }
    var searchController = UISearchController(searchResultsController: nil)
    let homeViewModel = HomeViewModel()
    let disposeBag = DisposeBag()
    //MARK: - lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        homeCollectionView.collectionViewLayout = createCompositionalLayout()
        UICollectionView.tabBar = tabBarController?.tabBar ?? UITabBar()
        
        registerAllCells()
        setupUI()
        bindHomeSearchBar()
        bindHomeCollectionView()
        subscribeToLoading()
        homeViewModel.getHomeData()
        subscribeToDidSelectedCells()
        subscribeToCartBadgetVaule()
    }
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.selectedItem?.selectedImage = UIImage(systemName: "house.fill")
        //homeViewModel.getHomeData()
        self.navigationItem.title = "Online Store"
        
    }
    //MARK: - Methods
    func registerAllCells() {
        homeCollectionView.register(UINib(nibName: HeaderCollectionReusableView.reuseIdentifer, bundle: nil), forSupplementaryViewOfKind: "header", withReuseIdentifier: HeaderCollectionReusableView.reuseIdentifer)
        
        homeCollectionView.register(UINib(nibName: BannerCell.reuseIdentifer, bundle: nil), forCellWithReuseIdentifier: BannerCell.reuseIdentifer)
        homeCollectionView.register(UINib(nibName: CategoryCell.reuseIdentifer, bundle: nil), forCellWithReuseIdentifier: CategoryCell.reuseIdentifer)
        homeCollectionView.register(UINib(nibName: ProductCell.reuseIdentifer, bundle: nil), forCellWithReuseIdentifier: ProductCell.reuseIdentifer)
    }
    func setupUI(){
        searchController = UISearchController(searchResultsController: homeSearchTVC)
        searchController.showsSearchResultsController = true
        searchController.searchBar.searchTextField.backgroundColor = .white
        searchController.searchBar.searchTextField.tintColor = UIColor(named: "mainColor")
        searchController.searchBar.tintColor = .white
        definesPresentationContext = true
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        // Add top line view in tabBar
        let tabBar = self.tabBarController!.tabBar
        tabBar.selectionIndicatorImage = UIImage.createSelectionIndicator(size: CGSize(width: tabBar.frame.width/CGFloat(tabBar.items!.count), height:  tabBar.frame.height))
        
        
    }
    
    func bindHomeCollectionView(){
        homeViewModel.items.bind(to: homeCollectionView.rx.items(dataSource: homeViewModel.dataSource)).disposed(by: disposeBag)
    }
    func bindHomeSearchBar(){
        navigationItem.searchController?.searchBar.rx.text.orEmpty.distinctUntilChanged().bind(to: homeViewModel.query).disposed(by: disposeBag)
    }
    func subscribeToDidSelectedCells(){
        homeCollectionView.rx.itemSelected.subscribe(onNext: { (indexPath) in
            let product = try! self.homeViewModel.productsData.value()[indexPath.row]
            self.presentProductDetailsVC(productItem: product)
        }).disposed(by: disposeBag)
    }
    func subscribeToLoading() {
        homeViewModel.indecatorLoading.subscribe(onNext: { (isLoading) in
            if isLoading {
                DispatchQueue.main.async {
                    self.homeCollectionView.isHidden = true
                    self.view.showAnimatingLoader()
                }
            } else {
                DispatchQueue.main.async {
                    self.view.hideAnimatingLoader()
                    self.homeCollectionView.isHidden = false
                }
            }
        }).disposed(by: disposeBag)
    }
    func presentProductDetailsVC(productItem:Product) {
        let productDetailsVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(identifier: "ProductDetails") as? ProductDetailsVC
        //assign product to productDeatailsViewModel
        productDetailsVC?.productDetailsViewModel.product = productItem
        self.navigationItem.title = ""
        self.navigationController?.pushViewController(productDetailsVC!, animated: true)
    }
    func subscribeToCartBadgetVaule(){
        homeViewModel.productsData.map {  items in
            return items.filter { $0.inCart
            }
        }.subscribe { (products) in

            guard let badge =  products.element?.count else {return}
            DispatchQueue.main.async {
                self.tabBarController?.tabBar.items?[2].badgeValue = (badge > 0) ? "\(badge)":nil
            }
        }.disposed(by: disposeBag)
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
        item.contentInsets = .init(top: 0, leading: 0, bottom: 15, trailing: 10)
        
        // Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(290))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 0, trailing: 0)
        //section.orthogonalScrollingBehavior = .paging
        
        // Supplementary Item
        let headerItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(40))
        let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerItemSize, elementKind: "header", alignment: .top)
        section.boundarySupplementaryItems = [headerItem]
        
        return section
    }
}

