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
     Get Screen height with short namespacing.
     
     ## Chinese description
     使用較短的命名空間，取得螢幕的高。
     */
    static var height: CGFloat {
        main.bounds.height
    }
    
    /**
     Get Screen width with short namespacing.
     
     ## Chinese description
     使用較短的命名空間，取得螢幕的寬。
    */
    static var width: CGFloat {
        main.bounds.width
    }
}
