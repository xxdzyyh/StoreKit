//
//  SKGoodsListVC.swift
//  StoreKit
//
//  Created by XXXXon 2020/7/21.
//  Copyright © 2020 sckj. All rights reserved.
//

import UIKit

class SKGoodsListVC: XBaseIGListVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        let goods = GoodsModel()
        
        goods.goodsName = "家居饰品治愈摆件 北欧风格台面礼品空间装饰 一起飞/吉象/勇敢的心"
        goods.price = 123.6666
        goods.goodsSale = 456
        goods.goodsContext = "领劵60 到手226"
        goods.goodsImg = "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1594734290738&di=7012e9bfed72527f40af158d443446c1&imgtype=0&src=http%3A%2F%2F5b0988e595225.cdn.sohucs.com%2Fimages%2F20171002%2Fc8a480faad78426b8955e91eed3c4715.jpeg"
        
        let dataSource = SKGoodsListModel()
        
        dataSource.dataList = [goods,goods,goods]
        
        self.data = [dataSource]
        self.adapter.reloadData(completion: nil)
    }

    override func setupSubviews() {
        super.setupSubviews()
        
        self.view.backgroundColor = UIColor.qd_background
    }
    
    override func setupConstriants() {
        super.setupConstriants()
    }
    
    override func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return SKGoodsListController(data: object as! XBaseSectionModel)
    }
    
}
