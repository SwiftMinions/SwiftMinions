//
//  NatalieExtensions.swift
//  SwiftMinions
//
//  Created by Natalie Ng on 2020/2/28.
//  Copyright © 2020 SwiftMinions. All rights reserved.
//

import Foundation
import UIKit

extension UIView {

    func makeRoundedCorners(for corners: UIRectCorner, radius: Int = 10) {
        let maskPath = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        layer.mask = maskLayer
    }

    func rotate180(duration: TimeInterval, options: UIView.AnimationOptions) {
        UIView.animate(withDuration: duration, delay: 0, options: options, animations: {
            self.transform = self.transform.rotated(by: CGFloat.pi)
        }, completion: nil)
    }

    func showToast(message: String, duration: TimeInterval = 4.0) {

        let toastLabel = UILabel(frame:
            CGRect(x: self.frame.size.width/2 - 75,
                   y: self.frame.size.height-100, width: 150, height: 35))
        toastLabel.text = message
        toastLabel.font = UIFont.systemFont(ofSize: 12)
        toastLabel.textAlignment = .center

        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.alpha = 1.0

        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds  =  true

        self.addSubview(toastLabel)

        UIView.animate(withDuration: duration, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }


}
