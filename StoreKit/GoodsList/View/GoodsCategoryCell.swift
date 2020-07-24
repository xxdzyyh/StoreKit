//
//  GoodsCategoryCell.swift
//  ZJVideo
//
//  Created by XXXXon 2020/7/13.
//

import UIKit

class GoodsCategoryCell: UICollectionViewCell {

    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var mainLabel: UILabel!
    
    func config(model:GoodsCategoryItemModel) {
        mainLabel.text = model.classifyName
        mainImageView.sd_setImage(with: model.classifyImg.URLValue())
    }
}
