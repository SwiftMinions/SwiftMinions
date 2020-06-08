//
//  CGRectExtensions.swift
//  SwiftMinions
//
//  Created by Ohlulu on 2020/4/27.
//  Copyright © 2020 SwiftMinions. All rights reserved.
//

import CoreGraphics

public extension CGRect {
    
    /// Create CGRect from width and height.
    /// x, y is 0
    init(width: Double, height: Double) {
        self.init(x: 0, y: 0, width: width, height: height)
    }
    
    /// Create CGRect from width and height.
    /// x, y is 0
    init(width: Float, height: Float) {
        self.init(x: 0, y: 0, width: width.cgfloatValue, height: height.cgfloatValue)
    }
    
    /// Create CGRect from width and height.
    /// x, y is 0
    init(width: CGFloat, height: CGFloat) {
        self.init(x: 0, y: 0, width: width, height: height)
    }
    
    /// Create CGRect from width and height.
    /// x, y is 0
    init(width: Int, height: Int) {
        self.init(x: 0, y: 0, width: width, height: height)
    }
    
    /// Create CGRect with square.
    /// x, y is 0
    init(square: Double) {
        self.init(x: 0, y: 0, width: square, height: square)
    }
    
    /// Create CGRect with square.
    /// x, y is 0
    init(square: Float) {
        self.init(x: 0, y: 0, width: square.cgfloatValue, height: square.cgfloatValue)
    }
    
    /// Create CGRect with square.
    /// x, y is 0
    init(square: CGFloat) {
        self.init(x: 0, y: 0, width: square, height: square)
    }
    
    /// Create CGRect with square.
    /// x, y is 0
    init(square: Int) {
        self.init(x: 0, y: 0, width: square, height: square)
    }
}
