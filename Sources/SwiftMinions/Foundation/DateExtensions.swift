//
//  DateExtensions.swift
//  SwiftMinions
//
//  Created by Ohlulu on 2020/3/6.
//  Copyright © 2020 SwiftMinions. All rights reserved.
//

import Foundation

private let formatter = DateFormatter()

extension Date {
    
    /**
     Get string with format.
     
     ### Chinese description
     輸出格式化日期
    
     ## Use example ##
     ```swift
     Date().toString()
     // print 2020-11-24 05:30:30
     
     Date().toString(format: "yyyy-MM-dd")
     // print 2020-11-24
     ```
     - Parameter format: format string
     
     Returns: String
     */
    func toString(format: String = "yyyy-MM-dd HH:mm:ss") -> String {
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    /**
     Get year from date. Calendar instance from `MinionsConfig.calendar`.
     
     ### Chinese description
     從日期物件取得年。日曆物件從 `MinionsConfig.calendar` 取得。
    
     ## Use example ##
     ```swift
     Date().year
     // 2020
     ```
     
     Returns: Int
     */
    var year: Int {
        MinionsConfig.calendar.component(.year, from: self)
    }
    
    /**
     Get month from date. Calendar instance from `MinionsConfig.calendar`.
     
     ### Chinese description
     從日期物件取得月。日曆物件從 `MinionsConfig.calendar` 取得。
    
     ## Use example ##
     ```swift
     Date().month
     // 11
     ```
     
     Returns: Int
     */
    var month: Int {
        MinionsConfig.calendar.component(.month, from: self)
    }
    
    /**
     Get day from date. Calendar instance from `MinionsConfig.calendar`.
     
     ### Chinese description
     從日期物件取得日。日曆物件從 `MinionsConfig.calendar` 取得。
    
     ## Use example ##
     ```swift
     Date().day
     // 24
     ```
     
     Returns: Int
     */
    var day: Int {
        MinionsConfig.calendar.component(.day, from: self)
    }
    
    /**
     Get hour form date (24Hr). Calendar instance from `MinionsConfig.calendar`.
     
     ### Chinese description
     從日期物件取得小時(24小時制)。日曆物件從 `MinionsConfig.calendar` 取得。
    
     ## Use example ##
     ```swift
     Date().
     // 8
     ```
     
     Returns: Int
     */
    var hour: Int {
        MinionsConfig.calendar.component(.hour, from: self)
    }
    
    /**
     Get minute from date. Calendar instance from `MinionsConfig.calendar`.
     
     ### Chinese description
     從日期物件取得分鐘。日曆物件從 `MinionsConfig.calendar` 取得。
    
     ## Use example ##
     ```swift
     Date().minute
     // 11
     ```
     
     Returns: Int
     */
    var minute: Int {
        MinionsConfig.calendar.component(.minute, from: self)
    }
    
    /**
     Get second from date. Calendar instance from `MinionsConfig.calendar`.
     
     ### Chinese description
     從日期物件取得秒。日曆物件從 `MinionsConfig.calendar` 取得。
    
     ## Use example ##
     ```swift
     Date().second
     // 59
     ```
     
     Returns: Int
     */
    var second: Int {
        MinionsConfig.calendar.component(.second, from: self)
    }
}
