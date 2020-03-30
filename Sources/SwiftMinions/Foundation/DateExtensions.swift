//
//  DateExtensions.swift
//  SwiftMinions
//
//  Created by Ohlulu on 2020/3/6.
//  Copyright © 2020 SwiftMinions. All rights reserved.
//

import Foundation

private let formatter = DateFormatter()

public extension Date {
    
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
     
     - Returns: String
     */
    func toString(format: String = "yyyy-MM-dd HH:mm:ss") -> String {
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    /**
     Date add value with component.
     
     ### Chinese description
     依據 Calendar.Component & value ，回傳新的時間
     
     ## Use example ##
     ```swift
     Date().add(.day, value: 5) // 2020/11/24 -> 2020/11/29
     Date().add(.month, value: -1) // 2020/11/24 -> 2021/10/24
     Date().add(.year, value: 1) // 2020/11/24 -> 2021/11/24
     ```

     - Parameter component: Calendar.Component
     - Parameter value: modify value
     
     - Returns: Date
     */
    @discardableResult
    func add(_ component: Calendar.Component, value: Int) -> Date {
        return MinionsConfig.calendar.date(byAdding: component, value: value, to: self) ?? self
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
     
     - Returns: Int
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
     Date().hour
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

    /**
     Data at the beginning of calendar component.
     cf. https://github.com/SwifterSwift/SwifterSwift/blob/master/Sources/SwifterSwift/Foundation/DateExtensions.swift
     
     ## Chinese description
     取得日曆組件起始時間
     
     ## Use example
     ```swift
        let date = Date() // "Jan 12, 2017, 7:14 PM"
        let date2 = date.beginning(of: .hour) // "Jan 12, 2017, 7:00 PM"
        let date3 = date.beginning(of: .month) // "Jan 1, 2017, 12:00 AM"
        let date4 = date.beginning(of: .year) // "Jan 1, 2017, 12:00 AM"
     ```
     
     - Parameter component: calendar component to get date at the beginning of.
     - Returns: date at the beginning of calendar component (if applicable).
     */
    func beginning(of component: Calendar.Component) -> Date? {
        if component == .day {
            return MinionsConfig.calendar.startOfDay(for: self)
        }
        
        var components: Set<Calendar.Component> {
            switch component {
            case .second:
                return [.year, .month, .day, .hour, .minute, .second]
                
            case .minute:
                return [.year, .month, .day, .hour, .minute]
                
            case .hour:
                return [.year, .month, .day, .hour]
                
            case .weekOfYear, .weekOfMonth:
                return [.yearForWeekOfYear, .weekOfYear]
                
            case .month:
                return [.year, .month]
                
            case .year:
                return [.year]
                
            default:
                return []
            }
        }
        
        guard !components.isEmpty else { return nil }
        return MinionsConfig.calendar.date(from: Calendar.current.dateComponents(components, from: self))
    }
    
    /**
     Date at the end of calendar component.
     cf. https://github.com/SwifterSwift/SwifterSwift/blob/master/Sources/SwifterSwift/Foundation/DateExtensions.swift
    
     ## Chinese description
     取得日曆組件的結尾期間
     
     ## Use example
     ```swift
        let date = Date() // "Jan 12, 2017, 7:27 PM"
        let date2 = date.end(of: .day) // "Jan 12, 2017, 11:59 PM"
        let date3 = date.end(of: .month) // "Jan 31, 2017, 11:59 PM"
        let date4 = date.end(of: .year) // "Dec 31, 2017, 11:59 PM"
     ```
     
     - Parameter component: calendar component to get date at the end of.
     - Returns: date at the end of calendar component (if applicable).
    */
    func end(of component: Calendar.Component) -> Date? {
        let calendar = MinionsConfig.calendar
        switch component {
        case .second:
            var date = add(.second, value: 1)
            date = calendar.date(from:
                calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date))!
            date.add(.second, value: -1)
            return date
            
        case .minute:
            var date = add(.minute, value: 1)
            let after = calendar.date(from:
                calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date))!
            date = after.add(.second, value: -1)
            return date
            
        case .hour:
            var date = add(.hour, value: 1)
            let after = calendar.date(from:
                calendar.dateComponents([.year, .month, .day, .hour], from: date))!
            date = after.add(.second, value: -1)
            return date
            
        case .day:
            var date = add(.day, value: 1)
            date = calendar.startOfDay(for: date)
            date.add(.second, value: -1)
            return date
            
        case .weekOfYear, .weekOfMonth:
            var date = self
            let beginningOfWeek = calendar.date(from:
                calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date))!
            date = beginningOfWeek.add(.day, value: 7).add(.second, value: -1)
            return date
            
        case .month:
            var date = add(.month, value: 1)
            let after = calendar.date(from:
                calendar.dateComponents([.year, .month], from: date))!
            date = after.add(.second, value: -1)
            return date
            
        case .year:
            var date = add(.year, value: 1)
            let after = calendar.date(from:
                calendar.dateComponents([.year], from: date))!
            date = after.add(.second, value: -1)
            return date
            
        default:
            return nil
        }
    }
}
