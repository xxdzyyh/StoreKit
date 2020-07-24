//
//  SKShopController.swift
//  StoreKit
//
//  Created by XXXXon 2020/7/21.
//  Copyright © 2020 sckj. All rights reserved.
//

import UIKit

class SKShopController: SKGoodsTwoColumnListController, ListSupplementaryViewSource {

    override init(data: XBaseSectionModel<GoodsModel>) {
        super.init(data: data)
        
        self.supplementaryViewSource = self
    }
    
    // MARK: ListSupplementaryViewSource
    func supportedElementKinds() -> [String] {
        return [UICollectionView.elementKindSectionHeader]
    }
    
    func viewForSupplementaryElement(ofKind elementKind: String, at index: Int) -> UICollectionReusableView {
        switch elementKind {
        case UICollectionView.elementKindSectionHeader:
            let view = collectionContext?.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,for: self,nibName: "SKShopOwnInfoView",bundle: nil,at: index) as! SKShopOwnInfoView
            
            return view
        default:
           return UICollectionReusableView.init()
        }
    }
    
    func sizeForSupplementaryView(ofKind elementKind: String, at index: Int) -> CGSize {
        if elementKind.elementsEqual(UICollectionView.elementKindSectionHeader) {
            return CGSize(width: collectionContext!.containerSize.width, height: 180)
        } else {
            return CGSize(width: 0, height: 0)
        }
    }

}
