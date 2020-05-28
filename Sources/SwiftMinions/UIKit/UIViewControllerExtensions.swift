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
}
