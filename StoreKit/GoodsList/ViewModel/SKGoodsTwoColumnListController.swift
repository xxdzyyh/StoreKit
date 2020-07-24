//
//  SKGoodsTwoColumnListController.swift
//  StoreKit
//
//  Created by XXXXon 2020/7/21.
//  Copyright © 2020 sckj. All rights reserved.
//

import UIKit

class SKGoodsTwoColumnListController: XBaseSectionController<GoodsModel> {

    override init(data: XBaseSectionModel<GoodsModel>) {
        super.init(data: data)
        
        self.inset = UIEdgeInsets.init(top: 0, left: 12, bottom: 0, right: 12)
        self.minimumInteritemSpacing = 9
        self.minimumLineSpacing = 9
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext?.dequeueReusableCell(withNibName: "SKGoodsCell", bundle: nil, for: self, at: index) as! SKGoodsCell
        cell.config(model: self.data.dataList[index])
        return cell
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        let width = (collectionContext!.containerSize.width-24-9)/2
        return CGSize(width: width, height: width + SKGoodsCell.heightExceptImage())
    }
}
