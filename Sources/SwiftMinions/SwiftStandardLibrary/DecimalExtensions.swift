//
//  DecimalExtensions.swift
//  SwiftMinions
//
//  Created by Natalie Ng on 2020/3/26.
//  Copyright © 2020 SwiftMinions. All rights reserved.
//

import Foundation


public extension Decimal {
    /**
    Convert to Double value

    ## Chinese description
    轉型成 Double

    ### Usage Example
    ```
    Decimal(string: "3.14")?.doubleValue // 3.14
    ```
    */
    var doubleValue: Double {
        return NSDecimalNumber(decimal: self).doubleValue
    }

    /**
    This function returns a Decimal number rounded correctly to a given number of digits using the given rounding mode, which can be rounded, round up, round down or round-to-even

    ## Chinese description
    用指定方法（四捨五入/無條件進位/無條件捨去/四捨五入取偶數）取至小數位第x位

    ## Usage Example
    ```
    let num: Decimal = 6.4456
    num.rounding(withMode: .plain, toPlaces: 2) // 6.45
    num.rounding(withMode: .up, toPlaces: 2) // 6.45
    num.rounding(withMode: .down, toPlaces: 2) // 6.44
    num.rounding(withMode: .bankers, toPlaces: 2) // 6.45
    ```
    */
   func rounding(withMode option: NSDecimalNumber.RoundingMode,
    toPlaces places: Int) -> Decimal {
        var value = self
        var roundedValue = Decimal()

        NSDecimalRound(&roundedValue, &value, places, option)

        return roundedValue
    }

    /**
     This function returns a number rounded UP to the given decimal places

     ## Chinese description
     用指定方法無條件進位至小數位第x位

     ## Usage Example
     ```
     let num: Decimal = 6.444677
     num.ceil(to: 2) // 6.45
     ```
     */
    func ceil(to places: Int) -> Decimal {
        return self.rounding(withMode: .up, toPlaces: places)
    }

    /**
     This function returns a number rounded DOWN to the given decimal places

     ## Chinese description
     用指定方法無條件捨去至小數位第x位

     ## Usage Example
     ```
     let num: Decimal = 6.445677
     num.floor(to: 2) // 6.44
     ```
     */
    func floor(to places: Int) -> Decimal {
       return self.rounding(withMode: .down, toPlaces: places)
    }

    /**
     This function returns a number rounded to the given decimal places

     ## Chinese description
     用指定方法四捨五入至小數位第x位

     ## Usage Example
     ```
     let num: Decimal = 6.445677
     num.rounded(to: 2) // 6.45
     ```
     */
    func rounded(to places: Int) -> Decimal {
        return self.rounding(withMode: .plain, toPlaces: places)
    }
}
