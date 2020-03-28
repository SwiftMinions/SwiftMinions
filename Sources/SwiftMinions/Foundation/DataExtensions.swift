//
//  DataExtensions.swift
//  SwiftMinions
//
//  Created by 郭景豪 on 2020/3/21.
//  Copyright © 2020 SwiftMinions. All rights reserved.
//

import Foundation

public extension Data {
    
    /**
     Data change to codable model.
     
     ## Chinese description
     Data 轉 Codable
     
     ### Usage Example: ###
     ```
     struct UserModel: Codable {
     let id: String
     enum CodingKeys: String, CodingKey {
        case id = "id"
        }
     }
     let jsonString = "{ id : \"123\" }"
     let data = string.data(using: .utf8)
     let userModel: UserModel = data.toCodable()
     print(userModel)
     ```
     */
    func toCodable<T: Codable>(decoder: JSONDecoder = JSONDecoder()) -> T? {
        if let model = try? decoder.decode(T.self, from: self) {
            return model
        }
        return nil
    }
    
    /**
     Data to hex string.
     
     ## Chinese description
     Data 轉 16進位文字
     
     ### Usage Example: ###
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
