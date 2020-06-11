//
//  UIScrollViewExtensions.swift
//  SwiftMinions
//
//  Created by stephen on 2020/3/29.
//  Copyright © 2020 SwiftMinions. All rights reserved.
//

import UIKit

public extension UIScrollView {
        
    /**
     Update contentSize height while scroll view did finish layout all subviews
    
     ### Chinese description
     根據所有的 subviews 所有的高度來更新 scroll 的 contentSize 高度
    
     ### Use example
     ```swift
     override func viewDidLayoutSubviews() {
         super.viewDidLayoutSubviews()
         scrollView.updateContentViewHeight()
     }
     ```
    */
    func updateContentViewHeight() {
        self.contentSize.height = subviews.sorted(by: { $0.frame.maxY < $1.frame.maxY }).last?.frame.maxY ?? contentSize.height
    }
    
    /**
     Update contentSize Width while scroll view did finish layout all subviews
    
     ### Chinese description
     根據所有的 subviews 所有的寬度來更新 scroll 的 contentSize 寬度
    
     ### Use example
     ```swift
     override func viewDidLayoutSubviews() {
         super.viewDidLayoutSubviews()
         scrollView.updateContentViewWidth()
     }
     ```
    */
    func updateContentViewWidth() {
        self.contentSize.width = subviews.sorted(by: { $0.frame.maxX < $1.frame.maxX }).last?.frame.maxX ??  contentSize.width
    }
}

public extension UIScrollView {
    
    private struct Keys {
        static var enableHeightToFit: UInt8 = 0
        static var scrollViewObserverObj: UInt8 = 0
        static var minimunHeightToFit: UInt8 = 0
        static var maximunHeightToFit: UInt8 = 0
    }

    private func getAsscociatedValue<T>(_ object: Any, key: UnsafeRawPointer) -> T? {
        return objc_getAssociatedObject(object, key) as? T
    }

    private func setAsscociatedValue<T>(_ object: Any, key: UnsafeRawPointer, value: T) {
        objc_setAssociatedObject(object, key, value, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }

    /**
     Set true, make scroll view frame height equal to content height.
     Note: This will reuse invalidation
    
     ### Chinese description
     設置為 true 時，使 scroll view 的 frame height 等於 conetent height
     注意：這會讓 reuse 失效
     */
    var enableHeightToFit: Bool {
        get {
            return getAsscociatedValue(self, key: &Keys.enableHeightToFit) ?? false
        }
        set(isEnable) {
            setAsscociatedValue(self, key: &Keys.enableHeightToFit, value: isEnable)
            if isEnable {
                addObserver()
            } else {
                removeObserver()
            }
        }
    }
    
    /**
     Set minimun frame height.
    
     ### Chinese description
     設置最小高度。
     */
    var minimunHeightToFit: CGFloat {
        get {
            return getAsscociatedValue(self, key: &Keys.minimunHeightToFit) ?? 0
        }
        set {
            setAsscociatedValue(self, key: &Keys.minimunHeightToFit, value: newValue)
        }
    }
    
    /**
     Set maximun frame height. Unlimited when nil.
    
     ### Chinese description
     設置最大高度，nil 時為不限制。
     */
    var maximunHeightToFit: CGFloat? {
        get {
            return getAsscociatedValue(self, key: &Keys.maximunHeightToFit)
        }
        set {
            setAsscociatedValue(self, key: &Keys.maximunHeightToFit, value: newValue)
        }
    }
    
    
    private var scrollViewObserverObj: NSKeyValueObservation? {
        get {
            return getAsscociatedValue(self, key: &Keys.scrollViewObserverObj)
        }
        set {
            setAsscociatedValue(self, key: &Keys.scrollViewObserverObj, value: newValue)
        }
    }
    
    private func addObserver() {
        scrollViewObserverObj = observe(\.contentSize) { [weak self] (obj, change) in
            guard let self = self, self.enableHeightToFit else {
                return
            }
            
            var height = max(obj.contentSize.height + obj.contentInset.vertical,
                             self.minimunHeightToFit)
            
            if let maxHeight = self.maximunHeightToFit {
                height = min(maxHeight, height)
            }
            
            let heightContraint = obj.constraints.first(where: {
                $0.firstAttribute == .height && $0.relation == .equal
            })
            
            if let heightContraint = heightContraint {
                heightContraint.constant = height
            } else {
                obj.heightAnchor.constraint(equalToConstant: height).isActive = true
            }
        }
    }
    
    func removeObserver() {
        objc_removeAssociatedObjects(self)
    }
}
