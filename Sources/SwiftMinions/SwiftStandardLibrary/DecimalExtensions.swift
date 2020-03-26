//
//  DecimalExtensions.swift
//  SwiftMinions
//
//  Created by Natalie Ng on 2020/3/26.
//  Copyright © 2020 SwiftMinions. All rights reserved.
//

import Foundation


extension Decimal {
    /**
    Round a double to specific decimal places with specific option (rounded/ round up/ round down etc.)
    ### Chinese description
    用指定方法（四捨五入/ ）取至小數位第x位

    ### Usage Example
    ```
    let anum = 6.445677
    num.rounded(to: 2, option: .down) // get 6.45
    num.rounded(to: 2, option: .up) // get 6.45
    num.rounded(to: 2, option: .down) // get 6.44
    ```
    */
    var doubleValue: Double {
        return NSDecimalNumber(decimal: self).doubleValue
    }
}
