//
//  TestVC.swift
//  StoreKit
//
//  Created by XXXXon 2020/7/23.
//  Copyright © 2020 sckj. All rights reserved.
//

import UIKit

class TestVC: XDemoTableVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = [
            [ActionKey.value : "SKGoodsListVC",ActionKey.key.rawValue:ActionType.ViewController,ActionKey.desc : "直播间弹出"],
            [ActionKey.value : "SKCollectionListVC",ActionKey.key.rawValue:ActionType.ViewController,ActionKey.desc : "我的收藏"],
            [ActionKey.value : "GoodsDetailViewController",ActionKey.key.rawValue:ActionType.ViewController,ActionKey.desc : "商品详情"],
            [ActionKey.value : "SKApplyShopVC",ActionKey.key.rawValue:ActionType.ViewController,ActionKey.desc : "店铺申请"],
            [ActionKey.value : "SKShopVC",ActionKey.key.rawValue:ActionType.ViewController],
            [ActionKey.value : "SKGoodsTwoColumnListVC",ActionKey.key.rawValue:ActionType.ViewController],
            [ActionKey.value : "YXGoodsListVC",ActionKey.key.rawValue:ActionType.ViewController,ActionKey.desc : "优选中心"],
            
        ];
    }
}
