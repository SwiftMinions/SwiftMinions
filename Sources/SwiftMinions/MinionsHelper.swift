//
//  MinionsHelper.swift
//  SwiftMinions
//
//  Created by stephen on 2020/3/22.
//  Copyright © 2020 SwiftMinions. All rights reserved.
//

import UIKit

open class SMHelper {
    
    /**
     Get value form plist
     
     ## Chinese description
     從 plist 取值
     
     ## Use example
     ```swift
     SMHelper.getValueFromPlist(key: "Key")
     ```
     */
    public static func getValueFromPlist(key: String) -> Any? {
        return Bundle.main.object(forInfoDictionaryKey: key)
    }
    
    /**
     Get application version
     
     ## Chinese description
     拿到 app 的版本號
     
     ## Use example
     ```swift
     SMHelper.appVersion
     ```
     */
    public static let appVersion: String? = getValueFromPlist(key: "CFBundleShortVersionString") as? String
    
    /**
     Get application build number
     
     ## Chinese description
     拿到 app 的 build 版本號
     
     ## Use example
     ```swift
     SMHelper.appBuildNumber
     ```
     */
     public static let appBuildNumber: String? = getValueFromPlist(key: "CFBundleVersion") as? String
         
    /**
     Get application bundle identifier
     
     ## Chinese description
     拿到 app 的 build identifier
     
     ## Use example
     ```swift
     SMHelper.appBundleID
     ```
     */
     public static let appBundleID: String? = Bundle.main.bundleIdentifier
     
    /**
     An alphanumeric string that uniquely identifies a device to the app’s vendor.

     ## Chinese description
     拿到當前 App 的 IDFV
     
     ## Use example
     ```swift
     SMHelper.deviceIDFV
     ```
     */
     public static let deviceIDFV: String? = UIDevice.current.identifierForVendor?.uuidString
}


