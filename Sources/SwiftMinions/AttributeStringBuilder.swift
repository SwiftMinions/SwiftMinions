//
//  AttributeStringBuilder.swift
//  SwiftMinions
//
//  Created by Ohlulu on 2020/4/7.
//  Copyright © 2020 SwiftMinions. All rights reserved.
//

import Foundation

/// Convenience to build NSMutableAttributedString
public class AttributeStringBuilder {
    
    private var attString: NSMutableAttributedString = NSMutableAttributedString()
    private(set) var baseAttributed: [NSAttributedString.Key: Any] = [:]
    private(set) var specialAttributed: [NSAttributedString.Key: Any] = [:]
    
    /**
     Set attribute and mark to base for reuse.
    
     ## Chinese description
     設置一個 base attribute 以便重用。

     - Parameter attribute:[NSAttributedString.Key: Any]
     - Returns: AttributeStringBuilder
    */
    public func setBase(attribute: [NSAttributedString.Key: Any]) -> Self {
        baseAttributed = attribute
        return self
    }
    
    /**
     Set special attribute and mark to special for reuse.
    
     ## Chinese description
     設置一個 special attribute 以便重用。

     - Parameter attribute:[NSAttributedString.Key: Any]
     - Returns: AttributeStringBuilder
    */
    public func setSpecial(attribute: [NSAttributedString.Key: Any]) -> Self {
        specialAttributed = attribute
        return self
    }
    
    /**
     Set base text of attribute.

     ## Chinese description
     設置 base 文字並給予一個 attribute。

     - Parameters:
        - text: A text.
        - attribute: Text's attribute. (default by \`func setBase(attribute:)\`)
     - Returns: AttributeStringBuilder
    */
    public func setBase(
        text: String,
        attribute: [NSAttributedString.Key: Any]? = nil)
        -> Self {
            attString = NSMutableAttributedString(string: text, attributes: attribute ?? baseAttributed)
            return self
    }
    
    /**
     Change the special attribute of the same string as special text.

     ## Chinese description
     改變與 special text 相同字串的 special attribute。

     - Parameters:
        - text: A text.
        - attribute: Text's attribute. (default by \`func setSpecial(attribute:)\`)
     - Returns: AttributeStringBuilder
    */
    public func setSpecial(
        text specialText: String,
        attribute: [NSAttributedString.Key: Any]? = nil)
        -> Self {
            let specialRange = attString.string.ranges(of: specialText)
                .map { NSRange($0, in: attString.string) }
            specialRange.forEach {
                attString.addAttributes(attribute ?? specialAttributed, range: $0)
            }
            return self
    }
    
    /**
     Append a text of attribute.

     ## Chinese description
     改變與 special text 相同字串的 special attribute。

     - Parameters:
        - text: A text.
        - attribute: Text's attribute.
     - Returns: AttributeStringBuilder
    */
    public func append(
        text: String,
        attribute: [NSAttributedString.Key: Any])
        -> Self {
            attString.append(
                NSMutableAttributedString(string: text, attributes: attribute)
            )
            return self
    }

    public func build() -> NSMutableAttributedString {
        return attString
    }
}

public extension NSAttributedString {

    /**
     Create a AttributeStringBuilder

     ## Chinese description
     建立一個 AttributeStringBuilder

     ### Usage Exsample ###
     
     - the `*` will be red
     ```swift
     let att = NSAttributedString.builder
         .setBase(text: "*",
                  attribute: [
                     .font: UIFont.systemFont(ofSize: 16, weight: .regular),
                     .foregroundColor: UIColor.red])
         .append(text: "*SwiftMininos", attribute: [.foregroundColor: UIColor.black])
         .build()
     ```
     
     - the `xxx` will be red
     ```
     let att = NSAttributedString.builder
         .setBase(text: "Sorry. Can not found xxx in Google.",
                  attribute: [
                     .font: UIFont.systemFont(ofSize: 16, weight: .regular),
                     .foregroundColor: UIColor.black])
         .setSpecial(text: "xxx", attribute: [.foregroundColor: UIColor.red])
         .build()
     ```
     
     - Returns: AttributeStringBuilder
    */
    static var builder: AttributeStringBuilder {
        get { return AttributeStringBuilder() }
        set { }
    }
}

private extension String {
    /**
     ## Chinese description
     在源字串中比對與 searchString 相同字串，並回傳其 [Range<String.Index>]（有可能比對到復數）。
     僅供 AttributeStringBuilder 使用。
     */
    func ranges(of searchString: String) -> [Range<String.Index>] {
        let _indices = getStartIndices(of: searchString)
        let count = searchString.count
        return _indices.map { index(startIndex, offsetBy: $0)..<index(startIndex, offsetBy: $0 + count) }
    }
}

private extension String {
    
    /**
     ## Chinese description
     在源字串中比對與 occurrence 相同字串，在源字串中的 start index。
     僅供 AttributeStringBuilder 使用。
    */
    func getStartIndices(of occurrence: String) -> [Int] {
        var indices = [Int]()
        var position = startIndex
        while let range = range(of: occurrence, range: position..<endIndex) {
            let i = distance(from: startIndex,
                             to: range.lowerBound)
            indices.append(i)
            let offset = occurrence.distance(from: occurrence.startIndex,
                                             to: occurrence.endIndex) - 1
            guard let after = index(range.lowerBound,
                                    offsetBy: offset,
                                    limitedBy: endIndex) else {
                                        break
            }
            position = index(after: after)
        }
        return indices
    }
}
