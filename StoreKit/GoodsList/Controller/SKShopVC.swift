//
//  SKShopVC.swift
//  StoreKit
//
//  Created by XXXXon 2020/7/21.
//  Copyright © 2020 sckj. All rights reserved.
//

import UIKit

// https://lanhuapp.com/web/#/item/project/board/detail?pid=596a9822-e386-4078-9fbd-137edf3bfe2b&project_id=596a9822-e386-4078-9fbd-137edf3bfe2b&image_id=e45dd317-8b51-46f6-b4d3-b4fbcbb8cfc8
class SKShopVC: SKGoodsTwoColumnListVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return SKShopController.init(data: object as! XBaseSectionModel)
    }
}
