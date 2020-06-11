//
//  UIScreenExtensions.swift
//  SwiftMinions
//
//  Created by stephen on 2020/3/22.
//  Copyright © 2020 SwiftMinions. All rights reserved.
//

import UIKit

public extension UIScreen {
    
    /**
     Get safe area inset length.
     
     ### Chinese description
     取得當前螢幕，瀏海內縮的距離。
    
     ### Use example
     ```swift
        // iPhone X
        UIWindow.safeAreaInset.top -> 32
        UIWindow.safeAreaInset.bottom -> 34
        UIWindow.safeAreaInset.left -> 0
        UIWindow.safeAreaInset.right -> 0
     ```
     Returns: UIEdgeInsets
     */
    static var safeAreaInset: UIEdgeInsets {
        guard let window = SMConfig.keyWindow else {
            return .init(top: 0, left: 0, bottom: 0, right: 0)
        }
        if #available(iOS 11.0, *) {
            return window.safeAreaInsets
        } else {
            return .init(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    
    /**
     Get Screen height with short namespacing.
     
     ### Chinese description
     使用較短的命名空間，取得螢幕的高。
     */
    static var height: CGFloat {
        main.bounds.height
    }
    
    /**
     Get Screen width with short namespacing.
     
     ### Chinese description
     使用較短的命名空間，取得螢幕的寬。
    */
    static var width: CGFloat {
        main.bounds.width
    }
}
