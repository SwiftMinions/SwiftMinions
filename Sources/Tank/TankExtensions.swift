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
     Data 轉 Codable
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
    /**
     Data 轉 16進位文字
     ### Usage Example: ###
     ````
     let data = Data([255])
     let hexString = data.toHexString()
     print(hexString)
     //ff
     ````
     */
    func toHexString() -> String {
        return map { String(format: "%02x", $0) }
            .joined(separator: "")
    }
}

extension UserDefaults {
    /**
     將Codable 存入UserDefaults
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
     從UserDefaults取出Codable
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

extension String {
    /**
     計算String 在一個方框下的大小.
     ### Usage Example: ###
     ````
     let size: CGSize = "tttttttttttttttttt".calculateRectSize(font: UIFont.systemFont(ofSize: 20), maxSize: CGSize(width: 100, height: 200))
     print(size)
     ````
     */
    func calculateRectSize(font: UIFont, maxSize: CGSize) -> CGSize {
        let attributedString = NSAttributedString.init(string: self, attributes: [NSAttributedString.Key.font:font])
        let rect = attributedString.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, context: nil)
        let size = CGSize(width:rect.size.width, height : rect.size.height)
        return size
    }
}

extension String {
    /**
     16進位文字轉Int
     ### Usage Example: ###
     ````
     let hexString = "FF"
     let int = hexString.hexToInt()
     print(int)
     //255
     ````
    */
    func hexToInt() -> Int {
        return Int(strtoul(self, nil, 16))
    }
    /**
     16進位文字轉Binary文字
     ### Usage Example: ###
     ````
     let hexString = "FF"
     let binaryString = hexString.hexToBinary()
     print(binaryString)
     //11111111
     ````
    */
    func hexToBinary() -> String {
        return String(hexToInt(), radix: 2)
    }
    /**
     10進位文字轉16進位文字
     ### Usage Example: ###
     ````
     let decimalString = "255"
     let hexString = decimalString.decimalToHex()
     print(hexString)
     //ff
     ````
    */
    func decimalToHex() -> String {
        return String(Int(self) ?? 0, radix: 16)
    }
    /**
     10進位文字轉Binary文字
     ### Usage Example: ###
     ````
     let decimalString = "255"
     let binaryString = decimalString.decimalToBinary()
     print(binaryString)
     //11111111
     ````
    */
    func decimalToBinary() -> String {
        return String(Int(self) ?? 0, radix: 2)
    }
    /**
     Binary文字轉10進位
     ### Usage Example: ###
     ````
     let binaryString = "11111111"
     let decimal = binaryString.binaryToInt()
     print(decimal)
     //255
     ````
    */
    func binaryToInt() -> Int {
        return Int(strtoul(self, nil, 2))
    }
    /**
     Binary文字轉16進位文字
     ### Usage Example: ###
     ````
     let binaryString = "11111111"
     let hexString = binaryString.binaryToHex()
     print(hexString)
     //ff
     ````
    */
    func binaryToHex() -> String {
        return String(binaryToInt(), radix: 16)
    }
    
    /**
     16進位文字轉Float
     ### Usage Example: ###
     ````
     let hexString = "3D512EE0"
     print(hexString.hexToFloat())
     //0.051070094
     ````
    */
    func hexToFloat() -> Float {
        return Float32(bitPattern: UInt32(strtol(self, nil, 16)))
    }
}

extension String {
    /**
     16進位文字轉Data
     ### Usage Example: ###
     ````
     let data = "FF".hexToData()
     let hexString = data.map { String(format: "%02x", $0)}.joined(separator: "")
     print(hexString)
     //ff
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
