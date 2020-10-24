//
//  ProductDetailsVC.swift
//  24h Online Store
//
//  Created by macboock pro on 10/18/20.
//  Copyright © 2020 macboock pro. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
class ProductDetailsVC: UIViewController {
    
    //MARK: - IBOutlet
    @IBOutlet weak var productTableView: UITableView!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var cartButton: UIButton!
    @IBOutlet weak var favioriteButton: UIButton!
    @IBOutlet weak var bottomView: UIView!
    //MARK: - Properties
    var productDetailsViewModel = ProductDetailsViewModel()
    let disposeBag = DisposeBag()
    //MARK: - lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        productTableView.dataSource = self
        setupUI()
        registerAllCells()
        subscribeToButtons()
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "Details"
        // print(productDetailsViewModel.product)
    }
    //MARK: - Methods
    func setupUI()  {
        bottomView.layer.cornerRadius = bottomView.frame.size.height/2
        bottomView.layer.masksToBounds = true
        
        productDetailsViewModel.product.inFavorites ? favioriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal):favioriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        productDetailsViewModel.product.inCart ? cartButton.setImage(UIImage(systemName: "cart.fill"), for: .normal):cartButton.setImage(UIImage(systemName: "cart"), for: .normal)
        
    }
    func registerAllCells() {
        productTableView.register(UINib(nibName: ProductImageSliderCell.reuseIdentfire, bundle: nil), forCellReuseIdentifier: ProductImageSliderCell.reuseIdentfire)
        
        productTableView.register(UINib(nibName: ProductDetailsCell.reuseIdentfire, bundle: nil), forCellReuseIdentifier: ProductDetailsCell.reuseIdentfire)
        productTableView.register(UINib(nibName: ProductDescription.reuseIdentfire, bundle: nil), forCellReuseIdentifier: ProductDescription.reuseIdentfire)
    }
    func subscribeToButtons() {
        favioriteButton.rx.tap
            .subscribe(onNext: { [weak self](_) in
                guard let self = self else { return }
                
                self.productDetailsViewModel.product.inFavorites.toggle()
                self.productDetailsViewModel.product.inFavorites ? self.favioriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal):self.favioriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
                
            }).disposed(by: disposeBag)
        cartButton.rx.tap
            .subscribe(onNext: { [weak self](_) in
                guard let self = self else { return }
                self.productDetailsViewModel.product.inCart.toggle()
                self.productDetailsViewModel.product.inCart ? self.cartButton.setImage(UIImage(systemName: "cart.fill"), for: .normal):self.cartButton.setImage(UIImage(systemName: "cart"), for: .normal)
                self.changeBadgetOfCart(add: self.productDetailsViewModel.product.inCart)
            }).disposed(by: disposeBag)
    }
    func changeBadgetOfCart(add:Bool) {
        if let tabItems = tabBarController?.tabBar.items {
            let tabItem = tabItems[2]
            let badgetValue = Int(tabItem.badgeValue ?? "0") ?? 0
            if badgetValue == 0 && !add{return}
            tabItem.badgeValue = add ? "\(badgetValue+1)":"\(badgetValue-1)"
        }
    }
    
}
//MARK: - UITableViewDataSource
extension ProductDetailsVC:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0
        {
            let cell = productTableView.dequeueReusableCell(withIdentifier: ProductImageSliderCell.reuseIdentfire, for: indexPath) as! ProductImageSliderCell
            cell.images = productDetailsViewModel.product.images
            return cell
        }
        else if indexPath.row == 1{
            let cell = productTableView.dequeueReusableCell(withIdentifier: ProductDetailsCell.reuseIdentfire, for: indexPath) as! ProductDetailsCell
            cell.productName.text = productDetailsViewModel.product.name
            cell.productOldPrice.attributedText = ("\(productDetailsViewModel.product.oldPrice)" + " EGP").strikeThrough()
            cell.productPrice.text =  "\(productDetailsViewModel.product.price)" + " EGP"
            cell.productDiscount.text =  "-\(productDetailsViewModel.product.discount ?? 0)" + "%"
            return cell
        }
        else{
            let cell = productTableView.dequeueReusableCell(withIdentifier: ProductDescription.reuseIdentfire, for: indexPath) as! ProductDescription
            cell.productDescription.text = productDetailsViewModel.product.productDescription
            return cell
        }
    }
    
    
}
