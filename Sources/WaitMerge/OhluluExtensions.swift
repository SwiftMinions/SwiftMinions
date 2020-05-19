//
//  OhluluExtensions.swift
//  SwiftMinions
//
//  Created by HIS HSIANG JIH on 2020/2/23.
//  Copyright © 2020 SwiftMinions. All rights reserved.
//

import UIKit

public extension UIViewController {
    
    @objc func dismiss(_ animated: Bool = true, _ completion: (() -> Void)? = nil) {
        dismiss(animated: animated, completion: completion)
    }
    
    @objc func present(_ vc: UIViewController, animated: Bool = true, _ completion: (() -> Void)? = nil) {
        present(vc, animated: animated, completion: completion)
    }
}

public extension UIViewController {
    
    var isPresent: Bool {
        if let navigationController = navigationController {
            if navigationController.viewControllers.first == self {
                return true
            }
        }
        return false
    }
}

public extension UIViewController {
    func addChild(viewController child: UIViewController, containerView: UIView) {
        addChild(child)
        containerView.bounds = child.view.bounds
        containerView.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func removeChild(viewController child: UIViewController) {
        guard parent != nil else { return }
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }
}

public extension UIView {
    
}
