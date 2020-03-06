//
//  StringExtensions.swift
//  SwiftMinions
//
//  Created by twStephen on 2020/3/6.
//  Copyright © 2020 SwiftMinions. All rights reserved.
//

import UIKit

public extension String {

    /**
     Get string size via given UIFont. Return CGSize includes height and width.
     
     ### Chinese description
     取得當前 String 的大小，回傳 CGSize 格式，可以再透過 CGSize 拿到 height 跟 width
    
     ## Use example ##
     ```swift
     
     let text = "Some text"
     let font = UIFont.systemFont(ofSize: 20)
     let size = text.size(fontSize: font)   /// {w 87.334 h 23.867}
     size.height                            /// 23.8671875
     size.width                             /// 87.333984375
     
     ```
     Parameter font: UIFont class
     
     Returns: CGSize
     */
    func size(fontSize font: UIFont) -> CGSize {
        return self.size(withAttributes: [NSAttributedString.Key.font: font])
    }
}