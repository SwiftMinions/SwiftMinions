//
//  OhluluExtensions.swift
//  SwiftMinions
//
//  Created by HIS HSIANG JIH on 2020/2/23.
//  Copyright © 2020 SwiftMinions. All rights reserved.
//

import UIKit

public extension Date {
    
    /**
     Date to String
     ### Usage Example: ###
     ```swift
     Date().toString()
     // print 2020-11-24 05:30:30
     
     Date().toString(format: "yyyy-MM-dd")
     // print 2020-11-24
     
     ```
     - Parameter format: date format
     */
    func toString(format: String = "yyyy-MM-dd HH:mm:ss") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    
    /**
     Date add value with component
     add from
     - Parameter component: Calendar.Component
     - Parameter value: modify value
     */
    @discardableResult
    func add(_ component: Calendar.Component, value: Int) -> Date {
        return Calendar.current.date(byAdding: component, value: value, to: self)!
    }
    
    // MARK: - component
    var year: Int {
        get {
            return Calendar.current.component(.year, from: self)
        }
        set {
            guard newValue > 0 else { return }
            let currentYear = Calendar.current.component(.year, from: self)
            let yearsToAdd = newValue - currentYear
            if let date = Calendar.current.date(byAdding: .year, value: yearsToAdd, to: self) {
                self = date
            }
        }
    }
    
    var month: Int {
        get {
            return Calendar.current.component(.month, from: self)
        }
        set {
            let allowedRange = Calendar.current.range(of: .month, in: .year, for: self)!
            guard allowedRange.contains(newValue) else { return }
            
            let currentMonth = Calendar.current.component(.month, from: self)
            let monthsToAdd = newValue - currentMonth
            if let date = Calendar.current.date(byAdding: .month, value: monthsToAdd, to: self) {
                self = date
            }
        }
    }
    
    var day: Int {
        get {
            return Calendar.current.component(.day, from: self)
        }
        set {
            let allowedRange = Calendar.current.range(of: .day, in: .month, for: self)!
            guard allowedRange.contains(newValue) else { return }
            
            let currentDay = Calendar.current.component(.day, from: self)
            let daysToAdd = newValue - currentDay
            if let date = Calendar.current.date(byAdding: .day, value: daysToAdd, to: self) {
                self = date
            }
        }
    }
    
    var hour: Int {
        get {
            return Calendar.current.component(.hour, from: self)
        }
        set {
            let allowedRange = Calendar.current.range(of: .hour, in: .day, for: self)!
            guard allowedRange.contains(newValue) else { return }
            
            let currentHour = Calendar.current.component(.hour, from: self)
            let hoursToAdd = newValue - currentHour
            if let date = Calendar.current.date(byAdding: .hour, value: hoursToAdd, to: self) {
                self = date
            }
        }
    }
    
    var minute: Int {
        get {
            return Calendar.current.component(.minute, from: self)
        }
        set {
            let allowedRange = Calendar.current.range(of: .minute, in: .hour, for: self)!
            guard allowedRange.contains(newValue) else { return }
            
            let currentMinutes = Calendar.current.component(.minute, from: self)
            let minutesToAdd = newValue - currentMinutes
            if let date = Calendar.current.date(byAdding: .minute, value: minutesToAdd, to: self) {
                self = date
            }
        }
    }
    
    var second: Int {
        get {
            return Calendar.current.component(.second, from: self)
        }
        set {
            let allowedRange = Calendar.current.range(of: .second, in: .minute, for: self)!
            guard allowedRange.contains(newValue) else { return }
            
            let currentSeconds = Calendar.current.component(.second, from: self)
            let secondsToAdd = newValue - currentSeconds
            if let date = Calendar.current.date(byAdding: .second, value: secondsToAdd, to: self) {
                self = date
            }
        }
    }
    
    /// SwifterSwift: Data at the beginning of calendar component.
    ///
    ///     let date = Date() // "Jan 12, 2017, 7:14 PM"
    ///     let date2 = date.beginning(of: .hour) // "Jan 12, 2017, 7:00 PM"
    ///     let date3 = date.beginning(of: .month) // "Jan 1, 2017, 12:00 AM"
    ///     let date4 = date.beginning(of: .year) // "Jan 1, 2017, 12:00 AM"
    ///
    /// - Parameter component: calendar component to get date at the beginning of.
    /// - Returns: date at the beginning of calendar component (if applicable).
    func beginning(of component: Calendar.Component) -> Date? {
        if component == .day {
            return Calendar.current.startOfDay(for: self)
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
        return Calendar.current.date(from: Calendar.current.dateComponents(components, from: self))
    }
    
    /// SwifterSwift: Date at the end of calendar component.
    ///
    ///     let date = Date() // "Jan 12, 2017, 7:27 PM"
    ///     let date2 = date.end(of: .day) // "Jan 12, 2017, 11:59 PM"
    ///     let date3 = date.end(of: .month) // "Jan 31, 2017, 11:59 PM"
    ///     let date4 = date.end(of: .year) // "Dec 31, 2017, 11:59 PM"
    ///
    /// - Parameter component: calendar component to get date at the end of.
    /// - Returns: date at the end of calendar component (if applicable).
    func end(of component: Calendar.Component) -> Date? {
        let calendar = Calendar.current
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

public extension TimeInterval {
    
    /**
     Date to String
     ### Usage Example: ###
     ```swift
     TimeInterval().dateSince1970
     ```
     - Parameter format: date format
     */
    var dateSince1970: Date{
        return Date(timeIntervalSince1970: self)
    }
    
    /**
     TimeInterval to String
     ### Usage Example: ###
     ```swift
     TimeInterval().toString()
     // 2020-11-24 05:30:30
     
     TimeInterval().toString(format: "yyyy-MM-dd")
     // 2020-11-24
     
     ```
     - Parameter format: date format
     */
    func toString(format: String = "yyyy-MM-dd HH:mm:ss") -> String {
        return dateSince1970.toString(format: format)
    }
}

public extension Int {
    
    var toDouble: Double {
        return Double(self)
    }
    
    var toCgfloat: CGFloat {
        return CGFloat(self)
    }
    
    var toFloat: Float {
        return Float(self)
    }
}

public extension Double {
    
    var toInt: Int {
        return Int(self)
    }
    
    var toCgfloat: CGFloat {
        return CGFloat(self)
    }
    
    var toFloat: Float {
        return Float(self)
    }
}

public extension CGFloat {
    
    var toInt: Int {
        return Int(self)
    }
    
    var toDouble: Double {
        return Double(self)
    }
    
    var toFloat: Float {
        return Float(self)
    }
}

public extension Float {
    
    var toInt: Int {
        return Int(self)
    }
    
    var toDouble: Double {
        return Double(self)
    }
    
    var toCgfloat: CGFloat {
        return CGFloat(self)
    }
}

/// Initialize
public extension UIEdgeInsets {
    
    /// Convenience initialize
    init(edge: CGFloat) {
        self.init(top: edge, left: edge, bottom: edge, right: edge)
    }
    
    /// Convenience initialize
    init(top: CGFloat? = 0, left: CGFloat? = 0, bottom: CGFloat? = 0, right: CGFloat? = 0, default defaultValue: CGFloat = 0) {
        self.init(top: top ?? defaultValue, left: left ?? defaultValue, bottom: bottom ?? defaultValue, right: right ?? defaultValue)
    }
    
    /// Convenience initialize
    init(horizontalEdge edge: CGFloat) {
        self.init(top: 0, left: edge, bottom: 0, right: edge)
    }
    
    /// Convenience initialize
    init(verticalEdge edge: CGFloat) {
        self.init(top: edge, left: 0, bottom: edge, right: 0)
    }
    
    /// Convenience initialize
    init(horizontalEdge hEdge: CGFloat, verticalEdge vEdge: CGFloat) {
        self.init(top: vEdge, left: hEdge, bottom: vEdge, right: hEdge)
    }
    
    /**
     Get veritical edge
     ### Usage Example: ###
     ````
     let inset = UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 8)
     inset.vertical
     // 20
     ````
     */
    var vertical: CGFloat {
        return top + bottom
    }
    
    /**
     Get horizontal edge
     ### Usage Example: ###
     ````
     let inset = UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 8)
     inset.horizontal
     // 16
     ````
     */
    var horizontal: CGFloat {
        return left + right
    }
}

public extension String {
    
    var int: Int? {
        return Int(self)
    }
    
    var intValue: Int {
        return Int(self) ?? 0
    }
    
    func base64(encoding: String.Encoding = .utf8) -> String? {
        guard let decodeData = Data(base64Encoded: self, options: .ignoreUnknownCharacters) else {
            return nil
        }
        guard let decodeString = String(data: decodeData, encoding: encoding) else {
            return nil
        }
        return decodeString
    }
}

public struct SafeRangeable<Base> {
    
    let base: Base
    init(_ base: Base) {
        self.base = base
    }
}

public extension String {
    var safe: SafeRangeable<Self> {
        return .init(self)
    }
}

extension SafeRangeable where Base == String {
    subscript(_ bounds: CountableClosedRange<Int>) -> String {
        if bounds.lowerBound >= base.count || bounds.upperBound < 0 {
            return ""
        }
        let lowerBound = Swift.max(bounds.lowerBound, 0)
        let start = base.index(base.startIndex, offsetBy: lowerBound)
        let upperBound = Swift.min(bounds.upperBound, base.count-1)
        let end = base.index(base.startIndex, offsetBy: upperBound)
        return String(base[start...end])
    }
    
    subscript(_ bounds: CountableRange<Int>) -> String {
        if bounds.lowerBound >= base.count || bounds.upperBound < 0 {
            return ""
        }
        let lowerBound = Swift.max(bounds.lowerBound, 0)
        let start = base.index(base.startIndex, offsetBy: lowerBound)
        let upperBound = Swift.min(bounds.upperBound, base.count)
        let end = base.index(base.startIndex, offsetBy: upperBound)
        return String(base[start..<end])
    }
}

public struct SafeCollectionable<Base> where Base: Collection {
    
    let base: Base
    init(_ base: Base) {
        self.base = base
    }
    
    public subscript(_ index: Base.Index) -> Base.Element? {
        guard base.indices.contains(index) else { return nil }
        return base[index]
    }
}

public extension Collection {
    var safe: SafeCollectionable<Self> {
        return .init(self)
    }
}

public extension Collection {
    func group(by size: Int) -> [[Element]]? {
        // Inspired by: https://lodash.com/docs/4.17.4#chunk
        guard size > 0, !isEmpty else { return nil }
        var start = startIndex
        var slices = [[Element]]()
        while start != endIndex {
            let end = index(start, offsetBy: size, limitedBy: endIndex) ?? endIndex
            slices.append(Array(self[start..<end]))
            start = end
        }
        return slices
    }
    
    func group<K: Hashable>(by keyForValue: (Element) -> K) -> [K: [Element]] {
        var group = [K: [Element]]()
        for value in self {
            let key = keyForValue(value)
            group[key] = (group[key] ?? []) + [value]
            
        }
        return group
    }
}
