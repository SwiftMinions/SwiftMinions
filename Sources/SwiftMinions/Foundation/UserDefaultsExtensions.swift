//
//  UserDefaultsExtensions.swift
//  SwiftMinions
//
//  Created by 郭景豪 on 2020/3/21.
//  Copyright © 2020 SwiftMinions. All rights reserved.
//

import Foundation

public extension UserDefaults {
    
    /**
     Save codable model to user defaults.
     
     ## Chinese description
     將 Codable 存入 UserDefaults
     
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
     UserDefaults.standard.saveCodable(model: userModel, key: "userKey")
     ```
     */
    func saveCodable<T: Codable>(model : T, key : String) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(model) {
            self.set(encoded, forKey: key)
        }
    }
    
    /**
     Get codable model from user defaults.
     
     ## Chinese description
     從 UserDefaults 取出 Codable
     
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
     UserDefaults.standard.saveCodable(model: userModel, key: "userKey")
     var user: UserModel = UserDefaults.standard.getCodable("userKey")
     print(user ?? "nil")
     ```
     */
    func getCodable<T: Codable>(key : String) -> T? {
        if let savedData = self.object(forKey: key) as? Data {
            let decoder = JSONDecoder()
            if let loadedModel = try? decoder.decode(T.self, from: savedData) {
                return loadedModel
            }
        }
        return nil
    }
    
}
