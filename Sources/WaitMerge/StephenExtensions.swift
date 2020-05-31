//
//  StephenExtensions.swift
//  SwiftMinions
//
//  Created by stephen on 2020/3/4.
//  Copyright © 2020 SwiftMinions. All rights reserved.
//

#if os(Linux)

// Code specific to Linux

#elseif os(macOS)

// Code specific to macOS

#endif

#if canImport(UIKit)

import UIKit
import Foundation

#endif



extension String {

    /// Check if given string is a vaild URL format
    ///
    /// - Returns: Bool
    public func toURL() -> URL? {
        if let aURL = URL(string: self), UIApplication.shared.canOpenURL(aURL)  {
            return aURL
        }
        return nil
    }
    
    /// Is string a valid Email format ?
    ///
    /// - Returns: Bool
    public func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    /// HTML String
    public var toHTMLString: String {
        return getNSAttributedStringFromHTMLTag()?.string ?? ""
    }
    
    /// To new string date format
    ///
    /// - Parameter format: Date string format, default is `yyyy-MM-dd`
    public func toDateStringFormat(_ format: String = "yyyy-MM-dd") -> String? {
        if let date = self.toDate(format: format) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = format
            return dateFormatter.string(from: date)
        }
        return nil
    }
}

extension DispatchQueue {
    
    /// Dealy
    ///
    /// - Parameters:
    ///   - seconds: how much time to frozen the main thread
    ///   - completion: when forzen is finish
    static func delayMainThread(with seconds: Double,
                                 completion: @escaping () -> ()) {
        self.main.asyncAfter(deadline: .now() + seconds) {
            completion()
        }
    }
}

extension NSObject {
    
    /// Get string name of class
    ///
    /// How to usage
    ///
    /// ```swift
    ///
    /// MyClass.className   //=> "MyClass"
    ///
    /// ```
    public var className: String {
        return String(describing: self)
    }
}


/// Int 的擴充 方法 以及 參數
extension Int {
    
    /// Int to CGFloat
    public var toCGFloat: CGFloat { return CGFloat(self) }
}

extension UIApplication {
    
    /// 拿到目前應用程式當前的 ViewController，透過遞迴方式取得
    ///
    /// - parameter self: 默認是 rootViewController，然後一層層往上搜尋
    ///
    /// - Returns: 當前在最上層的 ViewController
    public func toppestViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController?
    {
        if let nav = base as? UINavigationController {
            return toppestViewController(base: nav.visibleViewController)
        }
        
        if let tab = base as? UITabBarController {
            let moreNavigationController = tab.moreNavigationController
            
            if let top = moreNavigationController.topViewController, top.view.window != nil {
                return toppestViewController(base: top)
            } else if let selected = tab.selectedViewController {
                return toppestViewController(base: selected)
            }
        }
        
        if let presented = base?.presentedViewController {
            return toppestViewController(base: presented)
        }
        return base
    }
    
    /// Detect whether application can open URL or not
    ///
    /// - Parameter url: url
    public func openURL(with url: String) {
    
        guard let aURL = URL(string: url) else {
            return
        }
        
        if !UIApplication.shared.canOpenURL(aURL) {
            return
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(aURL, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(aURL)
        }
    }
    
    /// Convert given view origin (x, y) to key window coordinate
    ///
    /// - Parameter sender: the view need to be convert
    /// - Returns: the view in window's coordinate
    public func toKeyWindowsCoordinate(sender: UIView) -> CGPoint? {
        var point: CGPoint?
        guard let window = UIApplication.shared.keyWindow else { return point }
        guard let superView = sender.superview else { return point }
        point = superView.convert(sender.frame.origin, to: window)
        return point
    }
    
    /// Get status bar
    public var statusBarView: UIView? {
        return self.value(forKey: "statusBar") as? UIView
    }
    
    /// Get status bar
    public var statusBarUIView: UIView? {
        if #available(iOS 13.0, *) {
            let tag = 1231415
            if let statusBar = self.keyWindow?.viewWithTag(tag) {
                return statusBar
            } else {
                let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
                statusBarView.tag = tag

                self.keyWindow?.addSubview(statusBarView)
                return statusBarView
            }
        } else {
            let statusBar = "statusBar"
            if self.responds(to: Selector((statusBar))) {
                return self.value(forKey: statusBar) as? UIView
            }
        }
        return nil
    }
}

extension Character {

    /// Is given character Emoji
    ///
    /// [參考](http://stackoverflow.com/questions/30757193/find-out-if-character-in-string-is-emoji)
    ///
    public var isEmoji: Bool {
        
        guard let scalarValue = String(self).unicodeScalars.first?.value else { return false }
        
        switch scalarValue {
        case
            0x3030, 0x00AE, 0x00A9,// Special Characters
            0x1D000...0x1F77F,     // Emoticons
            0x2100...0x27BF,       // Misc symbols and Dingbats
            0xFE00...0xFE0F,       // Variation Selectors
            0x1F900...0x1F9FF:     // Supplemental Symbols and Pictographs
            return true
        default:
            return false
        }
    }

    /// Is number ?
    public var isNumber: Bool {
        return Int(String(self)) != nil
    }
}
