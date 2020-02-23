//
//  TankExtensions.swift
//  SwiftMinions
//
//  Created by 郭景豪 on 2020/2/23.
//  Copyright © 2020 SwiftMinions. All rights reserved.
//

import UIKit

extension URL: ExpressibleByStringLiteral {
    /**
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


extension UILabel {
    /**
     計算Label高度.
     ### Usage Example: ###
     ````
     let height: CGFloat = UILabel().heightForLabel(text: "123", font: UIFont.systemFont(ofSize: 100), width: 100)
     print(height)
     ````
    */
    func calculateHeight(text:String, font:UIFont, width:CGFloat) -> CGFloat {
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        
        label.sizeToFit()
        return label.frame.height
    }
    
}
