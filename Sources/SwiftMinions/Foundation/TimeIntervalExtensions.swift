//
//  TimeIntervalExtensions.swift
//  SwiftMinions
//
//  Created by Ohlulu on 2020/4/4.
//  Copyright © 2020 SwiftMinions. All rights reserved.
//

import Foundation

public extension TimeInterval {
    
    /**
     Convenines get date since 1970 from TimeInterval.
    
     ## Chinese description
     取得 Date 值
    
     ## Use example
     ```swift
        TimeInterval().dateSince1970
     ```
    */
    var dateSince1970: Date {
        return Date(timeIntervalSince1970: self)
    }
    
    /**
     Get string with format.
     
     ## Chinese description
     輸出格式化日期
    
     ## Use example
     ```swift
         TimeInterval().toString()
         // print 2020-11-24 05:30:30
         
         TimeInterval().toString(format: "yyyy-MM-dd")
         // print 2020-11-24
     ```
     - Parameter format: format string
     
     - Returns: String
     */
    func toString(format: String = "yyyy-MM-dd HH:mm:ss") -> String {
        return dateSince1970.toString(format: format)
    }
}
