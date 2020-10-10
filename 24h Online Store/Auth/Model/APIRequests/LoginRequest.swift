//
//  LoginRequest.swift
//  24h Online Store
//
//  Created by macboock pro on 10/3/20.
//  Copyright © 2020 macboock pro. All rights reserved.
//

import Foundation

struct LoginRequest: Codable {
    
    let email: String
    let password: String
}
