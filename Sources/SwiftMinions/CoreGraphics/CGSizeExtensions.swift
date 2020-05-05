//
//  CGSizeExtensions.swift
//  SwiftMinions
//
//  Created by Ohlulu on 2020/4/27.
//  Copyright © 2020 SwiftMinions. All rights reserved.
//

import CoreGraphics

public extension CGSize {
    
    /// Create size with square.
    init(square: Double) {
        self.init(width: square, height: square)
    }
    
    /// Create size with square.
    init(square: CGFloat) {
        self.init(width: square, height: square)
    }
    
    /// Create size with square.
    init(square: Int) {
        self = .init(width: square, height: square)
    }
}
