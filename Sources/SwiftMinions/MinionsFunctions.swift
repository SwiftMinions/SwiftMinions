//
//  MinionsFunctions.swift
//  SwiftMinions
//
//  Created by stephen on 2020/3/22.
//  Copyright © 2020 SwiftMinions. All rights reserved.
//

import Foundation

/**
 A convenience syntax for both success and fail unwrapped

 ## Chinese description
 一個方便的語法糖，讓你可以處理 unwrapped 成功根失敗的時候
 
 ## Use example
 ```swift
 let c: String? = "Ya"
 let b = ifLet(value: c,
               success: { value in "Success" + value },
               fail: { "Oh noooo!" })
 ```
 */
public func ifLet<T, U>(value: T?,
                 success thenFunc: (T) -> (U),
                 fail elseFunc: () -> (U)) -> U {
    switch value {
    case .some(let x): return thenFunc(x)
    case .none: return elseFunc()
    }
}
