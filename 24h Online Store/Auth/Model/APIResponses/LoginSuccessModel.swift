//
//  LoginSuccessModel.swift
//  24h Online Store
//
//  Created by macboock pro on 10/3/20.
//  Copyright © 2020 macboock pro. All rights reserved.
//

import Foundation
// MARK: - LoginSuccessModel
struct LoginSuccessModel: Codable {
    let status: Bool
    let message: String
    let data: LoginData?
}

// MARK: - LoginData
struct LoginData: Codable {
    let id: Int
    let name, email, phone: String
    let image: String
    let points, credit: Int
    let token: String
}
