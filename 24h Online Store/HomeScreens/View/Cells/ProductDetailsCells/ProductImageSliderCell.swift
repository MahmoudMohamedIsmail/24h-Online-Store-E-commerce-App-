//
//  ProductImageSliderCell.swift
//  24h Online Store
//
//  Created by macboock pro on 10/19/20.
//  Copyright © 2020 macboock pro. All rights reserved.
//

import UIKit

class ProductImageSliderCell: UITableViewCell {

    //MARK: - IBOutlet
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var imagesSliderCollectionView: UICollectionView!
    //MARK: - Properties
    static let reuseIdentfire = "ProductImageSliderCell"
    var images:[String]!
    //MARK: - lifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        imagesSliderCollectionView.dataSource = self
        imagesSliderCollectionView.delegate = self
        registerAllCells()
    }
    //MARK: - Methods
    func registerAllCells() {
        imagesSliderCollectionView.register(UINib(nibName: ProductImageCVCell.reuseIdentfire, bundle: nil), forCellWithReuseIdentifier: ProductImageCVCell.reuseIdentfire)
    }
}
//MARK: -UICollectionViewDelegate
extension ProductImageSliderCell:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         pageControl.numberOfPages = images.count
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imagesSliderCollectionView.dequeueReusableCell(withReuseIdentifier: ProductImageCVCell.reuseIdentfire, for: indexPath) as! ProductImageCVCell
        cell.productImage.downloaded(from: images[indexPath.row])
        cell.layoutIfNeeded() 
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: imagesSliderCollectionView.frame.width, height: imagesSliderCollectionView.frame.height)
    }
  
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x/imagesSliderCollectionView.frame.size.width)
    }
}
