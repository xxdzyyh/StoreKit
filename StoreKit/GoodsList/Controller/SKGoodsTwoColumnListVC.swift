//
//  SKGoodsTwoColumnListVC.swift
//  StoreKit
//
//  Created by XXXXon 2020/7/21.
//  Copyright © 2020 sckj. All rights reserved.
//

import UIKit

class SKGoodsTwoColumnListVC: SKGoodsListVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return SKGoodsTwoColumnListController.init(data: object as! XBaseSectionModel)
    }

}
