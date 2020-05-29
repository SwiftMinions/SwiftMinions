//
//  UITableViewExtensions.swift
//  SwiftMinions
//
//  Created by Ohlulu on 2020/5/29.
//  Copyright © 2020 SwiftMinions. All rights reserved.
//

import UIKit

public extension UITableView {
    /**
     Helper method to register tableView cell.
     
     ## Chinese description
     方便的註冊 Cell
     
     ## Use example
     ````
     // origin
     tableView.register(UITableViewCell.self, forCellWithReuseIdentifier: "cell")
     
     // new
     tableView.registerCell(cellType: Cell.self)
     ````
     */
    func registerCell<T: UITableViewCell>(type: T.Type) {
        register(type, forCellReuseIdentifier: String(describing: type))
    }
    
    /**
     Helper method to register tableView cell from xib.
     
     ## Chinese description
     方便的註冊 Nib Cell
     
     ## Use example
     ````
     // origin
     tableView.register(UINib(nibName: "Cell", bundle: nil), forCellWithReuseIdentifier: "Cell")
     
     // new
     tableView.registerNibCell(type: Cell.self)
     ````
     */
    func registerNibCell<T: UITableViewCell>(type: T.Type) {
        let className = String(describing: type)
        register(UINib(nibName: className, bundle: nil), forCellReuseIdentifier: className)
    }
    
    /**
     Helper method to dequeue reuse cell without IndexPath.
     
     ## Chinese description
     方便的取得 cell（無 IndexPath）。
     
     ## Use example
     ````
     // origin
     let cell = tableView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? Cell
     
     // new
     let cell = tableView.dequeueReusableCell(type: Cell.self,for: indexPath)
     ````
    */
    func dequeueCell<T: UITableViewCell>(type: T.Type) -> T {
        dequeueReusableCell(withIdentifier: String(describing: type)) as! T
    }
    
    /**
     Helper method to dequeue reuse cell.
     
     ## Chinese description
     方便的取得 cell。

     ## Use example
     ````
     // origin
     let cell = tableView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? Cell
     
     // new
     let cell = tableView.dequeueReusableCell(type: Cell.self,for: indexPath)
     ````
    */
    func dequeueReusableCell<T: UITableViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        dequeueReusableCell(withIdentifier: String(describing: type), for: indexPath) as! T
    }
    
    /**
     Get reload completion timing.
     
     ## Chinese description
     reloadData 處理完畢後的通知。
     */
    func reloadData(_ completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }) { _ in
            completion()
        }
    }
    
    /**
     Get last IndexPath.
     
     ## Chinese description
     取得最後的 IndexPath。
    */
    var lastIndexPath: IndexPath? {
        if numberOfSections == 0 {
            return nil
        }
        
        let row = max(numberOfRows(inSection: numberOfSections) - 1 ,0)
        return IndexPath(row: row, section: numberOfSections - 1)
    }

    /**
     Get last section.
     
     ## Chinese description
     取得最後的 section。
    */
    var lastSection: Int? {
        return numberOfSections > 0 ? numberOfSections - 1 : nil
    }

    /**
     Safely scroll to IndexPath.
     
     ## Chinese description
     安全地滾動到IndexPath。
     */
    func safeScrollToRow(at indexPath: IndexPath, at scrollPosition: UITableView.ScrollPosition, animated: Bool) {
        if indexPath.section >= numberOfSections
            || indexPath.row >= numberOfRows(inSection: indexPath.section) {
            return
        }
        scrollToRow(at: indexPath, at: scrollPosition, animated: animated)
    }
}
