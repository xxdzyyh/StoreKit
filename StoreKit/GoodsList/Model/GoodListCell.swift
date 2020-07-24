//
//  GoodListCell.swift
//  iOSAppNext
//
//  on 2020/1/8.
//  Copyright © 2020 -. All rights reserved.
//

import UIKit
import SDWebImage
import SnapKit
import Rswift

class GoodListCell: XBaseCollectionViewCell {
    
    var model = GoodsModel() {
        didSet {
            updateUI()
        }
    }
    
    override func didInitialize() {
        super.didInitialize()
        
        contentView.addSubview(coverView)
        contentView.addSubview(lblNum)
        contentView.addSubview(lblName)
        contentView.addSubview(lblPrice)
        
        coverView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.width.equalTo(coverView.snp.height)
        }
        lblNum.snp.makeConstraints { (make) in
            make.left.top.equalTo(coverView)
        }
        lblName.snp.makeConstraints { (make) in
            make.top.equalTo(coverView.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        lblPrice.snp.makeConstraints { (make) in
            make.top.equalTo(lblName.snp.bottom).offset(10)
            make.left.right.equalTo(lblName)
            make.bottom.lessThanOrEqualToSuperview().offset(-10)
        }
    }

    func updateUI() {
        coverView.sd_setImage(with: URL(string: model.goodsImg), placeholderImage: nil)
        lblNum.text = "\(Double(Int.random(in: 0...1000000)).formatToLocalCny(1))人已经购买"
        lblName.text = "家居饰品治愈摆件 北欧风格台面礼品 家居饰品治愈摆件 北欧风格台面礼品"
        
        
        let price = "¥226 "
        let originalPrice = "¥328"
        
        let attr = NSMutableAttributedString(string: price, attributes: [
            NSAttributedString.Key.font : UIFont.pingFangBold(ofSize: 13),
            NSAttributedString.Key.foregroundColor : UIColor.white
        ])
        attr.append(NSAttributedString(string: originalPrice, attributes: [
            NSAttributedString.Key.font : UIFont.pingFangBold(ofSize: 10),
            NSAttributedString.Key.foregroundColor : UIColor.white.withAlphaComponent(0.2),
            NSAttributedString.Key.strikethroughStyle : NSNumber(value: 1)
        ]))
        
        lblPrice.attributedText = attr
    }
    
    
    //MARK: -  懒加载
    
    private lazy var coverView: SDAnimatedImageView = {
        let imgView = SDAnimatedImageView()
        imgView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        imgView.layer.cornerRadius = 4
        imgView.layer.masksToBounds =  true
        return imgView
    }()
    
    private lazy var lblName: QMUILabel = {
        let label = QMUILabel()
        label.textColor = .white
        label.font = .pingFangRegular(ofSize: 14)
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var lblNum: QMUILabel = {
        let label = QMUILabel()
        label.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        label.layer.cornerRadius = 4
        label.layer.masksToBounds = true
        label.layer.qmui_maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
        label.font = .pingFangRegular(ofSize: 10)
        label.textColor = .white
        label.contentEdgeInsets = UIEdgeInsets(top: 2, left: 6, bottom: 2, right: 6)
        return label
    }()
    
    private lazy var lblPrice: QMUILabel = {
        let label = QMUILabel()
        label.font = .pingFangRegular(ofSize: 10)
        return label
    }()
}
