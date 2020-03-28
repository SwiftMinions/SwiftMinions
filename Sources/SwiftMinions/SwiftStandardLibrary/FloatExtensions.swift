//
//  FloatExtensions.swift
//  SwiftMinions
//
//  Created by Ohlulu on 2020/3/29.
//  Copyright © 2020 SwiftMinions. All rights reserved.
//

import Foundation

#if canImport(CoreGraphics)
import CoreGraphics
#endif

public extension Float {
    
    func toDouble() -> Double {
        return Double(self)
    }
    
    func toInt() -> Int {
        return Int(self)
    }
    
    #if canImport(CoreGraphics)
    func toCgfloat() -> CGFloat {
        return CGFloat(self)
    }
    #endif
}
