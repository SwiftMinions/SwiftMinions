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
    
    /**
     Switch window's rootViewController.

     ## Chinese description
     切換 window 的 rootViewController，可用在登入或登出。

     ## Use example
     ```swift
        let loginVC = LoginViewController()
        UIWindow.switch(toViewController: loginVC)
     ```
    */
    static func `switch`(
        toViewController viewController: UIViewController,
        animated: Bool = true,
        duration: TimeInterval = 0.35,
        options: UIView.AnimationOptions = .transitionCrossDissolve,
        _ completion: (() -> Void)? = nil
    )
    {
        guard let window = MinionsConfig.keyWindow else {
            return
        }
        
        UIView.transition(with: window, duration: duration, options: options, animations: {
            let oldState = UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            window.rootViewController = viewController
            UIView.setAnimationsEnabled(oldState)
        }, completion: { _ in
            completion?()
        })
    }
}
