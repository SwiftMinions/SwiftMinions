//
//  IndexPathExtensions.swift
//  SwiftMinions
//
//  Created by Ohlulu on 2020/8/6.
//  Copyright © 2020 SwiftMinions. All rights reserved.
//

import Foundation

public extension IndexPath {
    
    func addRow(_ value: Int) -> IndexPath {
        IndexPath(row: row + value, section: section)
    }
    
    func addSection(_ value: Int) -> IndexPath {
        IndexPath(row: row, section: section + value)
    }
    
    func setRow(_ value: Int) -> IndexPath {
        IndexPath(row: value, section: section)
    }
    
    func setSection(_ value: Int) -> IndexPath {
        IndexPath(row: row, section: value)
    }
}
