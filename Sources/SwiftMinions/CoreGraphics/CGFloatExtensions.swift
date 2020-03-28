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
    
    func toDouble() -> Double {
        return Double(self)
    }
    
    func toFloat() -> Float {
        return Float(self)
    }
    
    #if canImport(Foundation)
    func toInt() -> Int {
        return Int(self)
    }
    #endif
}

#endif

