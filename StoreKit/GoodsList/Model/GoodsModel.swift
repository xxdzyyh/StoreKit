//
//  GoodsModel.swift
//  iOSAppNext
//
//  on 2020/1/8.
//  Copyright © 2020 -. All rights reserved.
//

import Foundation

class GoodsModel: HandyJSON {
    var updateDate: Int = 0
    var createDate: Int = 0
    var delFlag: Bool = false
    var sales: Int = 0
    var warrantCoin: Double = 0.0

    var id: Int? = nil
    
    var goodsName: String = ""
    var partitionId: Int = 0
    var classifyId: String = ""
    var parentClassifyId: String = ""
    var businessId: String = ""
    var cuId: Int = 0
    // 商品封面图
    var goodsImg: String = ""
    var detailsImg: String = ""
    var insurancePrice: Float = 0.0
    var price: Double = 0.0
    var profits: Double = 0.0
    var courierPrice: Float = 0.0
    var stock: Int = 0
    var releaseStatus: Int = 0
    var remark: String? = nil
    var goodsNnit: String = ""
    
    // 商品id
    var goodsId : String = ""
    // 商品描述
    var goodsContext : String = ""
    // 商品原价
    var goodsCost : Double = 0.0
    // 商品售价
    var goodsPrice : Double = 0.0
    // 商品销量
    var goodsSale: UInt  = 0
    
    required init() {}
    
    convenience init(id: Int?) {
        self.init()
        self.id = id
    }
}

