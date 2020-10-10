//
//  SignUpRequest.swift
//  24h Online Store
//
//  Created by macboock pro on 10/4/20.
//  Copyright © 2020 macboock pro. All rights reserved.
//

import Foundation
struct SignUpRequest: Codable {
    let name:String
    let phone:String
    let email:String
    let password:String
    let image:String
}
