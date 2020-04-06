//
//  CGFloatExtensions.swift
//  SwiftMinions
//
//  Created by Natalie Ng on 2020/4/6.
//  Copyright © 2020 SwiftMinions. All rights reserved.
//

import Foundation

public extension CGFloat {

    /**
     This function returns a CGFloat number rounded correctly to a given number of digits using the given rounding mode, which can be rounded, round up, round down or round-to-even

     ## Chinese description
     用指定方法（四捨五入/無條件進位/無條件捨去/四捨五入取偶數）取至小數位第x位

     ## Usage Example
     ```
     let num: CGFloat = 6.4456
     num.rounded(to: 2, option: .plain) // 6.45
     num.rounded(to: 2, option: .up) // 6.45
     num.rounded(to: 2, option: .down) // 6.44
     num.rounded(to: 2, option: .bankers) // 6.45

     ```
     */
    func rounded(to places: Int, option: NSDecimalNumber.RoundingMode) -> CGFloat {
        return CGFloat(Double(self).rounded(to: places, option: option))
    }

}

