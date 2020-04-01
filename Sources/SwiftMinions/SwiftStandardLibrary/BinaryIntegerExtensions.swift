//
//  DoubleExtensions.swift
//  SwiftMinions
//
//  Created by twStephen on 2020/3/6.
//  Copyright © 2020 SwiftMinions. All rights reserved.
//

import UIKit

public extension BinaryInteger {
    
    /**
     Change to radians value
     
     ## Chinese description
     轉成弧度，單位 π
     
     ## Use example
     ```swift
     
     90.radiansValue            /// 1.570796326794897
     Int(90).radiansValue       /// 1.570796326794897
     Int8(90).radiansValue      /// 1.570796326794897
     Int16(90).radiansValue     /// 1.570796326794897
     Int32(90).radiansValue     /// 1.570796326794897
     Int64(90).radiansValue     /// 1.570796326794897
     
     ```
     */
    var radiansValue: CGFloat {
        return CGFloat(self) * .pi / 180
    }
    
    /**
     Change to degrees value
     
     ## Chinese description
     轉成度數，單位 0° ~ 360°
     
     ## Use example
     ```swift
     
     1.degreesValue             /// 57.295
     Int(1).degreesValue        /// 57.295
     Int8(1).degreesValue       /// 57.295
     Int16(1).degreesValue      /// 57.295
     Int32(1).degreesValue      /// 57.295
     Int64(1).degreesValue      /// 57.295
     
     ```
     */
    var degreesValue: CGFloat {
        return CGFloat(self) * 180 / .pi
    }
}
