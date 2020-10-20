//
//  HomeViewModel.swift
//  24h Online Store
//
//  Created by macboock pro on 10/15/20.
//  Copyright © 2020 macboock pro. All rights reserved.
//

import Foundation
import RxRelay
import RxSwift
class HomeViewModel {
//MARK: - Properties
    var productsData=BehaviorSubject<[Product]>(value: [Product]())
     var query=BehaviorRelay<String>(value: "")
    let dataSource = HomeDataSource.dataSource()
    var items=PublishSubject<[MultipleSectionModel]>()
    var indecatorLoading = BehaviorRelay<Bool>(value: false)
    //MARK: - Methods
    func getHomeData() {
        indecatorLoading.accept(true)
        APIManager.taskForGETRequest(url: APIManager.Endpoints.home.url, responseType: HomeRespones.self) { (homeResponse, error) in
            self.indecatorLoading.accept(false)
            guard let homeRespones = homeResponse else {
                print(error!)
                return
            }
           // self.homeRespones.onNext(homeRespones)
            
            guard let data = homeRespones.data else {
                print("no products")
                return
            }
            self.productsData.onNext(data.products)
            
            let banners:[SectionItem] = data.banners.map { (banner) -> SectionItem in
                return SectionItem.BannerSectionItem(banner: banner)
            }
            let products:[SectionItem] = data.products.map { (product) -> SectionItem in
                return SectionItem.ProductSectionItem(product: product)
            }
            let categories:[SectionItem] = [.CategorySectionItem(name: "", image: ""),
                                            .CategorySectionItem(name: "", image: ""),
                                            .CategorySectionItem(name: "", image: ""),
                                            .CategorySectionItem(name: "", image: ""),
                                            .CategorySectionItem(name: "", image: ""),
                                            .CategorySectionItem(name: "", image: ""),
                                            .CategorySectionItem(name: "", image: "")]
            
            let sections:[MultipleSectionModel] = [
                 .BannersSection(title: "", items: banners),
                .CategoriesSection(title: "", items: categories),
                .ProductsSection(title: "", items: products)
            ]
            self.items.onNext(sections)
            
        }
    }
    func search() -> Observable<[Product]> {
          return Observable.combineLatest(productsData.asObservable(), query.asObservable()).map { (items,query) in
              return items.filter { $0.name.hasPrefix(query) }
          }
          
      }
}
