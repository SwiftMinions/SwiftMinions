//
//  IndexPathExtension_Test.swift
//  SwiftMinions
//
//  Created by Ohlulu on 2020/8/6.
//  Copyright © 2020 SwiftMinions. All rights reserved.
//

import XCTest
@testable import SwiftMinions

class IndexPathExtension_Test: XCTestCase {
    
    func test_IndexPath_Add() {
        let indexPath = IndexPath(row: 0, section: 0)
        let newIndexPath1 = indexPath.addRow(1)
        XCTAssertEqual(newIndexPath1, IndexPath(row: 1, section: 0))
        let newIndexPath2 = indexPath.addSection(1)
        XCTAssertEqual(newIndexPath2, IndexPath(row: 0, section: 1))
    }
    
    func test_IndexPath_Set() {
        let indexPath = IndexPath(row: 0, section: 0)
        let newIndexPath1 = indexPath.setRow(1)
        XCTAssertEqual(newIndexPath1, IndexPath(row: 1, section: 0))
        let newIndexPath2 = indexPath.setSection(1)
        XCTAssertEqual(newIndexPath2, IndexPath(row: 0, section: 1))
    }
}
