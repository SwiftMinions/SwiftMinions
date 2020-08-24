//
//  StringExtensions.swift
//  SwiftMinions
//
//  Created by twStephen on 2020/3/6.
//  Copyright © 2020 SwiftMinions. All rights reserved.
//

import UIKit
import CryptoKit

// MARK: - Helper method

public extension String {
    
    /// Helper property for logic.
    var isNotEmpty: Bool { !isEmpty }
    
    /**
     Convert String into Date type.
     
     ### Chinese description
     將字串轉換為日期類型
    
     ### Use example
     ```swift
     "2020-11-24 05:30:30".todate()
     ```
     - Parameter format: string format. (default is SMConfig.dateFormatString)
     - Returns: New date with given format. Retrun nil if format error.
     */
    func toDate(format: String = SMConfig.dateFormatString) -> Date? {
        let dateFormatter = SMConfig.dateFormatter
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = SMConfig.timeZone
        return dateFormatter.date(from: self)
    }
    
    /**
     Helper method to predicate string. Ignore case to check self is contains key.
     
     ### Chinese description
     NSPredicate 的輔助方法，忽略大小寫的方式檢查源字串是否包含 key。
    
     ### Use example
     ```swift
     "SwiftMinions".containsPredicate(key: "swiftminions")
     // true
     ```
     - Parameter key: String
     - Returns: Bool
     */
    func containsPredicate(key: String) -> Bool{
        let predicate = NSPredicate(format: "SELF CONTAINS[cd] %@", key)
        return predicate.evaluate(with: self)
    }

    /**
     Parse query string.
     
     ### Chinese description
     刪除類似價格字串中的小數點。 例如：1000.000至1000
    
     ### Use example
     ```swift
     let query = "a=1&b=2&c=3"
     query.parseQueryString()
     // ["a": "1", "b": "2", "c": "3"]
     ```
     - Returns: String
     */
    func parseQueryString() -> [String: String] {
        var dictionary = [String : String]()
        let pairs = components(separatedBy: "&")
        for pair in pairs {
            let element = pair.components(separatedBy: "=")
            if element.count == 2 {
                let key = element[0]
                let value = element[1]
                dictionary[key] = value
            }
        }
        return dictionary
    }
    
    /**
     Remove decimal point for price-like strings. Ex: 1000.000 to 1000
     
     ### Chinese description
     刪除類似價格字串中的小數點。 例如：1000.000至1000
    
     ### Use example
     ```swift
     "1000.000".removeDecimal()
     // "1000"
     ```
     - Returns: String
     */
    func removeDecimal() -> String {
        if let subString = self.split(separator: ".").first {
            return String(subString)
        }
        return self
    }
    
    /**
     Get NSAttributedString from HTML-string.
     
     ### Chinese description
     將 HTML-string 轉換成 NSAttributedString
    
     - Returns: NSAttributedString? (return nil if not HTML-string)
     */
    func getNSAttributedStringFromHTMLTag() -> NSAttributedString? {
        guard let data = self.data(using: .utf8) else {
            return nil
        }
        do {
            return try NSAttributedString(
                data: data,
                options: [
                    .documentType: NSAttributedString.DocumentType.html,
                    .characterEncoding: String.Encoding.utf8.rawValue
                ],
                documentAttributes: nil
            )
        } catch {
            print(error.localizedDescription)
            return  nil
        }
    }
    
    /**
     Get string size via given UIFont. Return CGSize includes height and width.
     
     ### Chinese description
     取得當前 String 的大小，回傳 CGSize 格式，可以再透過 CGSize 拿到 height 跟 width
    
     ### Use example
     ```swift
     let text = "Some text"
     let font = UIFont.systemFont(ofSize: 20)
     let size = text.size(withFont: font)   /// { w: 87.334, h: 23.867 }
     size.height                            /// 23.8671875
     size.width                             /// 87.333984375
     ```
     - Parameter font: UIFont class
     - Returns: CGSize
     */
    func size(withFont font: UIFont) -> CGSize {
        size(withAttributes: [.font: font])
    }
    
    /**
     Calculate the size of string in a max rect.
     
     ### Chinese description
     計算 String 在一個方框下的大小.
    
     ### Use example
     ```swift
     let size: CGSize = "SwiftMinions".calculateRectSize(font: .systemFont(ofSize: 20), maxSize: CGSize(width: 100, height: 200))
     print(size)
     ```
     Parameter font: UIFont class
     Parameter maxSize: CGSize class

     Returns: CGSize
     */
    func calculateRectSize(font: UIFont, maxSize: CGSize) -> CGSize {
        let attributedString = NSAttributedString.init(string: self, attributes: [.font: font])
        let rect = attributedString.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, context: nil)
        return rect.size
    }
    
    var toInt: Int? {
        return Int(self)
    }
    
    var toIntValue: Int {
        return Int(self) ?? 0
    }
    
    /**
     String to base64.

     ### Chinese description
     將字串編碼成 base64

     ### Use example
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

     ### Chinese description
     將字串用 base64 解碼

     ### Use example
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
    
     /**
     Generate a random string—a "nonce" with ios build-in cryptographically secure nonce functions
     
     Adapted from https://auth0.com/docs/api-auth/tutorials/nonce#generate-a-cryptographically-random-nonce
     and
     https://firebase.google.com/docs/auth/ios/apple
     
     ### Chinese description
     透過 Apple 內建 SecRandomCopyBytes 方法產生安全的隨機字串
     
     ### Use example
     ```swift
         String().randomNonceString()
         "".randomNonceString()
         "".randomNonceString(length: 16)
     ```
     
     - Parameters:
        - length: lenght of nonce
     - Returns: Nonce string
    */
    func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> =
            Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length

        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }

            randoms.forEach { random in
                if remainingLength == 0 { return }
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        return result
    }

     /**
     Generate sha256 algorithm hash string
     
     Adapted from https://firebase.google.com/docs/auth/ios/apple
     
     ### Chinese description
     使用 sha256 來雜湊字串
     
     ### Use example
     String.randomNonceString()
     ```swift
        let afterSha256 = "string input here".withSha256()
     ```
     
     - Parameters:
        - input: string that wanted to be sha256 hash
     - Returns: hashed via sha256 string
    */
    @available(iOS 13.0, *)
    func withSha256() -> String {
        let inputData = Data(self.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()
        return hashString
    }
}

// MARK: - Regular expression

public extension String {
    
    /**
     String is validate with regular expression.

     ### Chinese description
     字串是否匹配正規表示式。

     ### Use example
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

     ### Chinese description
     找到第一個匹配正規表示式的字串，如果找不到則回傳 nil。

     ### Use example
     ```swift
        let regex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,64}$"#
        let result = "minions@swiftminions.com".regularFirstMatch(withRegex: regex)
        // result-> "minions@swiftminions.com"
     ```

     - Parameters:
        - withRegex: regular expression.
        - options: NSRegularExpression.Options. (default is SMConfig.regexOptions)
     - Returns: String?
    */
    func regularFirstMatch(
        withRegex regexString: String,
        options: NSRegularExpression.Options = SMConfig.regexOptions)
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

     ### Chinese description
     找到所有匹配正規表示式的字串，如果找不到則回傳空陣列。

     ### Use example
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
        - options: NSRegularExpression.Options. (default is SMConfig.regexOptions)
     - Returns: [String]
    */
    func regularMatches(
        withRegex regex: String,
        options: NSRegularExpression.Options = SMConfig.regexOptions)
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

     ### Chinese description
     用正規表示式取代字串，將返回一個新的字串

     ### Use example
     ```swift
        let regex = #"(\()([0][0-9]{1,2})(\))([\d]{9})"#
        let phone = "(02)123456789"
        let newPhone = phone.regularReplace(withRegex: regex, content: "$2-$4")
        // newPhone -> 02-123456789
     ```

     - Parameters:
        - withRegex: regular expression.
        - options: NSRegularExpression.Options. (default is SMConfig.regexOptions)
     - Returns: [String]
    */
    func regularReplace(
        withRegex regex: String,
        content: String,
        options: NSRegularExpression.Options = SMConfig.regexOptions)
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

// MARK: - Hex helper method

public extension String {
    /**
     Hex string to Int.
     
     ### Chinese description
     16 進位文字轉 Int
     
     ### Use example
     ````
     let hexString = "FF"
     let int = hexString.hexToInt()
     // 255
     ````
     */
    func hexToInt() -> Int {
        Int(strtoul(self, nil, 16))
    }
    
    /**
     Hex string to brnary string.
     
     ### Chinese description
     16 進位文字轉 Binary 文字
     
     ### Use example
     ````
     let hexString = "FF"
     let binaryString = hexString.hexToBinary()
     // 11111111
     ````
     */
    func hexToBinary() -> String {
        String(hexToInt(), radix: 2)
    }
    
    /**
     Int string to hex string.
     
     ### Chinese description
     10 進位文字轉 16 進位文字
     
     ### Use example
     ````
     let decimalString = "255"
     let hexString = decimalString.decimalToHex()
     // FF
     ````
     */
    func decimalToHex(isUppercased: Bool = false) -> String {
        let hex = String(Int(self) ?? 0, radix: 16)
        return !isUppercased ? hex : hex.uppercased()
    }
    
    /**
     Decimal string to binary string.
     
     ### Chinese description
     10 進位文字轉 Binary 文字
     
     ### Use example
     ````
     let decimalString = "255"
     let binaryString = decimalString.decimalToBinary()
     // 11111111
     ````
     */
    func decimalToBinary() -> String {
        String(Int(self) ?? 0, radix: 2)
    }
    
    /**
     Binary string to Int.
     
     ### Chinese description
     Binary 文字轉 10 進位
     
     ### Use example
     ````
     let binaryString = "11111111"
     let decimal = binaryString.binaryToInt()
     // 255
     ````
     */
    func binaryToInt() -> Int {
        Int(strtoul(self, nil, 2))
    }
    
    /**
     Binary string to hex string.
     
     ### Chinese description
     Binary 文字轉 16 進位文字
     
     ### Use example
     ````
     let binaryString = "11111111"
     let hexString = binaryString.binaryToHex()
     // FF
     ````
     */
    func binaryToHex(isUppercased: Bool = false) -> String {
        let hex = String(binaryToInt(), radix: 16).uppercased()
        return !isUppercased ? hex : hex.uppercased()
    }
    
    /**
     Hex string to Float.
     
     ### Chinese description
     16 進位文字轉 Float
     
     ### Use example
     ````
     let hexString = "3D512EE0"
     print(hexString.hexToFloat())
     // 0.051070094
     ````
     */
    func hexToFloat() -> Float {
        Float32(bitPattern: UInt32(strtol(self, nil, 16)))
    }
    
    /**
     Hex string to Data.
     
     ### Chinese description
     16 進位文字轉 Data
     
     ### Use example
     ````
     let data = "FF".hexToData()
     let hexString = data.map { String(format: "%02x", $0)}.joined(separator: "")
     print(hexString)
     // ff
     ````
     */
    func hexToData() -> Data {
        var dataBytes = Data()
        var startPos = self.startIndex
        while let endPos = self.index(startPos, offsetBy: 2, limitedBy: self.endIndex) {
            let singleHexStr = self[startPos..<endPos]
            let scanner = Scanner(string: String(singleHexStr))
            var intValue: UInt64 = 0
            scanner.scanHexInt64(&intValue)
            dataBytes.append(UInt8(intValue))
            startPos = endPos
        }
        return dataBytes
    }
}

// MARK: - Safely to get string by range

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

public extension SafeRangeable where Base == String {
    
    /**
     It safe-able to get collection element.

     ### Chinese description
     安全的取得 collection 中的元素

     ### Use example
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

     ### Chinese description
     安全的取得 collection 中的元素

     ### Use example
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
