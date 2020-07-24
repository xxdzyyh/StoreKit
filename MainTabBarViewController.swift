//
//  MainTabBarViewController.swift
//  StoreKit
//
//  Created by XXXXon 2020/7/21.
//  Copyright © 2020 sckj. All rights reserved.
//

import UIKit
import CYLTabBarController

class MainTabBarViewController: CYLTabBarController {

    init() {
        let loginVC = LoginViewController()
        let nav = UINavigationController(rootViewController: loginVC)
        
        let goodList = YXGoodsListVC()
        let nav1 = UINavigationController(rootViewController: goodList)
        
        let nav2 = UINavigationController(rootViewController: TestVC())
        
        let nav3 = UINavigationController(rootViewController: SKShopVC())
        
        let vcs: [UIViewController] = [
            nav,
            nav1,
            nav2,
            nav3
        ]
        
        let itemAttrs: [[AnyHashable : Any]] = [
                       [
                           CYLTabBarItemTitle: "首页",
            
                       ],
                       [
                           CYLTabBarItemTitle: "消息",
                       ],
                       [
                                                CYLTabBarItemTitle: "消息",
                                            ],
            [
                                                           CYLTabBarItemTitle: "消息",
                                                       ]
        ];
        
        super.init(viewControllers: vcs, tabBarItemsAttributes: itemAttrs)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(viewControllers: [UIViewController], tabBarItemsAttributes: [[AnyHashable : Any]], imageInsets: UIEdgeInsets, titlePositionAdjustment: UIOffset,context:String) {
        
        super.init(viewControllers: viewControllers, tabBarItemsAttributes: tabBarItemsAttributes, imageInsets: imageInsets, titlePositionAdjustment: titlePositionAdjustment, context: context)
    }
}
