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
    
    /**
     Get Int type

     ## Chinese description
     轉型成 Int
    */
    var intValue: Int {
        return Int(self)
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
     Get CGFloat type

     ## Chinese description
     轉型成 CGFloat
    */
    #if canImport(CoreGraphics)
    var cgfloatValue: CGFloat {
        return CGFloat(self)
    }
    #endif

    /**
     This function returns a Double number rounded correctly to a given number of digits using the given rounding mode, which can be rounded, round up, round down or round-to-even

     ## Chinese description
     用指定方法（四捨五入/無條件進位/無條件捨去/四捨五入取偶數）取至小數位第x位

     ## Usage Example
     ```
     let num = 6.445677
     num.rounded(to: 2, option: .plain) // 6.45
     num.rounded(to: 2, option: .up) // 6.45
     num.rounded(to: 2, option: .down) // 6.44
     num.rounded(to: 2, option: .bankers) // 6.45

     Double(exactly: 0.5)!.rounded(to: 0, option: .bankers) // 0.0
     Double(exactly: 0.5)!.rounded(to: 0, option: .bankers) // 2.0
     ```
     */
    func rounded(to places: Int, option: NSDecimalNumber.RoundingMode) -> Double {
        var value = Decimal(self)
        var roundedValue = Decimal()

        NSDecimalRound(&roundedValue, &value, places, option)

        return roundedValue.doubleValue
    }

}
