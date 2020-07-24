//
//  SKGoodsCell.swift
//  StoreKit
//
//  Created by XXXXon 2020/7/21.
//  Copyright © 2020 sckj. All rights reserved.
//

import UIKit

/// 商品cell基类
class SKGoodsCell: XBaseCollectionViewCell {

    // 商品图片
    @IBOutlet var mainImageView : UIImageView?
    
    // 商品标题
    @IBOutlet var nameLabel : UILabel?
   
    // 描述
    @IBOutlet var descLabel : UILabel?
   
    // 价格
    @IBOutlet var priceLabel : UILabel?
    
    // 原始价格
    @IBOutlet var originPriceLabel : UILabel?
    
    // 销量
    @IBOutlet var countLabel : UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.backgroundColor = UIColor.qd_backgroundColorLighten
        self.layer.cornerRadius = 4
    }

    class func heightExceptImage() -> CGFloat {
        return 80
    }
    
    var model : GoodsModel?
    func config(model:GoodsModel) {
        self.model = model
        
        self.nameLabel?.text = model.goodsName
        self.priceLabel?.text = "￥" + model.goodsPrice.priceValue()
        self.mainImageView?.sd_setImage(with: model.goodsImg.URLValue())
        self.descLabel?.text = model.goodsContext
        self.originPriceLabel?.text = model.goodsCost.priceValue()
        self.countLabel?.text = "\(model.goodsSale)"
    }
}
