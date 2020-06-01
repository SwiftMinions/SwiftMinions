//
//  FileManagerExtensions.swift
//  SwiftMinions
//
//  Created by Ohlulu on 2020/5/31.
//  Copyright © 2020 SwiftMinions. All rights reserved.
//

import Foundation

public extension FileManager {
    
    /// Helper property to get document directory URL.
    static let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    
    /// Helper property to get document cach directory URL.
    static let cachURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
    
    /// Helper property to get temp directory URL.
    static let tempURL = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
    
    /**
     Get file URL for temp
     
     ## Chinese description
     取得檔案在 temp 的 URL
     
     ## Use example
     ```swift
     let fileURL = FileManager.getFileURLFromTemp(url: url)
     print(fileURL)
    ```
    */
    static func getFileURLFromTemp(_ fileName : String) -> URL {
        FileManager.tempURL.appendingPathComponent(fileName)
    }

    
    /**
     Safely remove file.
     
     ## Chinese description
      安全的刪除檔案
     
     ## Use example
     ```swift
     if FileManager.safeRemove(url: url) {
        // success
     } else {
        // failure
     }
    ```
    */
    @discardableResult
    static func safeRemove(url : URL) -> Bool {
        if !FileManager.default.fileExists(atPath: url.path) {
            return true
        }
        
        do {
            try FileManager.default.removeItem(at: url)
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    /**
     Get file size. Unit is byte.
     
     ## Chinese description
     取得檔案大小。單位是 byte
     
     ## Use example
     ```swift
     let size = FileManager.getFileSize(url: url)
     print(size)
    ```
    */
    static func getFileSize(filePath : String) -> UInt64 {
        
        var fileBytes: UInt64 = 0

        let fileManager = FileManager.default

        if fileManager.fileExists(atPath: filePath) {
            do {
                let fileDict = try fileManager.attributesOfItem(atPath: filePath)
                fileBytes = fileDict[.size] as? UInt64 ?? 0
            } catch {
                print(error.localizedDescription)
            }
        }
        return fileBytes
    }
}

extension FileManager {
    
    }
