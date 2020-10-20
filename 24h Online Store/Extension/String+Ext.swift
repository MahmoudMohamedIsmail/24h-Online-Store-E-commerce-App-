//
//  String+Ext.swift
//  24h Online Store
//
//  Created by macboock pro on 10/19/20.
//  Copyright © 2020 macboock pro. All rights reserved.
//

import Foundation
extension String {
    func strikeThrough() -> NSAttributedString {
        let attributeString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(
            NSAttributedString.Key.strikethroughStyle,
               value: 2,
                   range:NSMakeRange(0,attributeString.length))
        return attributeString
    }
}
