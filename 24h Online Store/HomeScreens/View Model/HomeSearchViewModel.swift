//
//  HomeSearchViewModel.swift
//  24h Online Store
//
//  Created by macboock pro on 10/17/20.
//  Copyright © 2020 macboock pro. All rights reserved.
//

import Foundation
import RxRelay
import RxSwift

struct HomeSearchViewModel {
    
    var items=BehaviorSubject<[Product]>(value: [Product]())
}
