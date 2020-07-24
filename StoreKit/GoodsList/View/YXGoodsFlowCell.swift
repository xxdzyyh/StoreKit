//
//  YXGoodsFlowCell.swift
//  ZJVideo
//
//  Created by XXXXon 2020/7/14.
//

import UIKit

class YXGoodsFlowCell: XBaseCollectionViewCell {

    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
    }
    
    func config(model:GoodsModel) {
        self.mainImageView.sd_setImage(with: model.goodsImg.URLValue())
        self.nameLabel.text = model.goodsName
        self.priceLabel.text = model.price.priceValue()
    }
}
