//
//  ThreadExtensions.swift
//  SwiftMinions
//
//  Created by Ohlulu on 2020/5/18.
//  Copyright © 2020 SwiftMinions. All rights reserved.
//

import Foundation

public extension Thread {
    static func main(_ closure: @escaping () -> Void) {
        if Thread.isMainThread {
            closure()
        } else {
            DispatchQueue.main.async {
                closure()
            }
        }
    }
}
