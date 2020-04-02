//
//  UIScrollViewExtensions.swift
//  SwiftMinions
//
//  Created by stephen on 2020/3/29.
//  Copyright © 2020 SwiftMinions. All rights reserved.
//

import UIKit

public extension UIScrollView {
        
    /**
     Update contentSize height while scroll view did finish layout all subviews
    
     ## Chinese description
     根據所有的 subviews 所有的高度來更新 scroll 的 contentSize 高度
    
     ## Use example
     ```swift
     override func viewDidLayoutSubviews() {
         super.viewDidLayoutSubviews()
         scrollView.updateContentViewHeight()
     }
     ```
    */
    func updateContentViewHeight() {
        self.contentSize.height = subviews.sorted(by: { $0.frame.maxY < $1.frame.maxY }).last?.frame.maxY ?? contentSize.height
    }
    
    /**
     Update contentSize Width while scroll view did finish layout all subviews
    
     ## Chinese description
     根據所有的 subviews 所有的寬度來更新 scroll 的 contentSize 寬度
    
     ## Use example
     ```swift
     override func viewDidLayoutSubviews() {
         super.viewDidLayoutSubviews()
         scrollView.updateContentViewWidth()
     }
     ```
    */
    func updateContentViewWidth() {
        self.contentSize.width = subviews.sorted(by: { $0.frame.maxX < $1.frame.maxX }).last?.frame.maxX ??  contentSize.width
    }
}
