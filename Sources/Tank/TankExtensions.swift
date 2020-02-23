//
//  TankExtensions.swift
//  SwiftMinions
//
//  Created by 郭景豪 on 2020/2/23.
//  Copyright © 2020 SwiftMinions. All rights reserved.
//

import UIKit




//URL
extension URL: ExpressibleByStringLiteral {
    /*
     Creates a url instance initialized to the given string value.
     ### Usage Example: ###
     ````
     let url: URL = "https://apple.com"
     ````
    */
    public init(stringLiteral value: StaticString) {
        guard let url = URL(string: "\(value)") else {
            fatalError("Invalid URL string literal: \(value)")
        }
        self = url
    }
}
