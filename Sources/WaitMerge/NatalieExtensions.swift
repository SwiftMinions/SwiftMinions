//
//  NatalieExtensions.swift
//  SwiftMinions
//
//  Created by Natalie Ng on 2020/2/28.
//  Copyright © 2020 SwiftMinions. All rights reserved.
//

import Foundation
import UIKit

extension UIView {

    func makeRoundedCorners(for corners: UIRectCorner, radius: Int = 10) {
        let maskPath = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        layer.mask = maskLayer
    }

    func rotate180(duration: TimeInterval, options: UIView.AnimationOptions) {
        UIView.animate(withDuration: duration, delay: 0, options: options, animations: {
            self.transform = self.transform.rotated(by: CGFloat.pi)
        }, completion: nil)
    }

    func showToast(message: String, duration: TimeInterval = 4.0) {

        let toastLabel = UILabel(frame:
            CGRect(x: self.frame.size.width/2 - 75,
                   y: self.frame.size.height-100, width: 150, height: 35))
        toastLabel.text = message
        toastLabel.font = UIFont.systemFont(ofSize: 12)
        toastLabel.textAlignment = .center

        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.alpha = 1.0

        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds  =  true

        self.addSubview(toastLabel)

        UIView.animate(withDuration: duration, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }


}


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

struct CustomCodingKey: CodingKey {
    var stringValue: String
    var intValue: Int?

    init(_ base: CodingKey) {
        self.init(stringValue: base.stringValue, intValue: base.intValue)
    }

    init(stringValue: String) {
        self.stringValue = stringValue
    }

    init(intValue: Int) {
        self.stringValue = "\(intValue)"
        self.intValue = intValue
    }

    init(stringValue: String, intValue: Int?) {
        self.stringValue = stringValue
        self.intValue = intValue
    }
}

extension JSONDecoder.KeyDecodingStrategy {

    /**
     Convert from the first letter of key to lower case before attempting to match a key with the one specified by each type. Mainly designed for coverting the upper camel case to lower camel case.

     ### Chinese description
     把所有的 key 的第一個字母轉成小寫

     ### Usage Example
     ```
     let decoder = JSONDecoder()
     decoder.keyDecodingStrategy = .convertFirstLetterToLowerCase
     ```
     For example, `UserName` becomes `userName`, `Latest_Price` becomes  `latest_Price`.
     */
    static var convertFirstLetterToLowerCase: JSONDecoder.KeyDecodingStrategy {
        return .custom { codingKeys in

            var key = CustomCodingKey(codingKeys.last!)

            if let firstChar = key.stringValue.first {
                let i = key.stringValue.startIndex
                key.stringValue.replaceSubrange(
                    i...i, with: String(firstChar).lowercased()
                )
            }
            return key
        }
    }


    /**
     Convert from the first letter of key to upper case before attempting to match a key with the one specified by each type. Mainly designed for coverting the lower camel case to upper camel case.

     ### Chinese description
     把所有的 key 的第一個字母轉成大寫

     ### Usage Example
     ```
     let decoder = JSONDecoder()
     decoder.keyDecodingStrategy = .convertFirstLetterToUpperCase
     ```
     For example, `userName` becomes `UserName`,`latest_price` becomes  `Latest_price`.
     */
    static var convertFirstLetterToUpperCase: JSONDecoder.KeyDecodingStrategy {
        return .custom { codingKeys in

            var key = CustomCodingKey(codingKeys.last!)

            if let firstChar = key.stringValue.first {
                let i = key.stringValue.startIndex
                key.stringValue.replaceSubrange(
                    i...i, with: String(firstChar).uppercased()
                )
            }
            return key
        }
    }


    /**
     Convert from the key to lower case before attempting to match a key with the one specified by each type.

     ### Chinese description
     把所有的 key 轉成小寫，做到類似無視大小寫的效果

     ### Usage Example
     ```
     let decoder = JSONDecoder()
     decoder.keyDecodingStrategy = .convertToLowerCase
     ```

     For example, `userName` becomes `username`, `First_Day` becomes  `first_day`.
     */
    static var convertToLowerCase: JSONDecoder.KeyDecodingStrategy {
        return .custom { codingKeys in

            var key = CustomCodingKey(codingKeys.last!)

            let start = key.stringValue.startIndex
            let end = key.stringValue.endIndex
            key.stringValue.replaceSubrange(
                start..<end, with: key.stringValue.lowercased()
            )

            return key
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
