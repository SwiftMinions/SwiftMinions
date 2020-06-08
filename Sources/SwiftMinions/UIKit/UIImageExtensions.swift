//
//  UIImageExtensions.swift
//  SwiftMinions
//
//  Created by Ohlulu on 2020/5/18.
//  Copyright © 2020 SwiftMinions. All rights reserved.
//

import UIKit

public extension UIImage {
    
    enum ImageMode {
        case fit, fill
    }
    
    /**
     Resize image.

     ## Chinese description
     將圖片重新裁切成指定的大小。

     - Parameters:
        - size: Target size.
        - isCircle: Clip to circle. (default is false)
        - mode: Image content mode. (default is .fill)
     - Returns: UIImage?
    */
    func resizeImage(to size: CGSize, isCircle: Bool = false, mode: ImageMode = .fill) -> UIImage? {
        // 找出目前螢幕的scale，視網膜技術為2.0 or 3.0
        let scale = UIScreen.main.scale
        
        //產生畫布，第一個參數指定大小，第二個參數true:不透明(黑色底) false表示背景透明，scale為螢幕scale
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        
        let widthRatio: CGFloat = size.width / self.size.width
        let heightRadio: CGFloat = size.height / self.size.height
        
        // max: fit
        // min: fill
        let ratio: CGFloat
        switch mode {
        case .fill:
            ratio = min(widthRatio, heightRadio)
        case .fit:
            ratio = max(widthRatio, heightRadio)
        }
        
        let imageSize: CGSize  = CGSize(width: floor(self.size.width*ratio), height: floor(self.size.height*ratio))
        
        //切成圓形
        if isCircle {
            let circlePath = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            circlePath.addClip()
        }
        
        let rect = CGRect(
            x: -(imageSize.width-size.width)/2.0,
            y: -(imageSize.height-size.height)/2.0,
            width: imageSize.width,
            height: imageSize.height
        )
        draw(in: rect)
        
        let smallImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return smallImage
    }
    
    /**
     Create UIImage from UIColor.

     ## Chinese description
     利用顏色建立圖片。

     - Parameters:
        - color: Image color.
        - size: Image size. (default is 1x1)
     - Returns: UIImage
    */
    static func create(from color: UIColor, size: CGSize = .init(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            color.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}
