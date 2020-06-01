//
//  StephenObjects.swift
//  SwiftMinions
//
//  Created by stephen on 2020/3/4.
//  Copyright © 2020 SwiftMinions. All rights reserved.
//

import UIKit
import Foundation




/// Provide offen usage relevant screen functions
public struct ALScreen {
    
    /// 取得當前手機螢幕的大小
    ///
    ///  Example 1
    ///
    /// ```swift
    /// if ALScreen.inch.is3_5 {
    ///        code here ......
    /// }
    /// ```
    public struct inch {
        public static let is3_5
            = UIDevice.current.userInterfaceIdiom == .phone && maxLength < 568.0
        public static let is4_0
            = UIDevice.current.userInterfaceIdiom == .phone && maxLength == 568.0
        public static let is4_7
            = UIDevice.current.userInterfaceIdiom == .phone && maxLength == 667.0
        public static let is5_5
            = UIDevice.current.userInterfaceIdiom == .phone && maxLength == 736.0
        public static let iPad
            = UIDevice.current.userInterfaceIdiom == .pad && maxLength == 1024.0
    }
    
    /// 取得當前轉向 nice to meet chris
    public static var orientation: UIInterfaceOrientation {
        return UIApplication.shared.statusBarOrientation
    }
    
    /// 當前螢幕的 bounds
    public static let bounds = UIScreen.main.bounds
    
    /// 當前螢幕的**寬度**，會隨著螢幕旋轉方向變化
    public static var width: CGFloat {
        return orientation.isPortrait ? minLength : maxLength
    }
    
    /// 當前螢幕的**高度**，會隨著螢幕旋轉方向變化
    public static var height: CGFloat {
        return orientation.isPortrait ? maxLength : minLength
    }
    
    /// 當前螢幕的**中心點座標**，會隨著螢幕旋轉方向變化
    public static var center: CGPoint {
        let xAxis  = width  / 2
        let yAxis  = height / 2
        return CGPoint(x: xAxis, y: yAxis)
    }
    
    /// 當前螢幕的 Size
    public static var size: CGSize {
        return bounds.size
    }
    
    /// 當前螢幕最長的長度
    public static let maxLength = max(size.height, size.width)
    
    /// 當前螢幕最短的長度
    public static let minLength = min(size.height, size.width)
    
    /// 當前螢幕的 Frame
    public static let frame = CGRect(x: 0, y: 0, width: width, height: height)
    
    /// Navigation Bar 的高度
    public static let navigationBar : CGFloat = 44.0
    
    /// Tool Bar 的高度
    public static let toolbar : CGFloat = 44.0
    
    /// iPhone 的 notch 高度
    @available(iOS 11.0, *)
    public static let notchHeight: CGFloat = UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0
    
    /// Is this device has notch or not
    @available(iOS 11.0, *)
    public static let hasNotch: Bool = (notchHeight != 0)

    /// The width of saft-area
    public static var saftAreaContentWidth: CGFloat {
        if #available(iOS 11.0, *) {
            if self.maxLength <= 736.0 {
                return self.orientation.isPortrait ? self.minLength : self.maxLength
            } else {
                return self.orientation.isPortrait ? self.minLength : self.maxLength - 145
            }
        } else {
            return self.width
        }
    }
    
    /// The height of saft area
    public static var saftAreaContentHeight: CGFloat {
        return self.height
    }
}

