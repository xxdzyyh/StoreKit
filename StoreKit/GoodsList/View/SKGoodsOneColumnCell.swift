//
//  SKGoodsOneColumnCell.swift
//  StoreKit
//
//  Created by XXXXon 2020/7/21.
//  Copyright © 2020 sckj. All rights reserved.
//

import UIKit

class SKGoodsOneColumnCell: XBaseCollectionViewCell {

    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var mainLabel: UILabel!

    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.buyButton.backgroundColor = UIColor.qd_tint
        self.buyButton.layer.cornerRadius = 11
        self.buyButton.layer.masksToBounds = true
        
        self.addLine()
    }

    @IBAction func onBuy(_ sender: Any) {
        
    }
    
    override func config(model: Any) {
        if model is GoodsModel {
            let data = model as! GoodsModel
            
            self.mainImageView.sd_setImage(with: data.goodsImg.URLValue())
            self.mainLabel.text = data.goodsName
            self.descLabel.text = data.goodsContext
            self.priceLabel.text = data.goodsPrice.priceValue()
        }
    }
}
