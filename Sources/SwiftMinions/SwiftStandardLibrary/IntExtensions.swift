//
//  IntExtensions.swift
//  SwiftMinions
//
//  Created by Ohlulu on 2020/3/29.
//  Copyright © 2020 SwiftMinions. All rights reserved.
//

import Foundation

#if canImport(CoreGraphics)
import CoreGraphics
#endif

public extension Int {
    
    /**
     Get Double type

     ## Chinese description
     轉型成 Double
    */
    func toDouble() -> Double {
        return Double(self)
    }
    
    /**
     Get Float type

     ## Chinese description
     轉型成 Float
    */
    func toFloat() -> Float {
        return Float(self)
    }
    
    /**
     Get CGFloat type

     ## Chinese description
     轉型成 CGFloat
    */
    #if canImport(CoreGraphics)
    func toCgfloat() -> CGFloat {
        return CGFloat(self)
    }
    #endif
}
