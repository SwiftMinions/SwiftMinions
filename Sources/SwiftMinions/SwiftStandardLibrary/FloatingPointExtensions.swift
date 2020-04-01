//
//  FloatingPointExtensions.swift
//  SwiftMinions
//
//  Created by twStephen on 2020/3/6.
//  Copyright © 2020 SwiftMinions. All rights reserved.
//

import Foundation

public extension FloatingPoint {
    
    /**
     Change to radians value
     
     ## Chinese description
     轉成弧度，單位 π
     
     ## Use example
     ```swift
     
     Double(1.1).radiansValue    // 0.01919862177193763
     Float(1.1).radiansValue     // 0.01919862177193763
     CGFloat(1.1).radiansValue   // 0.01919862177193763
     Float80(1.1).radiansValue   // 0.01919862177193763
     
     ```
     */
    var radiansValue: Self {
        return self * .pi / 180
    }
    
    /**
     Change to degrees value
     
     ## Chinese description
     轉成度數，單位 0° ~ 360°
     
     ## Use example
     ```swift
     
     Double(1.1).degreesValue    // 63.02535746439057
     Float(1.1).degreesValue     // 63.02535746439057
     CGFloat(1.1).degreesValue   // 63.02535746439057
     Float80(1.1).degreesValue   // 63.02535746439057
     
     ```
     */
    var degreesValue: Self {
        return self * 180 / .pi
    }
}

