//
//  BaseSectionController.swift
//  ZJVideo
//
//  Created by XXXXon 2020/7/15.
//

import UIKit
import IGListKit

class XBaseSectionController<Data>: ListSectionController {

    var data: XBaseSectionModel<Data> = XBaseSectionModel<Data>()
    init(data: XBaseSectionModel<Data>) {
        super.init()
        
        self.data = data
        self.minimumLineSpacing = 0
        self.minimumInteritemSpacing = 0
    }
    
    // MARK: ListSectionController
    override func numberOfItems() -> Int {
        return data.dataList.count
    }

    override func sizeForItem(at index: Int) -> CGSize {
        let width = collectionContext?.containerSize.width ?? 0
        let itemSize = floor(width)
        return CGSize(width: itemSize, height:itemSize)
    }
    
}
