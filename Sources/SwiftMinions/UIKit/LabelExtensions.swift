//
//  LabelExtensions.swift
//  SwiftMinions
//
//  Created by 郭景豪 on 2020/3/12.
//  Copyright © 2020 SwiftMinions. All rights reserved.
//

import UIKit

extension UILabel {
    
    /**
     Calculate the height of label in a width.

     ### Chinese description
     計算 Label 高度.

     ## Use example ##
     ```swift
     
     let height: CGFloat = UILabel().heightForLabel(text: "123", font: UIFont.systemFont(ofSize: 100), width: 100)
     print(height)
     
     ```
     Parameter width: CGFloat class
     
     Returns: CGFloat
     */
    func calculateHeight(width: CGFloat) -> CGFloat {
        let size = text?.calculateRectSize(font: font, maxSize: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude))
        return size?.height ?? 0
    }
}
