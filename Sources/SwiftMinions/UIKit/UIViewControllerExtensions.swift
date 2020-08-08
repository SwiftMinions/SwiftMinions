//
//  UIViewControllerExtensions.swift
//  SwiftMinions
//
//  Created by Ohlulu on 2020/5/27.
//  Copyright © 2020 SwiftMinions. All rights reserved.
//

import UIKit

public extension UIViewController {
    
    /**
     Short namespacong with `dismiss(animated:, _:)`.
     Animated default is true. complection default is nil.
     */
    @objc func dismiss(_ animated: Bool = true, _ completion: (() -> Void)? = nil) {
        dismiss(animated: animated, completion: completion)
    }
    
    /**
    Short namespacong with `present(_:, animated:, _:)`.
    Animated default is true. complection default is nil.
    */
    @objc func present(_ vc: UIViewController, animated: Bool = true, _ completion: (() -> Void)? = nil) {
        present(vc, animated: animated, completion: completion)
    }
    
    /**
     Helper method to add a UIViewController as a childViewController.

     ### Chinese description
     方便的增加一個 UIViewController 作為 childViewController。

     ### Use example
     ```swift
        class SomeViewController: UIViewController {
     
            let childVC = UIViewController()
            let containerView = UIView()
     
            func viewDidLoad() {
                super.viewDidLoad()
                addChildViewController(childVC, toContainerView containerView)
            }
        }
     ```
     - Parameters:
       - child: the view controller to add as a child
       - containerView: the containerView for the child viewcontroller's root view.
    */
    func addChildViewController(_ child: UIViewController, toContainerView containerView: UIView) {
        addChild(child)
        containerView.bounds = child.view.bounds
        containerView.addSubview(child.view)
        child.didMove(toParent: self)
    }

    /**
     Helper method to remove a UIViewController from its parent.

     ### Chinese description
     方便的移除 childViewController。

     ### Use example
     ```swift
        removeChildViewController(childVC)
     ```
     - Parameters:
       - child: the child view controller
    */
    func removeChildViewController(_ child: UIViewController) {
        guard parent != nil else { return }
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }
}
