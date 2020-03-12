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
     ### Chinese description
     位移陣列內的元素
     
     ## Usage Example: ##
     ```
     var array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
     
     array = array.shift(withDistance: 3)
     ```
     print(array) // prints: [4, 5, 6, 7, 8, 9, 10, 1, 2, 3]
     */
    func shift(withDistance distance: Int = 1) -> Array<Element> {
        let offsetIndex = distance >= 0 ?
            self.index(startIndex, offsetBy: distance, limitedBy: endIndex) :
            self.index(endIndex, offsetBy: distance, limitedBy: startIndex)
        
        guard let index = offsetIndex else { return self }
        return Array(self[index ..< endIndex] + self[startIndex ..< index])
    }
    
    /**
     ### Chinese description
     位移陣列內的元素
     
     ## Usage Example: ##
     ```
     var array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
     array = array.shiftInPlace(withDistance: -2)
     print(array) // prints: [9, 10, 1, 2, 3, 4, 5, 6, 7, 8]
     ```
     */
    mutating func shiftInPlace(withDistance distance: Int = 1) {
        self = shift(withDistance: distance)
    }
    
    
    /**
     ### Chinese description
     移動陣列內的元素
     
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
    func rearrange<T>(fromIndex: Int, toIndex: Int) -> Array<T>{
        var arr = self
        let element = arr.remove(at: fromIndex)
        arr.insert(element, at: toIndex)
        return arr as! Array<T>
    }
}
