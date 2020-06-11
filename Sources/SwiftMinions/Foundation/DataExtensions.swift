//
//  DataExtensions.swift
//  SwiftMinions
//
//  Created by 郭景豪 on 2020/3/21.
//  Copyright © 2020 SwiftMinions. All rights reserved.
//

import Foundation
import CommonCrypto

public extension Data {
    
    /**
     Decode data into given object that confrims to Decodable.
     
     ### Chinese description
     Data 轉 Codable
     
     ### Use example
     ```
     struct UserModel: Codable {
        let id: String
        enum CodingKeys: String, CodingKey {
            case id = "id"
        }
     }
     let jsonString = #"{ "id" : "123" }"#
     let data = string.data(using: .utf8)
     let userModel = data.decodeTo(UserModel.self)
     ```
     
     - Parameters:
        - type: A object confrims to Decodable.
        - decoder: Custom decoder. (default is SMConfig.decoder)
     */
    func decodeTo<T: Codable>(_ type: T.Type, decoder: JSONDecoder = SMConfig.decoder) -> T? {
        if let model = try? decoder.decode(T.self, from: self) {
            return model
        }
        return nil
    }
    
    /**
     Data to String.
     
     ### Chinese description
     Data 轉 String
     
     ### Use example
     ```
     Data().toString()
     ```
    */
    func toString(encoding: String.Encoding = SMConfig.stringEncoding) -> String? {
        return String(bytes: self, encoding: encoding)
    }
    
    /**
     Data to hex string.
     
     ### Chinese description
     Data 轉 16進位文字
     
     ### Use example
     ```
     let data = Data([255])
     let hexString = data.hexStringValue
     print(hexString)
     ```
     */
    var hexStringValue: String {
        return map { String(format: "%02x", $0) }
            .joined(separator: "")
    }
}
