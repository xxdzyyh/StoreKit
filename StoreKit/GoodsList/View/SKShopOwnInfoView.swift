//
//  SKShopOwnInfoView.swift
//  StoreKit
//
//  Created by XXXXon 2020/7/21.
//  Copyright © 2020 sckj. All rights reserved.
//

import UIKit

class SKShopOwnInfoView: UICollectionReusableView {

    @IBOutlet weak var headImageView: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    @IBOutlet weak var saleNumButton: TwoLineButton!
    
    @IBOutlet weak var scoreOneButtom: TwoLineButton!
    @IBOutlet weak var scoreTwoButton: TwoLineButton!
    @IBOutlet weak var scoreThreeButton: TwoLineButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
