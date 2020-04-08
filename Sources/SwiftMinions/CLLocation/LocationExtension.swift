//
//  LocationExtension.swift
//  SwiftMinions
//
//  Created by golface on 2020/4/8.
//  Copyright © 2020 SwiftMinions. All rights reserved.
//

import Foundation
import CoreLocation

public extension CLLocation {
    
    /**
     Calculate the interval between two location's timestamp. It's useful to calculate the location return from `locationManager(_ manager:, didUpdateLocations locations:)`.
    
     ## Chinese description
     計算兩個 Location 之間 timeStemp 的時間差，主要用在 `locationManager(_ manager:, didUpdateLocations locations:)` 更新位置時方便計算兩次更新的時間差。
    */
    func timeInterval(since lastLocation: CLLocation) -> TimeInterval {
        return self.timestamp.timeIntervalSince(lastLocation.timestamp)
    }
    
}
