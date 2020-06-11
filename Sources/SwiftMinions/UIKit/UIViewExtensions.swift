//
//  UIViewExtensions.swift
//  SwiftMinions
//
//  Created by Natalie Ng on 2020/3/12.
//  Copyright © 2020 SwiftMinions. All rights reserved.
//

import UIKit

public extension UIView {
    
    /// Helper property for logic.
    var isShow: Bool {
        get { !isHidden }
        set { isHidden = !newValue}
    }
    

    /**
    Use UIBezierPath to create rounded corners for this view.
    Although iOS 13 has provide a API for creatinf rounded corners for specific corners, the path of CAShapeLayer is different form UIBezierPath. You can use this if you need UIBezierPath rounded corners.

    ### Chinese description
    用 UIBezierPath 加圓角。雖然 iOS 13 有提供了一個 API 為指定的幾個角設置圓角 ，但是 CAShapeLayer 的路徑與 UIBezierPath 不同。 如果需要UIBezierPath圓角，可以使用此方法。

    ### Use example
    ```swift

     let button = UIButton()
     button.makeRoundedBezierPathCorners(for: .topLeft)
     button.makeRoundedBezierPathCorners(for: [.topLeft, .topRight])

    ```
    */
    func createRoundedBezierPathCorners(for corners: UIRectCorner, radius: CGFloat = SMConfig.cornerRadius) {
        
        let maskPath = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        layer.mask = maskLayer
    }

    /**
    Apply a rotation animation by a given degree to this view

    ### Chinese description
    把這個 view 旋轉指定的度數

    ### Use example
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

// MARK: - Animation

public extension UIView {
    
    /**
     UIView's AnimationType.
    
     ### Chinese description
     UIView 的動畫類型
    */
    enum AnimationType {
        
        /**
         Fade type.
        
         ### Chinese description
         淡入/淡出。
        */
        public enum Fade {
            case `in`
            case out
        }
        case fade(Fade)
        
        /**
         Shake type.
        
         ### Chinese description
         晃動類型。
        */
        public enum ShakeOffsets {
            case light
            case medium
            case heavy
            case custom([CGFloat])
        }
        case shake(ShakeOffsets)
    }
}

/**
 Duration and delay animation timing.
 Duration's default value by `SMConfig.AnimationDuration`, Delay's default is 0s.

 ### Chinese description
 動畫的持續時間跟延遲時間。
 持續時間的預設職值來自 `SMConfig.AnimationDuration`，延遲時間預設值是０。
*/
protocol AnimationTiming {
    var duration: TimeInterval { get }
    var delay: TimeInterval { get }
}

extension UIView.AnimationType.Fade: AnimationTiming {
    var duration: TimeInterval {
        switch self {
        case .in, .out:
            return SMConfig.AnimationDuration.short
        }
    }
    
    var delay: TimeInterval { 0 }
}

extension UIView.AnimationType: AnimationTiming {
    var duration: TimeInterval {
        switch self {
        case .fade(let type):
            return type.duration
        case .shake:
            return SMConfig.AnimationDuration.long
        }
    }
    
    var delay: TimeInterval { 0 }
}

/**
 Shake animation type need offsets.

 ### Chinese description
 晃動類型的動畫的偏移量。
*/
protocol AnimationOffsets {
    var offset: [CGFloat] { get }
}

extension UIView.AnimationType.ShakeOffsets: AnimationOffsets {
    var offset: [CGFloat] {
        switch self {
        case .light:
            return [-10.0, 10.0, -10.0, 10.0, -5.0, 5.0, 0.0]
        case .medium:
            return [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        case .heavy:
            return [-30.0, 30.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        case .custom(let offsets):
            return offsets
        }
    }
}

public extension UIView {
    
    /**
     Eazy animation view.

     ### Chinese description
     簡單的讓view動起來。

     - Parameters:
        - animationType: An `AnimationType`.
        - duration: Set this value to duration. If this value is nil then value will from UIView.AnimationType AnimationTiming setting.
        - delay: Set this value to delay. (default is 0)
        - completion:  optional completion handler. (default is nil)
    */
    func animation(
        animationType: AnimationType,
        duration: TimeInterval? = nil,
        delay: TimeInterval? = nil,
        _ completion: (() -> Void)? = nil)
    {
        let duration = duration ?? animationType.duration
        let delay = delay ?? animationType.delay
        
        switch animationType {
        case .fade(let type):
            switch type {
            case .in:
                animation(isFadout: false, duration: duration, delay: delay, completion)
            case .out:
                animation(isFadout: true, duration: duration, delay: delay, completion)
            }
        case .shake(let type):
            errorShake(duration: duration, delay: delay, offsets: type.offset, completion: completion)
        }
    }

    private func animation(
        isFadout: Bool,
        duration: TimeInterval,
        delay: TimeInterval,
        _ completion: (() -> Void)? = nil)
    {
        if isHidden {
           isHidden = false
        }
        
        if alpha == (isFadout ? 0 : 1) {
           alpha = (isFadout ? 1 : 0)
        }
        
        UIView.animate(withDuration: duration, delay: delay, animations: {
            self.alpha = (isFadout ? 0 : 1)
        }, completion: { _ in
            completion?()
        })
    }
    
    private func errorShake(
        duration: CFTimeInterval,
        delay: TimeInterval,
        offsets: [CGFloat] = [-10.0, 10.0, -10.0, 10.0, -5.0, 5.0, 0.0],
        completion:(() -> Void)? = nil
    ) {
        shakeHorizontal(
            duration: SMConfig.AnimationDuration.long,
            delay: delay,
            offsets: offsets,
            completion: completion
        )
    }
    
    /**
     Animated with a horizontal shake.

     ### Chinese description
     簡單的讓試圖視圖左右晃動。

     - Parameters:
        - type: set this value with AnimationType.
        - duration: set this value to duration.
        - delay: set this value to delay.
        - completion:  optional completion handler. (default is nil)
    */
    func shakeHorizontal(
        duration: TimeInterval,
        delay: TimeInterval,
        offsets: [CGFloat],
        completion:(() -> Void)? = nil)
    {
        constraints.forEach { $0.isActive = false }
        translatesAutoresizingMaskIntoConstraints = true
        
        CATransaction.begin()
        
        let animation: CAKeyframeAnimation
        
        animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        animation.beginTime = CACurrentMediaTime() + delay
        animation.duration = duration
        animation.values = offsets
        layer.add(animation, forKey: "shake")
        CATransaction.setCompletionBlock(completion)
        
        CATransaction.commit()
    }
}
