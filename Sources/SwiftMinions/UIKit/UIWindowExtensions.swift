//
//  UIWindowExtensions.swift
//  SwiftMinions
//
//  Created by Ohlulu on 2020/4/23.
//  Copyright © 2020 SwiftMinions. All rights reserved.
//

import UIKit

public extension UIWindow {
    
    /**
     Get windows toppest view controller. (window default is `MinionsConfig.keyWindow`)

     ## Chinese description
     取得 window 最上層的 view controller。(window 的預設值是 `MinionsConfig.keyWindow`)

     ## Use example
     ```swift
      let topVC = UIWindow.toppestViewController()
     ```
    */

    func toppestViewController(
        base: UIViewController? = MinionsConfig.keyWindow?.rootViewController
    )
        -> UIViewController?
    {
        
        if let nav = base as? UINavigationController {
            return toppestViewController(base: nav.visibleViewController)
        }
        
        if let tab = base as? UITabBarController {
            let moreNavigationController = tab.moreNavigationController
            
            if let top = moreNavigationController.topViewController, top.view.window != nil {
                return toppestViewController(base: top)
            } else if let selected = tab.selectedViewController {
                return toppestViewController(base: selected)
            }
        }
        
        if let presented = base?.presentedViewController {
            return toppestViewController(base: presented)
        }
        return base
    }
    
}
