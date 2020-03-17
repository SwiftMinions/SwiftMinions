//
//  ArrayExtensions.swift
//  SwiftMinions
//
//  Created by Hank Lu on 2020/3/12.
//  Copyright © 2020 SwiftMinions. All rights reserved.
//

import Foundation

public extension Array {
    
    /**
     Shift elements in array by index
     ### Chinese description
     將陣列裡的元素移動到 後綴(正數) or 前綴(負數)
     
     ## Usage Example: ##
     ```
     var array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
     
     // 移到後綴
     array = array.shift(withDistance: 3)
     print(array) // prints: [4, 5, 6, 7, 8, 9, 10, 1, 2, 3]
     
     // 移到前綴
     array = array.shift(withDistance: -3)
     print(array) // prints: [8, 9, 10, 1, 2, 3, 4, 5, 6, 7]
     ```
     - Parameter distance: 從左邊開始數, 要移動幾個目標
     - Returns: 已將目標移動到後綴或前綴的陣列.
     */
    func shift(with distance: Int = 1) -> Array<Element> {
        let offsetIndex = distance >= 0 ?
            self.index(startIndex, offsetBy: distance, limitedBy: endIndex) :
            self.index(endIndex, offsetBy: distance, limitedBy: startIndex)
        
        guard let index = offsetIndex else { return self }
        return Array(self[index ..< endIndex] + self[startIndex ..< index])
    }
    
    /**
     Shift elements in array by index
     ### Chinese description
     將陣列裡的元素移動到 後綴(正數) or 前綴(負數), 無回傳值
     
     ## Usage Example: ##
     ```
     var array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
     // 移到後綴
     array.shift(withDistance: 3)
     print(array) // prints: [4, 5, 6, 7, 8, 9, 10, 1, 2, 3]
     
     // 移到前綴
     array.shiftInPlace(withDistance: -2)
     print(array) // prints: [9, 10, 1, 2, 3, 4, 5, 6, 7, 8]
     ```
     - Parameter distance: 正數由陣列first, 負數由陣列last, 從左開始數要移動幾個目標
     */
    mutating func shiftInPlace(with distance: Int = 1) {
        self = shift(with: distance)
    }
    
    
    /**
     ### Chinese description
     將陣列裡的元素移動到 指定的位子
     
     ## Usage Example: ##
     ````
     var array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
     array = array.rearrange(fromIndex: 3, toIndex: 0)
     print(array) // prints: [4, 1, 2, 3, 5, 6, 7, 8, 9, 10]
     ````
     - Parameter fromIndex: 要移動的目標.
     - Parameter toIndex: 要移動的目的地.
     - Returns: 已將目標移動完的陣列.
     */
    func rearrange<T>(fromIndex: Int, toIndex: Int) -> Array<T> {
        var arr = self
        let element = arr.remove(at: fromIndex)
        arr.insert(element, at: toIndex)
        return arr as! Array<T>
    }
}
