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
    
    public static var font: UIFont = UIFont.systemFont(ofSize: 20)
    
    public static var calendar: Calendar = Calendar.current
    
    public static var decoder: JSONDecoder = JSONDecoder()
    
    // cf. https://stackoverflow.com/a/57169802
    static public var keyWindow: UIWindow? = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
    
    public struct AnimationDuration {
        
        public static var short: TimeInterval = 0.15
        
        public static var middle: TimeInterval = 0.25
        
        public static var long: TimeInterval = 0.35
    }
}
