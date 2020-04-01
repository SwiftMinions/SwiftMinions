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
