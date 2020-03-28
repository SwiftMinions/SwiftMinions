//
//  TankExtensions.swift
//  SwiftMinions
//
//  Created by 郭景豪 on 2020/2/23.
//  Copyright © 2020 SwiftMinions. All rights reserved.
//

import UIKit

public extension String {
    /**
     16 進位文字轉 Int
     ## Use example
     ````
     let hexString = "FF"
     let int = hexString.hexToInt()
     print(int)
     //255
     ````
     */
    func hexToInt() -> Int {
        return Int(strtoul(self, nil, 16))
    }
    /**
     16 進位文字轉 Binary 文字
     ## Use example
     ````
     let hexString = "FF"
     let binaryString = hexString.hexToBinary()
     print(binaryString)
     //11111111
     ````
     */
    func hexToBinary() -> String {
        return String(hexToInt(), radix: 2)
    }
    /**
     10 進位文字轉 16 進位文字
     ## Use example
     ````
     let decimalString = "255"
     let hexString = decimalString.decimalToHex()
     print(hexString)
     //ff
     ````
     */
    func decimalToHex() -> String {
        return String(Int(self) ?? 0, radix: 16)
    }
    /**
     10 進位文字轉 Binary 文字
     ## Use example
     ````
     let decimalString = "255"
     let binaryString = decimalString.decimalToBinary()
     print(binaryString)
     //11111111
     ````
     */
    func decimalToBinary() -> String {
        return String(Int(self) ?? 0, radix: 2)
    }
    /**
     Binary 文字轉 10 進位
     ## Use example
     ````
     let binaryString = "11111111"
     let decimal = binaryString.binaryToInt()
     print(decimal)
     //255
     ````
     */
    func binaryToInt() -> Int {
        return Int(strtoul(self, nil, 2))
    }
    /**
     Binary 文字轉 16 進位文字
     ## Use example
     ````
     let binaryString = "11111111"
     let hexString = binaryString.binaryToHex()
     print(hexString)
     //ff
     ````
     */
    func binaryToHex() -> String {
        return String(binaryToInt(), radix: 16)
    }
    
    /**
     16 進位文字轉 Float
     ## Use example
     ````
     let hexString = "3D512EE0"
     print(hexString.hexToFloat())
     //0.051070094
     ````
     */
    func hexToFloat() -> Float {
        return Float32(bitPattern: UInt32(strtol(self, nil, 16)))
    }
}

public extension String {
    /**
     16 進位文字轉Data
     ## Use example
     ````
     let data = "FF".hexToData()
     let hexString = data.map { String(format: "%02x", $0)}.joined(separator: "")
     print(hexString)
     //ff
     ````
     */
    func hexToData() -> Data {
        var dataBytes = Data()
        var startPos = self.startIndex
        while let endPos = self.index(startPos, offsetBy: 2, limitedBy: self.endIndex) {
            let singleHexStr = self[startPos..<endPos]
            let scanner = Scanner(string: String(singleHexStr))
            var intValue: UInt64 = 0
            scanner.scanHexInt64(&intValue)
            dataBytes.append(UInt8(intValue))
            startPos = endPos
        }
        return dataBytes
    }
}



public extension UICollectionView {
    
    /**
     註冊 Cell
     ### Old Example: ###
     ````
     collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
     ````
     ## Use example
     ````
     collectionView.registerCell(cellType: Cell.self)
     ````
     */
    func registerCell<T: UICollectionViewCell>(cellType: T.Type) {
        register(cellType, forCellWithReuseIdentifier: String(describing: cellType))
    }
    /**
     註冊 Nib Cell
     ### Old Example: ###
     ````
     collectionView.register(UINib(nibName: "Cell", bundle: nil), forCellWithReuseIdentifier: "Cell")
     ````
     ## Use example
     ````
     collectionView.registerNibCell(type: Cell.self)
     ````
     */
    func registerNibCell<T: UICollectionViewCell>(type: T.Type) {
        let className = String(describing: type)
        register(UINib(nibName: className, bundle: nil), forCellWithReuseIdentifier: className)
    }
    /**
     註冊 Nib Header
     ### Old Example: ###
     ````
     collectionView.register(UINib(nibName: "className", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "className")
     ````
     ## Use example
     ````
     collectionView.registerNibHeaderReusableView(type: Header.self)
     ````
     */
    func registerNibHeaderReusableView<T: UICollectionReusableView>(type: T.Type) {
        let className = String(describing: type)
        register(UINib(nibName: className, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: className)
    }
    /**
     註冊 Nib Footer
     ### Old Example: ###
     ````
     collectionView.register(UINib(nibName: "className", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "className")
     ````
     ## Use example
     ````
     collectionView.registerNibFooterReusableView(type: Footer.self)
     ````
     */
    func registerNibFooterReusableView<T: UICollectionReusableView>(type: T.Type) {
        let className = String(describing: type)
        register(UINib(nibName: className, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: className)
    }
    /**
     註冊 Header
     ### Old Example: ###
     ````
     collectionView.register(Header.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "className")
     ````
     ## Use example
     ````
     collectionView.registerHeaderReusableView(type: Header.self)
     ````
     */
    func registerHeaderReusableView<T: UICollectionReusableView>(type: T.Type) {
        let className = String(describing: type)
        register(T.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: className)
    }
    /**
     註冊 Nib Footer
     ### Old Example: ###
     ````
     collectionView.register(Footer.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "className")
     ````
     ## Use example
     ````
     collectionView.registerFooterReusableView(type: Footer.self)
     ````
     */
    func registerFooterReusableView<T: UICollectionReusableView>(type: T.Type) {
        let className = String(describing: type)
        register(T.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: className)
        
    }
    
    /**
     取得 Header
     ### Old Example: ###
     ````
     let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header", for: indexPath) as? HeaderClass
     ````
     ## Use example
     ````
     let header = collectionView.dequeueHeaderReusableView(type: Header.self,for: indexPath)
     ````
     */
    func dequeueHeaderReusableView<T: UICollectionReusableView>(with type: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: type), for: indexPath) as! T
    }
    /**
     取得 Footer
     ### Old Example: ###
     ````
     let Footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "Footer", for: indexPath) as? FooterClass
     ````
     ## Use example
     ````
     let Footer = collectionView.dequeueFooterReusableView(type: Footer.self,for: indexPath)
     ````
     */
    func dequeueFooterReusableView<T: UICollectionReusableView>(with type: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: String(describing: type), for: indexPath) as! T
    }
    /**
     取得 cell
     ### Old Example: ###
     ````
     let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? Cell
     ````
     ## Use example
     ````
     let cell = collectionView.dequeueReusableCell(type: Cell.self,for: indexPath)
     ````
     */
    func dequeueReusableCell<T: UICollectionViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: String(describing: type), for: indexPath) as! T
    }
    
}

public extension UICollectionView {
    /**
     reloadData 完畢後處理。
     用在ViewDidLoad上
     */
    func reloadData(completion: @escaping ()->()) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }) { _ in completion() }
    }
}

public extension UITableView {
    /**
     註冊 Cell
     ### Old Example: ###
     ````
     tableView.register(UITableViewCell.self, forCellWithReuseIdentifier: "cell")
     ````
     ## Use example
     ````
     tableView.registerCell(cellType: Cell.self)
     ````
     */
    func registerCell<T: UITableViewCell>(type: T.Type) {
        register(type, forCellReuseIdentifier: String(describing: type))
    }
    /**
     註冊 Nib Cell
     ### Old Example: ###
     ````
     tableView.register(UINib(nibName: "Cell", bundle: nil), forCellWithReuseIdentifier: "Cell")
     ````
     ## Use example
     ````
     tableView.registerNibCell(type: Cell.self)
     ````
     */
    func registerNibCell<T: UITableViewCell>(type: T.Type) {
        let className = String(describing: type)
        register(UINib(nibName: className, bundle: nil), forCellReuseIdentifier: className)
    }
    /**
     取得 cell
     ### Old Example: ###
     ````
     let cell = tableView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? Cell
     ````
     ## Use example
     ````
     let cell = tableView.dequeueReusableCell(type: Cell.self,for: indexPath)
     ````
     */
    func dequeueCell<T: UITableViewCell>(type: T.Type) -> T {
        return self.dequeueReusableCell(withIdentifier: String(describing: type)) as! T
    }
    /**
    取得 cell
    ### Old Example: ###
    ````
    let cell = tableView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? Cell
    ````
    ## Use example
    ````
    let cell = tableView.dequeueReusableCell(type: Cell.self,for: indexPath)
    ````
    */
    func dequeueReusableCell<T: UITableViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: String(describing: type), for: indexPath) as! T
    }
}

public extension UITableView {
    /**
     reloadData 完畢後處理。
     用在 ViewDidLoad 上
     */
    func reloadData(completion: @escaping ()->()) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }) { _ in completion() }
    }
}
