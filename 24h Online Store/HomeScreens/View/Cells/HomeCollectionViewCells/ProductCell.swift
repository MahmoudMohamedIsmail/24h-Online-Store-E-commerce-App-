//
//  ProductCell.swift
//  24h Online Store
//
//  Created by macboock pro on 10/10/20.
//  Copyright © 2020 macboock pro. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
class ProductCell: UICollectionViewCell {
    //MARK: - IBOutlet
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var cartButton: UIButton!
    //MARK: - Properties
     static let reuseIdentifer = "ProductCell"
    let disposeBag = DisposeBag()
    var tabBar:UITabBar!
    var favorite = false
    var cart = false
    //MARK: - lifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        borderView.makeRoundedBorder()
        subscribeToButtons()
    }
    //MARK: - Methods
    func subscribeToButtons() {
        favoriteButton.rx.tap
            .subscribe(onNext: {
                self.favorite.toggle()
                self.favorite ? self.favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal):self.favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
            }).disposed(by: disposeBag)
        cartButton.rx.tap
            .subscribe(onNext: {
                self.cart.toggle()
                self.cart ? self.cartButton.setImage(UIImage(systemName: "cart.fill"), for: .normal):self.cartButton.setImage(UIImage(systemName: "cart"), for: .normal)
                self.changeBadgetOfCart(add:  self.cart)
            }).disposed(by: disposeBag)
    }
    func changeBadgetOfCart(add:Bool) {
        if let tabItems = UICollectionView.tabBar.items {
            let tabItem = tabItems[2]
            let badgetValue = Int(tabItem.badgeValue ?? "0") ?? 0
            if badgetValue == 0 && !add{return}
            tabItem.badgeValue = add ? "\(badgetValue+1)":"\(badgetValue-1)"
        }
    }
}
