//
//  XBaseViewController.swift
//  StoreKit
//
//  Created by XXXXon 2020/7/21.
//  Copyright © 2020 sckj. All rights reserved.
//

import UIKit

class XBaseVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = UIRectEdge.init()
        self.view.backgroundColor = .white
        
        setupSubviews()
        setupConstriants()
    }
    
    // 设置subviews
    func setupSubviews() {
        
    }
    
    // 设置约束
    func setupConstriants() {
        
    }
    
    // 界面基本都会发送一个请求
    func sendDefaultRequest() {
        
    }
}
