//
//  StringExtensions.swift
//  SwiftMinions
//
//  Created by twStephen on 2020/3/6.
//  Copyright © 2020 SwiftMinions. All rights reserved.
//

import UIKit

public extension String {

    /**
     Get string size via given UIFont. Return CGSize includes height and width.
     
     ## Chinese description
     取得當前 String 的大小，回傳 CGSize 格式，可以再透過 CGSize 拿到 height 跟 width
    
     ## Use example
     ```swift
     
     let text = "Some text"
     let font = UIFont.systemFont(ofSize: 20)
     let size = text.size(fontSize: font)   /// {w 87.334 h 23.867}
     size.height                            /// 23.8671875
     size.width                             /// 87.333984375
     
     ```
     Parameter font: UIFont class
     
     Returns: CGSize
     */
    func size(fontSize font: UIFont) -> CGSize {
        return self.size(withAttributes: [NSAttributedString.Key.font: font])
    }
}

public extension String {
    
    /**
     Calculate the size of string in a max rect.
     
     ## Chinese description
     計算 String 在一個方框下的大小.
    
     ## Use example
     ```swift
     
     let size: CGSize = "tttttttttttttttttt".calculateRectSize(font: UIFont.systemFont(ofSize: 20), maxSize: CGSize(width: 100, height: 200))
     print(size)

     ```
     Parameter font: UIFont class
     Parameter maxSize: CGSize class

     Returns: CGSize
     */
    func calculateRectSize(font: UIFont, maxSize: CGSize) -> CGSize {
        let attributedString = NSAttributedString.init(string: self, attributes: [NSAttributedString.Key.font:font])
        let rect = attributedString.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, context: nil)
        let size = CGSize(width:rect.size.width, height : rect.size.height)
        return size
    }
    
    var toInt: Int? {
        return Int(self)
    }
    
    var toIntValue: Int {
        return Int(self) ?? 0
    }
    
    /**
     String to base64.

     ## Chinese description
     將字串編碼成 base64

     ## Use example
     ```swift
        "SwiftMinions".base64Encoded()
        // "U3dpZnRNaW5pb25z"
     ```

     - Parameters:
        - encoding: String.Encoding.
     - Returns: A base64Encoded string.
    */
    func base64Encoded(encoding: String.Encoding = .utf8) -> String? {
        let plainData = data(using: .utf8)
        return plainData?.base64EncodedString()
    }
    
    /**
     Base64 to string.

     ## Chinese description
     將字串用 base64 解碼

     ## Use example
     ```swift
        "U3dpZnRNaW5pb25z".base64Encoded()
        // "SwiftMinions"
     ```

     - Parameters:
        - decoding: String.Dncoding. (default .utf8)
        - options: Data.Base64DecodingOptions. (default .ignoreUnknownCharacters)
     - Returns: A string decoding with base64.
    */
    func base64Decoded(decoding: String.Encoding = .utf8,
                       options: Data.Base64DecodingOptions = .ignoreUnknownCharacters) -> String? {
        let remainder = count % 4

        var padding = ""
        if remainder > 0 {
            padding = String(repeating: "=", count: 4 - remainder)
        }

        guard let data = Data(base64Encoded: self + padding,
                              options: options) else { return nil }

        return String(data: data, encoding: decoding)
    }
}

/**
 Wrapper for SafeRangeable compatible types. This type provides an extension point for connivence methods in SafeRangeable.
*/
public struct SafeRangeable<Base> where Base: Collection {
    
    let base: Base
    init(_ base: Base) {
        self.base = base
    }
}

public extension String {
    /// Gets a namespace holder for SafeRangeable compatible types.
    var safe: SafeRangeable<Self> {
        return .init(self)
    }
}

extension SafeRangeable where Base == String {
    
    /**
     It safe-able to get collection element.

     ## Chinese description
     安全的取得 collection 中的元素

     ## Use example
     ```swift
        "Swift Minions".safe[0..<5] // "Swift"
        "Swift Minions".safe[6..<13] // "Minions"
        "Swift Minions".safe[6..<16] // "Minions"
        "Swift Minions".safe[12..<16] // "s"
        "Swift Minions".safe[14..<16] // ""

     ```

     - Returns: String
    */
    subscript(_ bounds: CountableClosedRange<Int>) -> String {
        if bounds.lowerBound >= base.count || bounds.upperBound < 0 {
            return ""
        }
        let lowerBound = Swift.max(bounds.lowerBound, 0)
        let start = base.index(base.startIndex, offsetBy: lowerBound)
        let upperBound = Swift.min(bounds.upperBound, base.count-1)
        let end = base.index(base.startIndex, offsetBy: upperBound)
        return String(base[start...end])
    }
    
    /**
     It safe-able to get collection element.

     ## Chinese description
     安全的取得 collection 中的元素

     ## Use example
     ```swift
        "Swift Minions".safe[0...4] // "Swift"
        "Swift Minions".safe[6...12] // "Minions"
        "Swift Minions".safe[6...15] // "Minions"
        "Swift Minions".safe[12...15] // "s"
        "Swift Minions".safe[14...15] // ""

     ```

     - Returns: String
    */
    subscript(_ bounds: CountableRange<Int>) -> String {
        if bounds.lowerBound >= base.count || bounds.upperBound < 0 {
            return ""
        }
        let lowerBound = Swift.max(bounds.lowerBound, 0)
        let start = base.index(base.startIndex, offsetBy: lowerBound)
        let upperBound = Swift.min(bounds.upperBound, base.count)
        let end = base.index(base.startIndex, offsetBy: upperBound)
        return String(base[start..<end])
    }
}
