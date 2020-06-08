//
//  UIStackViewExtensions.swift
//  SwiftMinions
//
//  Created by Ohlulu on 2020/5/18.
//  Copyright © 2020 SwiftMinions. All rights reserved.
//

import UIKit

public extension UIStackView {
    
    /**
     Add arranged subviews.
    
     ## Chinese description
     增加複數的 arranged subView.
    
     ## Use example
     ```swift
        let views = [UIView(), UIView(), UIView(), UIView()]
        let stackView = UIStackView()
        stackView.addArranged(subviews: views)
     ```
    
     - Parameter subviews: Array of view.
    */
    func addArranged(subviews: [UIView]) {
        for view in subviews {
            addArrangedSubview(view)
        }
    }
    
    /**
     Force remove all arranged subviews.
    
     ## Chinese description
     移除所有的排列子視圖。
    
     ## Use example
     ```swift
        let stackView = UIStackView()
        stackView.forceRemoveAllArrangedSubviews()
     ```
    */
    func forceRemoveAllArrangedSubviews() {
        for view in arrangedSubviews {
            removeArrangedSubview(view)
            view.removeFromSuperview()
        }
    }
    
    /**
     Force remove some arranged subviews.
    
     ## Chinese description
     移除部分排列子視圖。
    
     ## Use example
     ```swift
        let views = [UIView()]
        let stackView = UIStackView()
        stackView.forceRemoveArranged(subviews: views)
     ```
    
     - Parameter subviews: Array of view.
    */
    func forceRemoveArranged(subviews: [UIView]) {
        for view in self.subviews {
            if !subviews.contains(view) {
                continue
            }
            removeArrangedSubview(view)
            view.removeFromSuperview()
        }
    }
}
