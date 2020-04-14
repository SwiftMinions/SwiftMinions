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
}
