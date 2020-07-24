//
//  SKGoodsListController.swift
//  StoreKit
//
//  Created by XXXXon 2020/7/21.
//  Copyright © 2020 sckj. All rights reserved.
//

import UIKit

class SKGoodsListController: XBaseSectionController<GoodsModel> {

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext!.dequeueReusableCell(withNibName: "SKGoodsOneColumnCell", bundle: nil, for: self, at: index) as! SKGoodsOneColumnCell
        cell.config(model: self.data.dataList[index])
        return cell
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext?.containerSize.width ?? SCREEN_WIDTH, height: 136)
    }
}
