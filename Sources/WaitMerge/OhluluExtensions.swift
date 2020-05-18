//
//  OhluluExtensions.swift
//  SwiftMinions
//
//  Created by HIS HSIANG JIH on 2020/2/23.
//  Copyright © 2020 SwiftMinions. All rights reserved.
//

import UIKit

public extension UIStackView {
    
    func addArrangedSubviews(_ views: [UIView]) {
        for view in views {
            addArrangedSubview(view)
        }
    }
    
    func forceRemoveAllArrangedSubviews() {
        for view in arrangedSubviews {
            removeArrangedSubview(view)
            view.removeFromSuperview()
        }
    }
    
    func forceRemoveArrangedSubviews(_ views: [UIView]) {
        for view in views {
            if !subviews.contains(view) {
                continue
            }
            removeArrangedSubview(view)
            view.removeFromSuperview()
        }
    }
}

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
    enum AnimationType {
        case fadeOut
        case fadeIn
    }

    /// Animation type
    /// - Parameter type: set this value with AnimationType
    /// - Parameter duration: set this value to duration (default is 0.25)
    /// - Parameter delay: set this value to delay (default is 0)
    /// - Parameter completion:  optional completion handler (default is nil).
    func animation(
        type: AnimationType,
        duration: TimeInterval = 0.25,
        delay: TimeInterval = 0,
        _ completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: duration, delay: delay, animations: {
            self.alpha = type == .fadeOut ? 0 : 1
        }, completion: completion)
    }

    /// Animated with a horizontal shake, duration -> 0.35s
    /// - duration -> 0.35s
    /// - offsets -> [-10.0, 10.0, -10.0, 10.0, -5.0, 5.0, 0.0]
    func errorshake(completion:(() -> Void)? = nil) {
        shake(duration: 0.35,
              offsets: [-10.0, 10.0, -10.0, 10.0, -5.0, 5.0, 0.0],
              completion: completion)
    }
    
    func shake(duration: CFTimeInterval,
               offsets: [CGFloat],
               completion:(() -> Void)? = nil) {
        constraints.forEach { $0.isActive = false }
        translatesAutoresizingMaskIntoConstraints = true
        CATransaction.begin()
        let animation: CAKeyframeAnimation
        
        animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        
        CATransaction.setCompletionBlock(completion)
        animation.duration = duration
        animation.values = offsets
        layer.add(animation, forKey: "shake")
        CATransaction.commit()
    }
}
