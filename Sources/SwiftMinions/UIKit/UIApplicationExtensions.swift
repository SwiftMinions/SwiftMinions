//
//  UIApplicationExtensions.swift
//  SwiftMinions
//
//  Created by Ohlulu on 2020/5/31.
//  Copyright © 2020 SwiftMinions. All rights reserved.
//

import UIKit

public extension UIApplication {
    
    /// Detect whether application can open URL or not
    ///
    /// - Parameter urlString: url string
    static func open(_ urlString: String) {
        guard let aURL = URL(string: urlString) else {
            return
        }
        
        open(aURL)
    }
    
    /// Detect whether application can open URL or not
    ///
    /// - Parameter url: url
    static func open(_ url: URL) {
        if !UIApplication.shared.canOpenURL(url) {
            return
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}
