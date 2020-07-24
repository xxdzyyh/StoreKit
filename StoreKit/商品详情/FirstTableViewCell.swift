//
//  FirstTableViewCell.swift
//  NMWeiShi
//
//  Created by XXXX on 2020/5/14.
//

import UIKit

class FirstTableViewCell: XBaseTableCell {
    
    /// 原价
    @IBOutlet weak var priceLabel: QMUILabel!
    
    /// 折扣价
    @IBOutlet weak var volumePrice: QMUILabel!
    
    /// 商品说明
    @IBOutlet weak var infoLabel: QMUILabel!
    
    /// 快递费
    @IBOutlet weak var courierLabel: QMUILabel!
    
    /// 月销
    @IBOutlet weak var pinLabel: QMUILabel!
    
    /// 地址
    @IBOutlet weak var addressLabel: QMUILabel!
    
    /// 领劵
    @IBOutlet weak var getPreferentialBtn: QMUIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func clickGetPreferentialBtn(_ sender: QMUIButton) {
        print("获取优惠券")

    }

    
}
