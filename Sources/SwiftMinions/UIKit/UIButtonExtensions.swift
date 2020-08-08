//
//  UIButtonExtensions.swift
//  SwiftMinions
//
//  Created by Ohlulu on 2020/5/31.
//  Copyright © 2020 SwiftMinions. All rights reserved.
//

import UIKit

public extension UIButton {
    
    /// Helper property for logic.
    var isDisabled: Bool {
        get { !isEnabled }
        set { isEnabled = !newValue}
    }
}
