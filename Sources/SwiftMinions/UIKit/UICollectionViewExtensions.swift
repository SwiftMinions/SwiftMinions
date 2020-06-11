//
//  UICollectionViewExtensions.swift
//  SwiftMinions
//
//  Created by Ohlulu on 2020/5/30.
//  Copyright © 2020 SwiftMinions. All rights reserved.
//

import UIKit

// MARK: - Reigster/DequeueReuse Methods

public extension UICollectionView {
    
    /**
     Helper method to register collectionView cell.
     
     ### Chinese description
     方便的註冊 Cell
     
     ### Use example
     ```
     // origin
     collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
     
     // nes
     collectionView.registerCell(type: Cell.self)
     ```
     */
    func registerCell<T: UICollectionViewCell>(type: T.Type) {
        register(type, forCellWithReuseIdentifier: String(describing: type))
    }
    
    /**
     Helper method to register collectionView cell from nib.
     
     ### Chinese description
     方便的註冊 Nib Cell
     
     ### Use example
     ```
     // origin
     collectionView.register(UINib(nibName: "Cell", bundle: nil), forCellWithReuseIdentifier: "Cell")
     
     // new
     collectionView.registerNibCell(type: Cell.self)
     ```
     */
    func registerNibCell<T: UICollectionViewCell>(type: T.Type) {
        let className = String(describing: type)
        register(UINib(nibName: className, bundle: nil), forCellWithReuseIdentifier: className)
    }
    
    /**
     Helper method to register collectionView Header from xib.
     
     ### Chinese description
     方便的註冊 Nib Header
     
     ### Use example
     ```
     // origin
     collectionView.register(UINib(nibName: "className", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "className")
     
     // new
     collectionView.registerNibHeaderReusableView(type: Header.self)
     ```
     */
    func registerNibHeaderReusableView<T: UICollectionReusableView>(type: T.Type) {
        let className = String(describing: type)
        let nib = UINib(nibName: className, bundle: nil)
        register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: className)
    }
    
    /**
     Helper method to register collectionView Footer from xib.
     
     ### Chinese description
     方便的註冊 Nib Footer
     
     ### Use example
     ```
     // origin
     collectionView.register(UINib(nibName: "className", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "className")
     
     // new
     collectionView.registerNibFooterReusableView(type: Footer.self)
     ```
     */
    func registerNibFooterReusableView<T: UICollectionReusableView>(type: T.Type) {
        let className = String(describing: type)
        let nib = UINib(nibName: className, bundle: nil)
        register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: className)
    }
    
    /**
     Helper method to register collectionView Header.
     
     ### Chinese description
     方便的註冊 Header

     ### Use example
     ```
     // origin
     collectionView.register(Header.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "className")
     
     // new
     collectionView.registerHeaderReusableView(type: Header.self)
     ```
     */
    func registerHeaderReusableView<T: UICollectionReusableView>(type: T.Type) {
        let className = String(describing: type)
        register(T.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: className)
    }
    
    /**
     Helper method to register collectionView Footer.
     
     ### Chinese description
     方便的註冊 Footer

     ### Use example
     ```
     // origin
     collectionView.register(Footer.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "className")
     
     // new
     collectionView.registerFooterReusableView(type: Footer.self)
     ```
    */
    func registerFooterReusableView<T: UICollectionReusableView>(type: T.Type) {
        let className = String(describing: type)
        register(T.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: className)
        
    }
    
    /**
     Helper method to dequeue reuse header view.
     
     ### Chinese description
     方便的取得重用的 header view。
     
     ### Use example
     ```
     // origin
     let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header", for: indexPath) as? HeaderClass
     
     // new
     let header = collectionView.dequeueHeaderReusableView(type: Header.self,for: indexPath)
     ```
     */
    func dequeueHeaderReusableView<T: UICollectionReusableView>(with type: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: type), for: indexPath) as! T
    }
    
    /**
     Helper method to dequeue reuse footer view.
     
     ### Chinese description
     方便的取得重用的 footer view。
     
     ### Use example
     ```
     // origin
     let Footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "Footer", for: indexPath) as? FooterClass
     
     // new
     let Footer = collectionView.dequeueFooterReusableView(type: Footer.self,for: indexPath)
     ```
    */
    func dequeueFooterReusableView<T: UICollectionReusableView>(with type: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: String(describing: type), for: indexPath) as! T
    }
    
    /**
     Helper method to dequeue reuse cell.
     
     ### Chinese description
     方便的取得重用的 cell。
     
     ### Use example
     ```
     // origin
     let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? Cell
     
     // new
     let cell = collectionView.dequeueReusableCell(type: Cell.self,for: indexPath)
     ```
    */
    func dequeueReusableCell<T: UICollectionViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: String(describing: type), for: indexPath) as! T
    }
    
}

public extension UICollectionView {
    /**
     Get reload completion timing.
     
     ### Chinese description
     reloadData 處理完畢後的通知。
    */
    func reloadData(completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }) { _ in
            completion()
        }
    }
}
