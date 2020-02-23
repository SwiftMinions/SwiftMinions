//
//  TankExtensions.swift
//  SwiftMinions
//
//  Created by 郭景豪 on 2020/2/23.
//  Copyright © 2020 SwiftMinions. All rights reserved.
//

import UIKit

extension URL: ExpressibleByStringLiteral {
    /**
     Creates a url instance initialized to the given string value.
     ### Usage Example: ###
     ````
     let url: URL = "https://apple.com"
     ````
    */
    public init(stringLiteral value: StaticString) {
        guard let url = URL(string: "\(value)") else {
            fatalError("Invalid URL string literal: \(value)")
        }
        self = url
    }
}

extension UILabel {
    /**
     計算Label高度.
     ### Usage Example: ###
     ````
     let height: CGFloat = UILabel().heightForLabel(text: "123", font: UIFont.systemFont(ofSize: 100), width: 100)
     print(height)
     ````
    */
    func calculateHeight(text:String, font:UIFont, width:CGFloat) -> CGFloat {
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        
        label.sizeToFit()
        return label.frame.height
    }
    
}

extension Data {
    /**
     ### Usage Example: ###
     ````
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
     ````
    */
    func toCodable<T: Codable>(decoder: JSONDecoder = JSONDecoder()) -> T? {
        if let model = try? decoder.decode(T.self, from: self) {
            return model
        }
        return nil
    }
}

extension UserDefaults {
    /**
     ### Usage Example: ###
     ````
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
     ````
    */
    func saveCodable<T: Codable>(model : T, key : String) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(model) {
            self.set(encoded, forKey: key)
        }
    }
    
    /**
     ### Usage Example: ###
     ````
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
     ````
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
