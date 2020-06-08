//
//  KeyDecodingStrategyExtensions.swift
//  SwiftMinions
//
//  Created by Natalie Ng on 2020/4/27.
//  Copyright © 2020 SwiftMinions. All rights reserved.
//

import Foundation

public extension JSONDecoder.KeyDecodingStrategy {

    /**
     Convert from the first letter of key to lower case before attempting to match a key with the one specified by each type. Mainly designed for coverting the upper camel case to lower camel case.

     ## Chinese description
     把所有的 key 的第一個字母轉成小寫

     ## Usage Example
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

     ## Chinese description
     把所有的 key 的第一個字母轉成大寫

     ## Usage Example
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

     ## Chinese description
     把所有的 key 轉成小寫，做到類似無視大小寫的效果

     ## Usage Example
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


public struct CustomCodingKey: CodingKey {
    public var stringValue: String
    public var intValue: Int?

    init(_ base: CodingKey) {
        self.init(stringValue: base.stringValue, intValue: base.intValue)
    }

    public init(stringValue: String) {
        self.stringValue = stringValue
    }

    public init(intValue: Int) {
        self.stringValue = "\(intValue)"
        self.intValue = intValue
    }

    public init(stringValue: String, intValue: Int?) {
        self.stringValue = stringValue
        self.intValue = intValue
    }
}

