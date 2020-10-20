//
//  HomeDataSource.swift
//  24h Online Store
//
//  Created by macboock pro on 10/17/20.
//  Copyright © 2020 macboock pro. All rights reserved.
//

import RxDataSources

struct HomeDataSource {
    
    static func dataSource() -> RxCollectionViewSectionedReloadDataSource<MultipleSectionModel> {
        
        return RxCollectionViewSectionedReloadDataSource<MultipleSectionModel>.init(configureCell: { (dataSource, homeCollectionView, indexPath, item) -> UICollectionViewCell in
            
            switch dataSource[indexPath] {
                
            case let .BannerSectionItem(banner: banner):
                let cell = homeCollectionView.dequeueReusableCell(withReuseIdentifier: BannerCell.reuseIdentifer, for: indexPath) as! BannerCell
                cell.bannerImage.downloaded(from: banner.image)
                cell.layoutIfNeeded()
                return cell
            case .CategorySectionItem(name: _, image: _):
                let cell = homeCollectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.reuseIdentifer, for: indexPath) as! CategoryCell
                return cell
            case let .ProductSectionItem(product: product):
                let cell = homeCollectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.reuseIdentifer, for: indexPath) as! ProductCell
                cell.image.downloaded(from: product.image)
                cell.name.text = product.name
                cell.price.text = "\(product.price)"+" EGP"
                cell.layoutIfNeeded()
                return cell
            }
        }, configureSupplementaryView: { (dataSource, homeCollectionView, _, indexPath) -> UICollectionReusableView in
            
            switch dataSource[indexPath] {
            case .ProductSectionItem(product: _):
                guard let headerView = homeCollectionView.dequeueReusableSupplementaryView(ofKind: "header", withReuseIdentifier: HeaderCollectionReusableView.reuseIdentifer, for: indexPath) as? HeaderCollectionReusableView else {
                    return HeaderCollectionReusableView()
                }
                return headerView
                
            case .BannerSectionItem(banner: _):
                return UICollectionReusableView()
            case .CategorySectionItem(name: _):
                return UICollectionReusableView()
            }
        })
    }
    
}
enum MultipleSectionModel {
    case BannersSection(title: String, items: [SectionItem])
    case CategoriesSection(title: String, items: [SectionItem])
    case ProductsSection(title: String, items: [SectionItem])
}

enum SectionItem {
    case BannerSectionItem(banner: Banner)
    case CategorySectionItem(name: String, image: String)
    case ProductSectionItem(product:Product)
}

extension MultipleSectionModel: SectionModelType {
    typealias Item = SectionItem
    
    var items: [SectionItem] {
        switch  self {
        case .BannersSection(title: _, items: let items):
            return items.map { $0 }
        case .CategoriesSection(title: _, items: let items):
            return items.map { $0 }
        case .ProductsSection(title: _, items: let items):
            return items.map { $0 }
        }
    }
    
    init(original: MultipleSectionModel, items: [Item]) {
        switch original {
        case let .BannersSection(title: title, items: _):
            self = .BannersSection(title: title, items: items)
        case let .CategoriesSection(title, _):
            self = .CategoriesSection(title: title, items: items)
        case let .ProductsSection(title, _):
            self = .ProductsSection(title: title, items: items)
        }
    }
}

extension MultipleSectionModel {
    var title: String {
        switch self {
        case .BannersSection(title: let title, items: _):
            return title
        case .CategoriesSection(title: let title, items: _):
            return title
        case .ProductsSection(title: let title, items: _):
            return title
        }
    }
}
