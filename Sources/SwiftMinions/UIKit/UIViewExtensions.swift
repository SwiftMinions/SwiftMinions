//
//  UIViewExtensions.swift
//  SwiftMinions
//
//  Created by Natalie Ng on 2020/3/12.
//  Copyright © 2020 SwiftMinions. All rights reserved.
//

import UIKit

extension UIView {

    /**
    Use UIBezierPath to create rounded corners for this view.
    Although iOS 13 has provide a API for creatinf rounded corners for specific corners, the path of CAShapeLayer is different form UIBezierPath. You can use this if you need UIBezierPath rounded corners.

    ### Chinese description
    用 UIBezierPath 加圓角。雖然 iOS 13 有提供了一個 API 為指定的幾個角設置圓角 ，但是 CAShapeLayer 的路徑與 UIBezierPath 不同。 如果需要UIBezierPath圓角，可以使用此方法。

    ## Use example ##
    ```swift

     let button = UIButton()
     button.makeRoundedBezierPathCorners(for: .topLeft)
     button.makeRoundedBezierPathCorners(for: [.topLeft, .topRight])

    ```
    */
    func createRoundedBezierPathCorners(for corners: UIRectCorner, radius: Int = 10) {
        let maskPath = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        layer.mask = maskLayer
    }

    /**
    Apply a rotation animation by a given degree to this view

    ### Chinese description
    把這個 view 旋轉指定的度數

    ## Use example ##
    ```swift
     let button = UIButton()

     button.rotate(by: 180, duration: 0.5, options: .curveLinear) // rotate 180°
     button.rotate(by: 230, duration: 0.5, options: .curveLinear) // rotate 360°

    ```
    */
    func rotate(by degree: CGFloat, duration: TimeInterval, delay: TimeInterval = 0, options: UIView.AnimationOptions = .curveLinear, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: duration, delay: delay, options: options, animations: {
            self.transform = self.transform.rotated(by: degree.radiansValue)
        }, completion: nil)
    }

}
