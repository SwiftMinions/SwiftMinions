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
     Get windows toppest view controller. (window default is `SMConfig.keyWindow`)

     ### Chinese description
     取得 window 最上層的 view controller。(window 的預設值是 `SMConfig.keyWindow`)

     ### Use example
     ```swift
      let topVC = UIWindow.toppestViewController()
     ```
    */
    static func toppestViewController(
        base: UIViewController? = SMConfig.keyWindow?.rootViewController
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

     ### Chinese description
     切換 window 的 rootViewController，可用在登入或登出。

     ### Use example
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
        guard let window = SMConfig.keyWindow else {
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
    
    /// Convert given view origin (x, y) to key window coordinate
    ///
    /// - Parameter sender: the view need to be convert
    /// - Returns: the view in window's coordinate
    func toKeyWindowsCoordinate(sender: UIView) -> CGPoint? {
        var point: CGPoint?
        guard let window = SMConfig.keyWindow else { return point }
        guard let superView = sender.superview else { return point }
        point = superView.convert(sender.frame.origin, to: window)
        return point
    }
    
    /// The Frame of status bar
    static var statusBarFrame: CGRect {
        if #available(iOS 13.0, *) {
            return SMConfig.keyWindow?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect()
        } else {
            return UIApplication.shared.statusBarFrame
        }
    }
}
