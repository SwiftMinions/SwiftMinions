//
//  MinionsConfig.swift
//  SwiftMinions
//
//  Created by twStephen on 2020/3/6.
//  Copyright © 2020 SwiftMinions. All rights reserved.
//

import UIKit


/// This config is for entire minions project.
/// Anything you need to customize will go from here
open class MinionsConfig {
    
    static public var font: UIFont = UIFont.systemFont(ofSize: 20)
    
    static public var calendar: Calendar = Calendar.current
    
    static public var decoder: JSONDecoder = JSONDecoder()
}
