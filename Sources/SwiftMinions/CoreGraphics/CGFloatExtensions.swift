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
    
    /**
     Get Double type

     ## Chinese description
     轉型成 Double
    */
    var doubleValue: Double {
        return Double(self)
    }
    
    /**
     Get Float type

     ## Chinese description
     轉型成 Float
    */
    var floatValue: Float {
        return Float(self)
    }
    
    /**
     Get Int type

     ## Chinese description
     轉型成 Int
    */
    #if canImport(Foundation)
    var intValue: Int {
        return Int(self)
    }
    #endif
}

#endif

