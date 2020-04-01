//
//  UIEdgeInsetsExtensions.swift
//  SwiftMinions
//
//  Created by Ohlulu on 2020/3/29.
//  Copyright © 2020 SwiftMinions. All rights reserved.
//

import UIKit

public extension UIEdgeInsets {
    
    /// Convenience initialize
    init(edge: CGFloat) {
        self.init(top: edge, left: edge, bottom: edge, right: edge)
    }
    
    /// Convenience initialize
    init(top: CGFloat? = nil, left: CGFloat? = nil, bottom: CGFloat? = nil, right: CGFloat? = nil, default defaultValue: CGFloat) {
        self.init(top: top ?? defaultValue, left: left ?? defaultValue, bottom: bottom ?? defaultValue, right: right ?? defaultValue)
    }
    
    /// Convenience initialize
    init(horizontalEdge edge: CGFloat) {
        self.init(top: 0, left: edge, bottom: 0, right: edge)
    }
    
    /// Convenience initialize
    init(verticalEdge edge: CGFloat) {
        self.init(top: edge, left: 0, bottom: edge, right: 0)
    }
    
    /// Convenience initialize
    init(horizontalEdge hEdge: CGFloat, verticalEdge vEdge: CGFloat) {
        self.init(top: vEdge, left: hEdge, bottom: vEdge, right: hEdge)
    }
    
    /**
     Get veritical edge
    
     ## Chinese description
     取得 top & bottom 加總
    
     ## Use example
     ```swift
        let inset = UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 8)
        inset.vertical
        // 20
     ```
    */
    var vertical: CGFloat {
        return top + bottom
    }
    /**
     Get horizontal edge
    
     ## Chinese description
     取得 left & right 加總
    
     ## Use example
     ```swift
        let inset = UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 8)
        inset.vertical
        // 16
     ```
    */
    var horizontal: CGFloat {
        return left + right
    }
}
