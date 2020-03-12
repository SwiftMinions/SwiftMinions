//
//  ViewController.swift
//  Example
//
//  Created by stephen on 2020/2/14.
//  Copyright © 2020 SwiftMinions. All rights reserved.
//

import UIKit
import SwiftMinions

class ViewController: UIViewController {

    private let testLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14.0)
        lbl.textColor = .black
        lbl.text = "NSTextAlignment NSTextAlignment NSTextAlignment"
        lbl.textAlignment = .center
        return lbl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        let height = testLabel.calculateHeight(width: UIFont.systemFontSize)
        print(height)
        // Do any additional setup after loading the view.
    }
}
