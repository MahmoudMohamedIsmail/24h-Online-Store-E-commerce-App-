//
//  SignUpSuccessModel.swift
//  24h Online Store
//
//  Created by macboock pro on 10/4/20.
//  Copyright © 2020 macboock pro. All rights reserved.
//

import Foundation

// MARK: - SignUpSuccessModel
struct SignUpSuccessModel: Codable {
    let status: Bool
    let message: String
    let data: SignUpData?
}

// MARK: - SignUpData
struct SignUpData: Codable {
    let name, phone, email: String
    let id: Int
    let image: String
    let token: String
}
