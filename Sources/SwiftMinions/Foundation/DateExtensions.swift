//
//  DateExtensions.swift
//  SwiftMinions
//
//  Created by Ohlulu on 2020/3/6.
//  Copyright © 2020 SwiftMinions. All rights reserved.
//

import Foundation


public extension Date {
    
    /**
     Get string with format.
     
     ### Chinese description
     輸出格式化日期
    
     ### Use example
     ```swift
     Date().toString()
     // print 2020-11-24 05:30:30
     
     Date().toString(format: "yyyy-MM-dd")
     // print 2020-11-24
     ```
     - Parameter format: string format. (default is SMConfig.dateFormatString)
     - Returns: String
     */
    func toString(format: String = SMConfig.dateFormatString) -> String {
        let formatter = SMConfig.dateFormatter
        formatter.dateFormat = format
        formatter.timeZone = SMConfig.timeZone
        return formatter.string(from: self)
    }
    
    /**
     Date add value with component.
     
     ### Chinese description
     依據 Calendar.Component & value ，回傳新的時間
     
     ### Use example
     ```swift
     Date().added(.day, value: 5) // 2020/11/24 -> 2020/11/29
     Date().added(.month, value: -1) // 2020/11/24 -> 2021/10/24
     Date().added(.year, value: 1) // 2020/11/24 -> 2021/11/24
     ```

     - Parameters:
        - value: modify value
        - component: Calendar.Component
     - Returns: New date
     */
    @discardableResult
    func added(by value: Int, _ component: Calendar.Component) -> Date {
        SMConfig.calendar.date(byAdding: component, value: value, to: self) ?? self
    }
    
    /// SwifterSwift: Date by changing value of calendar component.
    ///
    ///     let date = Date() // "Jan 12, 2017, 7:07 PM"
    ///     let date2 = date.changing(.minute, value: 10) // "Jan 12, 2017, 6:10 PM"
    ///     let date3 = date.changing(.day, value: 4) // "Jan 4, 2017, 7:07 PM"
    ///     let date4 = date.changing(.month, value: 2) // "Feb 12, 2017, 7:07 PM"
    ///     let date5 = date.changing(.year, value: 2000) // "Jan 12, 2000, 7:07 PM"
    ///
    /// - Parameters:
    ///   - component: component type.
    ///   - value: new value of compnenet to change.
    /// - Returns: original date after changing given component to given value.
    
    /**
     Date by changing value of calendar component.
     cf. https://github.com/SwifterSwift/SwifterSwift/blob/master/Sources/SwifterSwift/Foundation/DateExtensions.swift
    
     ### Chinese description
     通過日曆組件，改變日期的值。
     
     ### Use example
     ```swift
     let date = Date() // "Jan 12, 2017, 7:07 PM"
     let date2 = date.changing(.minute, value: 10) // "Jan 12, 2017, 6:10 PM"
     let date3 = date.changing(.day, value: 4) // "Jan 4, 2017, 7:07 PM"
     let date4 = date.changing(.month, value: 2) // "Feb 12, 2017, 7:07 PM"
     let date5 = date.changing(.year, value: 2000) // "Jan 12, 2000, 7:07 PM"
     ```
     
     - Parameters:
         - value: modify value
         - component: Calendar.Component
     - Returns: date at the end of calendar component (if applicable).
    */
    func changing(by value: Int, _ component: Calendar.Component) -> Date {
        let calendar = SMConfig.calendar
        switch component {
        case .nanosecond:
            #if targetEnvironment(macCatalyst)
            // The `Calendar` implementation in `macCatalyst` does not know that a nanosecond is 1/1,000,000,000th of a second
            let allowedRange = 0..<1_000_000_000
            #else
            let allowedRange = calendar.range(of: .nanosecond, in: .second, for: self)!
            #endif
            guard allowedRange.contains(value) else { return self }
            let currentNanoseconds = calendar.component(.nanosecond, from: self)
            let nanosecondsToAdd = value - currentNanoseconds
            return calendar.date(byAdding: .nanosecond, value: nanosecondsToAdd, to: self) ?? self

        case .second:
            let allowedRange = calendar.range(of: .second, in: .minute, for: self)!
            guard allowedRange.contains(value) else { return self }
            let currentSeconds = calendar.component(.second, from: self)
            let secondsToAdd = value - currentSeconds
            return calendar.date(byAdding: .second, value: secondsToAdd, to: self) ?? self

        case .minute:
            let allowedRange = calendar.range(of: .minute, in: .hour, for: self)!
            guard allowedRange.contains(value) else { return self }
            let currentMinutes = calendar.component(.minute, from: self)
            let minutesToAdd = value - currentMinutes
            return calendar.date(byAdding: .minute, value: minutesToAdd, to: self) ?? self

        case .hour:
            let allowedRange = calendar.range(of: .hour, in: .day, for: self)!
            guard allowedRange.contains(value) else { return self }
            let currentHour = calendar.component(.hour, from: self)
            let hoursToAdd = value - currentHour
            return calendar.date(byAdding: .hour, value: hoursToAdd, to: self) ?? self

        case .day:
            let allowedRange = calendar.range(of: .day, in: .month, for: self)!
            guard allowedRange.contains(value) else { return self }
            let currentDay = calendar.component(.day, from: self)
            let daysToAdd = value - currentDay
            return calendar.date(byAdding: .day, value: daysToAdd, to: self) ?? self

        case .month:
            let allowedRange = calendar.range(of: .month, in: .year, for: self)!
            guard allowedRange.contains(value) else { return self }
            let currentMonth = calendar.component(.month, from: self)
            let monthsToAdd = value - currentMonth
            return calendar.date(byAdding: .month, value: monthsToAdd, to: self) ?? self

        case .year:
            guard value > 0 else { return self }
            let currentYear = calendar.component(.year, from: self)
            let yearsToAdd = value - currentYear
            return calendar.date(byAdding: .year, value: yearsToAdd, to: self) ?? self

        default:
            return calendar.date(bySetting: component, value: value, of: self) ?? self
        }
    }
    
    /**
     Get year from date. Calendar instance from `SMConfig.calendar`.
     
     ### Chinese description
     從日期物件取得年。日曆物件從 `SMConfig.calendar` 取得。
    
     ### Use example
     ```swift
     Date().year
     // 2020
     ```
     
     - Returns: Int
     */
    var year: Int {
        SMConfig.calendar.component(.year, from: self)
    }
    
    /**
     Get month from date. Calendar instance from `SMConfig.calendar`.
     
     ### Chinese description
     從日期物件取得月。日曆物件從 `SMConfig.calendar` 取得。
    
     ### Use example
     ```swift
     Date().month
     // 11
     ```
     
     Returns: Int
     */
    var month: Int {
        SMConfig.calendar.component(.month, from: self)
    }
    
    /**
     Get day from date. Calendar instance from `SMConfig.calendar`.
     
     ### Chinese description
     從日期物件取得日。日曆物件從 `SMConfig.calendar` 取得。
    
     ### Use example
     ```swift
     Date().day
     // 24
     ```
     
     Returns: Int
     */
    var day: Int {
        SMConfig.calendar.component(.day, from: self)
    }
    
    /**
     Get hour form date (24Hr). Calendar instance from `SMConfig.calendar`.
     
     ### Chinese description
     從日期物件取得小時(24小時制)。日曆物件從 `SMConfig.calendar` 取得。
    
     ### Use example
     ```swift
     Date().hour
     // 8
     ```
     
     Returns: Int
     */
    var hour: Int {
        SMConfig.calendar.component(.hour, from: self)
    }
    
    /**
     Get minute from date. Calendar instance from `SMConfig.calendar`.
     
     ### Chinese description
     從日期物件取得分鐘。日曆物件從 `SMConfig.calendar` 取得。
    
     ### Use example
     ```swift
     Date().minute
     // 11
     ```
     
     Returns: Int
     */
    var minute: Int {
        SMConfig.calendar.component(.minute, from: self)
    }
    
    /**
     Get second from date. Calendar instance from `SMConfig.calendar`.
     
     ### Chinese description
     從日期物件取得秒。日曆物件從 `SMConfig.calendar` 取得。
    
     ### Use example
     ```swift
     Date().second
     // 59
     ```
     
     Returns: Int
     */
    var second: Int {
        SMConfig.calendar.component(.second, from: self)
    }

    /**
     Data at the beginning of calendar component.
     cf. https://github.com/SwifterSwift/SwifterSwift/blob/master/Sources/SwifterSwift/Foundation/DateExtensions.swift
     
     ### Chinese description
     取得日曆組件起始時間
     
     ### Use example
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
            return SMConfig.calendar.startOfDay(for: self)
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
        return SMConfig.calendar.date(from: Calendar.current.dateComponents(components, from: self))
    }
    
    /**
     Date at the end of calendar component.
     cf. https://github.com/SwifterSwift/SwifterSwift/blob/master/Sources/SwifterSwift/Foundation/DateExtensions.swift
    
     ### Chinese description
     取得日曆組件的結尾期間
     
     ### Use example
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
        let calendar = SMConfig.calendar
        switch component {
        case .second:
            var date = added(by: 1, .second)
            date = calendar.date(from:
                calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date))!
            date.added(by: -1, .second)
            return date
            
        case .minute:
            var date = added(by: 1, .minute)
            let after = calendar.date(from:
                calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date))!
            date = after.added(by: -1, .second)
            return date
            
        case .hour:
            var date = added(by: 1, .hour)
            let after = calendar.date(from:
                calendar.dateComponents([.year, .month, .day, .hour], from: date))!
            date = after.added(by: -1, .second)
            return date
            
        case .day:
            var date = added(by: 1, .day)
            date = calendar.startOfDay(for: date)
            date.added(by: -1, .second)
            return date
            
        case .weekOfYear, .weekOfMonth:
            var date = self
            let beginningOfWeek = calendar.date(from:
                calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date))!
            date = beginningOfWeek.added(by: 7, .day).added(by: -1, .second)
            return date
            
        case .month:
            var date = added(by: 1, .month)
            let after = calendar.date(from:
                calendar.dateComponents([.year, .month], from: date))!
            date = after.added(by: -1, .second)
            return date
            
        case .year:
            var date = added(by: 1, .year)
            let after = calendar.date(from:
                calendar.dateComponents([.year], from: date))!
            date = after.added(by: -1, .second)
            return date
            
        default:
            return nil
        }
    }

    /**
     Check date is betwwen date1 and date2.

     ### Chinese description
     清除 position 以外的小數點

     ## Usage Example
     ```
     let num: Double = 6
     num.cleanDecimal(keepPosition: 2) // "6.00"
     num.cleanDecimal() // "6"
     ```
    */
    func isBetween(_ date1: Date, _ date2: Date) -> Bool {
        (min(date1, date2) ... max(date1, date2)).contains(self)
    }
    
    /// SwifterSwift: Check if date is in current given calendar component.
    ///
    ///     Date().isInCurrent(.day) -> true
    ///     Date().isInCurrent(.year) -> true
    ///
    /// - Parameter component: calendar component to check.
    /// - Returns: true if date is in current given calendar component.
    func isInCurrent(_ component: Calendar.Component) -> Bool {
        SMConfig.calendar.isDate(self, equalTo: Date(), toGranularity: component)
    }
    
    /// Check if date is in future.
    var isInFuture: Bool {
        return self > Date()
    }

    /// Check if date is in past.
    var isInPast: Bool {
        return self < Date()
    }

    /// Check if date is within today.
    var isInToday: Bool {
        SMConfig.calendar.isDateInToday(self)
    }

    /// Check if date is within yesterday.
    var isInYesterday: Bool {
        SMConfig.calendar.isDateInYesterday(self)
    }

    /// Check if date is within tomorrow.
    var isInTomorrow: Bool {
        SMConfig.calendar.isDateInTomorrow(self)
    }

    /// Check if date is within a weekend period.
    var isInWeekend: Bool {
        SMConfig.calendar.isDateInWeekend(self)
    }

    /// Check if date is within a weekday period.
    var isWorkday: Bool {
        !SMConfig.calendar.isDateInWeekend(self)
    }
}
