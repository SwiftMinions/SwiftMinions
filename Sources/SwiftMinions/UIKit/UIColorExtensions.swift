//
//  UIColorExtensions.swift
//  SwiftMinions
//
//  Created by Ohlulu on 2020/5/27.
//  Copyright © 2020 SwiftMinions. All rights reserved.
//

import UIKit

public extension UIColor {
    
    /**
     From RGB(0~255) and alpha(0~1) to initialize UIColor

     ### Chinese description
     通過 RGB (0〜255) 和 alpha(0〜1) 初始化 UIColor 。

     ### Use example
     ```swift
        UIColor.rgba(red: 255, green: 255, blue: 255, alpha: CGFloat = 1)
        // equal to
        UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1)
     ```
    */
    static func rgba(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1)
        -> UIColor
    {
        return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
    }
    
    /**
     From hex string to initialize UIColor. It support alpha like android.
     Note: alpha from hex will not work, if parameter alpha is not nil.

     ### Chinese description
     從十六進制字串初始化UIColor。它支援透明度通道，就像 Android一樣。
     注意：如果參數 alpha 不為 nil，則十六進制的 alpha 將不起作用。

     ### Use example
     ```swift
        let blackColor = UIColor.hex("#000000")
        
        // or remove '#'
        let whiteColor = UIColor.hex("FFFFFF")
     
        // with alpha
        let black60 = UIColor.hex("99FFFFFF")
     ```
    */
    static func hex(string: String, alpha: CGFloat? = nil) -> UIColor {
        
        var hexString = string
        
        if hexString.hasPrefix("#") {
            hexString.removeFirst()
        }
        
        var color: UInt64 = 0
        
        Scanner(string: hexString).scanHexInt64(&color)
        if hexString.count == 6 {
            return UIColor(
                red: CGFloat((color & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((color & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(color & 0x0000FF) / 255.0,
                alpha: alpha ?? 1)
        } else {
            return UIColor(
                red: CGFloat((color & 0x00FF0000) >> 16) / 255.0,
                green: CGFloat((color & 0x0000FF00) >> 8) / 255.0,
                blue: CGFloat(color & 0x000000FF) / 255.0,
                alpha: alpha ?? CGFloat((color & 0xFF000000) >> 24) / 255.0)
        }
    }
    
    /**
     Short namespacing with `withAlphaComponent(_:)`.

     ### Chinese description
     withAlphaComponent(_:) 的簡短命。
    */
    @discardableResult
    func alpha(_ alpha: CGFloat) -> UIColor {
        withAlphaComponent(alpha)
    }
}
