//
//  CGFloatExtensions.swift
//  SwiftMinions
//
//  Created by Ohlulu on 2020/3/29.
//  Copyright © 2020 SwiftMinions. All rights reserved.
//

#if canImport(CoreGraphics)
import CoreGraphics

#if canImport(Foundation)
import Foundation
#endif

public extension CGFloat {
    
    /// Get Double type
    func toDouble() -> Double {
        return Double(self)
    }
    
    /// Get Float type
    func toFloat() -> Float {
        return Float(self)
    }
    
    #if canImport(Foundation)
    /// Get Int type
    func toInt() -> Int {
        return Int(self)
    }
    #endif
}

#endif

