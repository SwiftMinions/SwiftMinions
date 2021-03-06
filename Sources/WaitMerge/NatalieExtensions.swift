//
//  NatalieExtensions.swift
//  SwiftMinions
//
//  Created by Natalie Ng on 2020/2/28.
//  Copyright © 2020 SwiftMinions. All rights reserved.
//

import Foundation
import UIKit



extension UIDevice {

    private func modelIdentifier() -> String {
        if let simulatorModelIdentifier = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] { return simulatorModelIdentifier }
        var sysinfo = utsname()
        uname(&sysinfo) // ignore return value
        return String(bytes: Data(bytes: &sysinfo.machine, count: Int(_SYS_NAMELEN)), encoding: .ascii)!.trimmingCharacters(in: .controlCharacters)
    }

    var phoneType: String {
        let identifier = modelIdentifier()
        switch identifier {
        case "iPhone3,1", "iPhone3,2", "iPhone3,3": return "iPhone4"
        case "iPhone4,1":               return "iPhone4s"
        case "iPhone5,1", "iPhone5,2":  return "iPhone5"
        case "iPhone5,3", "iPhone5,4":  return "iPhone5C"
        case "iPhone6,1", "iPhone6,2":  return "iPhone5S"
        case "iPhone7,1":               return "iPhone6Plus"
        case "iPhone7,2":               return "iPhone6"
        case "iPhone8,1":               return "iPhone6S"
        case "iPhone8,2":               return "iPhone6SPlus"
        case "iPhone8,4":               return "iPhoneSE"
        case "iPhone9,1", "iPhone9,3":  return "iPhone7"
        case "iPhone9,2", "iPhone9,4":  return "iPhone7Plus"
        case "iPhone10,1", "iPhone10,4":return "iPhone8"
        case "iPhone10,2", "iPhone10,5":return "iPhone8Plus"
        case "iPhone10,3", "iPhone10,6":return "iPhoneX"
        case "iPhone11,2":              return "iPhoneXS"
        case "iPhone11,4", "iPhone11,6": return "iPhoneXSMax"
        case "iPhone11,8":              return "iPhoneXR"
        case "iPhone12,1":              return "iPhone11"
        case "iPhone12,3":              return "iPhone11Pro"
        case "iPhone12,5":              return "iPhone11ProMax"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad6,11", "iPad6,12":                    return "iPad 5"
        case "iPad7,5", "iPad7,6":                      return "iPad 6"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad6,3", "iPad6,4":                      return "iPad Pro(9.7-inch)"
        case "iPad6,7", "iPad6,8":                      return "iPad Pro(12.9-inch)"
        case "iPad7,1", "iPad7,2":                      return "iPad Pro(12.9-inch)2"
        case "iPad7,3", "iPad7,4":                      return "iPad Pro(10.5-inch)"
        case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":return "iPad Pro(11-inch)"
        case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":return "iPad Pro(12.9-inch)3"
        default: return identifier
        }
    }

}


extension UIStackView {

    func addBackgroundView(color: UIColor, cornerRadius: CGFloat? = nil) {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = color
        if let cornerRadius = cornerRadius {
            subView.layer.cornerRadius = cornerRadius
        }
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subView, at: 0)
    }

    func removeAllArrangedSubviews() {
        let removedSubviews = arrangedSubviews.reduce([]) { (sum, next) -> [UIView] in
            self.removeArrangedSubview(next)
            return sum + [next]
        }

        NSLayoutConstraint.deactivate(removedSubviews.flatMap({ $0.constraints }))

        removedSubviews.forEach({ $0.removeFromSuperview() })
    }
}
