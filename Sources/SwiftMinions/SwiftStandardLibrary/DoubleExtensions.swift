//
//  DoubleExtension.swift
//  SwiftMinions
//
//  Created by Natalie Ng on 2020/3/26.
//  Copyright © 2020 SwiftMinions. All rights reserved.
//

import Foundation


extension Double {
    /**

     Round a double correctly to specific decimal places with specific option (rounded/ round up/ round down/ round-to-even)

     ## Chinese description
     用指定方法（四捨五入/無條件進位/無條件捨去/四捨五入取偶數）取至小數位第x位

     ## Usage Example
     ```
     let num = 6.445677
     num.rounded(to: 2, option: .down) // get 6.45
     num.rounded(to: 2, option: .up) // get 6.45
     num.rounded(to: 2, option: .down) // get 6.44
     num.rounded(to: 2, option: .banker) // get 6.45
     ```
     */
    func rounded(to places: Int, option: NSDecimalNumber.RoundingMode) -> Double {
        var value = Decimal(self)
        var roundedValue = Decimal()

        NSDecimalRound(&roundedValue, &value, places, option)

        return roundedValue.doubleValue
    }


}
