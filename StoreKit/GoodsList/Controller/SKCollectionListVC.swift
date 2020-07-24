//
//  SKCollectionListVCViewController.swift
//  StoreKit
//
//  Created by XXXXon 2020/7/23.
//  Copyright © 2020 sckj. All rights reserved.
//

import UIKit

// 我的收藏-商品
class SKCollectionListVC: SKGoodsListVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return SKCollectionListController(data: object as! XBaseSectionModel<GoodsModel>)
    }
}
