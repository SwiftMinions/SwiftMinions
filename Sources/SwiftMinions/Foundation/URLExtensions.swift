//
//  URLExtensions.swift
//  SwiftMinions
//
//  Created by Ohlulu on 2020/5/31.
//  Copyright © 2020 SwiftMinions. All rights reserved.
//

import Foundation

public extension URL {
    
    /// Get url query value via key
    ///
    /// If the URL is **http://www.google.com?AAAA=1111&BBBB=2222&CCCC=3333**, then give **AAAA** as key, its return **1111** .then give **BBBB** as key, its return **2222**.
    ///
    /// - Parameters:
    ///   - aURL: url string
    ///   - key: a string key
    /// - Returns: correspond value via given key
    func getQueryItem(aURL: String?, key: String) -> String? {
        
        guard let aURLString = aURL else { return nil }
        
        let queryItems = URLComponents(string: aURLString)?.queryItems
        let param = queryItems?.filter { $0.name == key }.first
        
        return param?.value
    }
    
    /// Appending query string
    ///
    /// *** Example
    ///
    /// var url = URL(string: "https://www.example.com")
    /// let finalURL = url?.appending("key1", value: "123")
    ///                    .appending("key2", value: nil)
    ///
    /// ***
    ///
    /// - Parameters:
    ///   - key: Key
    ///   - value: Value
    func appending(_ key: String, value: String?) -> URL? {

         guard var urlComponents = URLComponents(string: self.absoluteString) else { return self.absoluteURL }

         // Create array of existing query items
         var queryItems: [URLQueryItem] = urlComponents.queryItems ??  []

         // Create query item
         let queryItem = URLQueryItem(name: key, value: value)

         // Append the new query item in the existing query items array
         queryItems.append(queryItem)

         // Append updated query items array in the url component object
         urlComponents.queryItems = queryItems

         // Returns the url from new url components
         return urlComponents.url
     }
}
