//
//  UINavigationControllerExtensions.swift
//  SwiftMinions
//
//  Created by Ohlulu on 2020/3/24.
//  Copyright © 2020 SwiftMinions. All rights reserved.
//

import UIKit

public extension UINavigationController {
    
    /**
     push view controller with completion handler.
     
     ### Chinese description ###
     為 pushViewController 加上 call back.
     
     ## Use example ##
     ```swift
     let vc = UIViewController()
     pushViewController(vc) {
        print("did pushViewController")
     }
     ```
     cf. https://stackoverflow.com/questions/9906966/completion-handler-for-uinavigationcontroller-pushviewcontrolleranimated/33767837#33767837
     
     - Parameters:
         - viewController: target view controller
         - animated: animated with pushViewController. (default: true)
         - completion: completion handler. (default: {})
     */
    func pushViewController(
        _ viewController: UIViewController,
        animated: Bool = true,
        completion: @escaping (() -> Void) = {}) {
        
        pushViewController(viewController, animated: animated)
        
        guard animated, let coordinator = transitionCoordinator else {
            DispatchQueue.main.async { completion() }
            return
        }
        
        coordinator.animate(alongsideTransition: nil) { _ in completion() }
    }
    
    /**
     pop view controller with completion handler.
     
     ### Chinese description ###
     為 popViewController 加上 call back.
     
     ## Use example ##
     ```swift
     popViewController {
        print("did popViewController")
     }
     ```
     cf. https://stackoverflow.com/questions/9906966/completion-handler-for-uinavigationcontroller-pushviewcontrolleranimated/33767837#33767837
     
     - Parameters:
        - animated: animated with push. (default: true)
        - completion: completion handler. (default: {})
     */
    func popViewController(
        animated: Bool = true,
        completion: @escaping () -> Void) {

        popViewController(animated: animated)
        
        guard animated, let coordinator = transitionCoordinator else {
            DispatchQueue.main.async { completion() }
            return
        }
        
        coordinator.animate(alongsideTransition: nil) { _ in completion() }
    }
    
    /**
     pop to root view controller with completion handler.
     
     ### Chinese description ###
     為 popToRootViewController 加上 call back.
     
     ## Use example ##
     ```swift
     popToRootViewController {
        print("did popToRootViewController")
     }
     ```
     cf. https://stackoverflow.com/questions/9906966/completion-handler-for-uinavigationcontroller-pushviewcontrolleranimated/33767837#33767837
     
     - Parameters:
        - animated: animated with popToRootViewController. (default: true)
        - completion: completion handler. (default: {})
     */
    func popToRootViewController(
        animated: Bool = true,
        completion: @escaping (() -> Void) = {}) {
        
        popToRootViewController(animated: animated)
        
        guard animated, let coordinator = transitionCoordinator else {
            DispatchQueue.main.async { completion() }
            return
        }
        
        coordinator.animate(alongsideTransition: nil) { _ in completion() }
    }
    
    /**
     pop to view controller with completion handler.
     
     ### Chinese description ###
     為 popToViewController 加上 call back.
     
     ## Use example ##
     ```swift
     let vc = UIViewController()
     popToViewController(vc) {
        print("did popToViewController")
     }
     ```
     cf. https://stackoverflow.com/questions/9906966/completion-handler-for-uinavigationcontroller-pushviewcontrolleranimated/33767837#33767837
     
     - Parameters:
         - viewController: target view controller
         - animated: animated with popToViewController. (default: true)
         - completion: completion handler. (default: {})
     */
    func popToViewController(
        _ viewController: UIViewController,
        animated: Bool = true,
        completion: @escaping (() -> Void) = {}) {
        
        popToViewController(viewController, animated: animated)
        
        guard animated, let coordinator = transitionCoordinator else {
            DispatchQueue.main.async { completion() }
            return
        }
        
        coordinator.animate(alongsideTransition: nil) { _ in completion() }
    }
}
