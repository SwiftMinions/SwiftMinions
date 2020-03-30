//
//  DoubleExtension.swift
//  SwiftMinions
//
//  Created by Ohlulu on 2020/3/29.
//  Copyright © 2020 SwiftMinions. All rights reserved.
//

import Foundation

#if canImport(CoreGraphics)
import CoreGraphics
#endif

public extension Double {
    
    /// Get Int type
    func toInt() -> Int {
        return Int(self)
    }
    
    /// Get Float type
    func toFloat() -> Float {
        return Float(self)
    }
    
    #if canImport(CoreGraphics)
    /// Get CGFloat type
    func toCgfloat() -> CGFloat {
        return CGFloat(self)
    }
    #endif
}
