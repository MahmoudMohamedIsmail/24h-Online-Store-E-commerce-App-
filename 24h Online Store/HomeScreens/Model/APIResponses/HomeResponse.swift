//
//  HomeResponse.swift
//  24h Online Store
//
//  Created by macboock pro on 10/15/20.
//  Copyright © 2020 macboock pro. All rights reserved.
//

import Foundation

// MARK: - HomeRespones
struct HomeRespones: Codable {
    let status: Bool
    let message: String?
    let data: HomeData?
}

// MARK: - DataClass
struct HomeData: Codable {
    let banners: [Banner]
    let products: [Product]
    let ad: String
}

// MARK: - Banner
struct Banner: Codable {
    let id: Int
    let image: String
    let category, product: String?
}

// MARK: - Product
struct Product: Codable {
    let id: Int
    let price: Double
    let oldPrice: Int
    let discount: Int?
    let image: String
    let name, productDescription: String
    let images: [String]
    var inFavorites, inCart: Bool

    enum CodingKeys: String, CodingKey {
        case id, price
        case oldPrice = "old_price"
        case discount, image, name
        case productDescription = "description"
        case images
        case inFavorites = "in_favorites"
        case inCart = "in_cart"
    }
}
