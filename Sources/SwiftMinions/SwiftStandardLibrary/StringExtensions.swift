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
 * Regular expression
 */
public extension String {
    
    /**
     String is validate with regular expression.

     ## Chinese description
     字串是否匹配正規表示式。

     ## Use example
     ```swift
        let regex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,64}$"#
        let result = "minions@swiftminions.com".isValidate(withRegex: regex)
        // result -> true
     ```

     - Parameter withRegex: regular expression.
     - Returns: Bool.
    */
    func isValidate(withRegex regex: String) -> Bool {
        regularFirstMatch(withRegex: regex) != nil
    }
    
    /**
     First match with regular expression. Return nil if not found.

     ## Chinese description
     找到第一個匹配正規表示式的字串，如果找不到則回傳 nil。

     ## Use example
     ```swift
        let regex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,64}$"#
        let result = "minions@swiftminions.com".regularFirstMatch(withRegex: regex)
        // result-> "minions@swiftminions.com"
     ```

     - Parameters:
        - withRegex: regular expression.
        - options: NSRegularExpression.Options. (default is MinionsConfig.regexOptions)
     - Returns: String?
    */
    func regularFirstMatch(
        withRegex regexString: String,
        options: NSRegularExpression.Options = MinionsConfig.regexOptions)
        -> String?
    {
        do {
            let regExp: NSRegularExpression = try NSRegularExpression(pattern: regexString, options: options)
            guard let match = regExp.firstMatch(in: self, options: [], range: NSMakeRange(0, count)) else {
                return nil
            }
            return (self as NSString).substring(with: match.range)
        } catch {
            print("[ Error ] : \(error)")
            return nil
        }
    }
    
    /**
     Find all matches with regular expression. Return empty array if not found.

     ## Chinese description
     找到所有匹配正規表示式的字串，如果找不到則回傳空陣列。

     ## Use example
     ```swift
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,64}"
        let results = """
        minions@swiftminions.com
        minions2@sdf.com
        """.regularMatches(withRegex: regex)
        // results -> ["minions@swiftminions.com", "minions2@sdf.com"]
     ```

     - Parameters:
        - withRegex: regular expression.
        - options: NSRegularExpression.Options. (default is MinionsConfig.regexOptions)
     - Returns: [String]
    */
    func regularMatches(
        withRegex regex: String,
        options: NSRegularExpression.Options = MinionsConfig.regexOptions)
        -> [String]
    {
        do {
            let regExp: NSRegularExpression = try NSRegularExpression(pattern: regex, options: options)
            let matches = regExp.matches(in: self, options: [], range: NSMakeRange(0, count))
            var results = [String](repeating: "", count: matches.count)
            for (index, item) in matches.enumerated() {
                let string = (self as NSString).substring(with: item.range)
                results[index] = string
            }
            return results
        } catch {
            return []
        }
    }
    
    /**
     Replace string with regular expression and content. It will return a new string.

     ## Chinese description
     用正規表示式取代字串，將返回一個新的字串

     ## Use example
     ```swift
        let regex = #"(\()([0][0-9]{1,2})(\))([\d]{9})"#
        let phone = "(02)123456789"
        let newPhone = phone.regularReplace(withRegex: regex, content: "$2-$4")
        // newPhone -> 02-123456789
     ```

     - Parameters:
        - withRegex: regular expression.
        - options: NSRegularExpression.Options. (default is MinionsConfig.regexOptions)
     - Returns: [String]
    */
    func regularReplace(
        withRegex regex: String,
        content: String,
        options: NSRegularExpression.Options = MinionsConfig.regexOptions)
        -> String
    {
        do {
            let regExp = try NSRegularExpression(pattern: regex, options: options)
            let modified = regExp.stringByReplacingMatches(
                in: self,
                options: .reportProgress,
                range: NSRange(location: 0, length: count),
                withTemplate: content)
            return modified
        } catch {
            return self
        }
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
