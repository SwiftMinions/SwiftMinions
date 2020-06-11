//
//  CollectionExtensions.swift
//  SwiftMinions
//
//  Created by Ohlulu on 2020/4/4.
//  Copyright © 2020 SwiftMinions. All rights reserved.
//

import Foundation

/**
 Wrapper for SafeCollectionable compatible types. This type provides an extension point for connivence methods in SafeCollectionable.
 */
public struct SafeCollectionable<Base> where Base: Collection {
    let base: Base
    init(_ base: Base) {
        self.base = base
    }
}

public extension Collection {
    
    /// Gets a namespace holder for SafeCollectionable compatible types.
    var safe: SafeCollectionable<Self> {
        return .init(self)
    }
}

public extension SafeCollectionable {

    /**
     It safe-able to get collection element.

     ### Chinese description
     安全的取得 collection 中的元素

     ### Use example
     ```swift
        [1, 2, 3].safe[0] // 1
        [1, 2, 3].safe[3] // nil
     ```

     - Returns: Opeional<Collection.Element>
    */
    subscript(_ index: Base.Index) -> Base.Element? {
        guard base.indices.contains(index) else { return nil }
        return base[index]
    }
}

public extension Collection {
    
    /**
     Creates an array of elements split into groups the length of size. If array can't be split evenly, the final chunk will be the remaining elements.
     [cf.] https://lodash.com/docs/4.17.4#chunk
     ### Chinese description
     創建一個元素陣列，將其分為大小長度的二維陣列。 如果無法均勻分割陣列，則最後一塊將是剩餘的元素。
    
     ### Use example
     ```swift
        ['a', 'b', 'c', 'd'].chunk(by: 2)
        // [['a', 'b'], ['c', 'd']]
         
        ['a', 'b', 'c', 'd'].chunk(by: 3)
        // [['a', 'b', 'c'], ['d']]
     ```
     - Parameter size: The length of each chunk
     - Returns: SafeCollectionable<Self>
    */
    func chunk(by size: Int) -> [[Element]]? {
        
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
    
    /**
     Creates a dictionary with key is hash. (like SQL: GROUP BY)
     ### Chinese description
     創建由雜湊鍵拆分的字典。
    
     ### Use example
     ```swift
        [1585701811, 1585788211, 1585961011].group {
            return Double($0).dateSince1970.toString(format: "yyyy/MM/dd")
        }
        // ["2020/04/01": 1585701811, "2020/04/02": 1585788211, "2020/04/04": 1585961011]
     ```
     - Parameter : A closure to create hash key.
     - Returns: A dictionary.
    */
    func group<K: Hashable>(by keyForValue: (Element) -> K) -> [K: [Element]] {
        var group = [K: [Element]]()
        for value in self {
            let key = keyForValue(value)
            group[key] = (group[key] ?? []) + [value]
        }
        return group
    }
}

// MARK: - Methods (Integer)
public extension Collection where Element == IntegerLiteralType, Index == Int {

    /**
     Average of all elements in array.
     [cf.] https://github.com/SwifterSwift/SwifterSwift/blob/master/Sources/SwifterSwift/SwiftStdlib/CollectionExtensions.swift
     ### Chinese description
     陣列中所有元素的平均值。
    
     ### Use example
     ```swift
        [80, 11, 24].average()
        // 38.333333
     ```
     - Returns: the average of the array's elements.
    */
    func average() -> Double {
        return isEmpty ? 0 : Double(reduce(0, +)) / Double(count)
    }
}

// MARK: - Methods (FloatingPoint)
public extension Collection where Element: FloatingPoint {

    /**
     Average of all elements in array.
     [cf.] https://github.com/SwifterSwift/SwifterSwift/blob/master/Sources/SwifterSwift/SwiftStdlib/CollectionExtensions.swift
     ### Chinese description
     陣列中所有元素的平均值。
    
     ### Use example
     ```swift
        [1.2, 2.3, 4.5, 3.4, 4.5].average()
        // 3.18
     ```
     - Returns: the average of the array's elements.
    */
    func average() -> Element {
        return isEmpty ? 0 : reduce(0, {$0 + $1}) / Element(count)
    }
}
