//
//  XBaseSectionModel.swift
//  ZJVideo
//
//  Created by XXXXon 2020/7/15.
//

import UIKit
import IGListKit

/**
 从目前来看，ListDiffable 的实现都是一样的，放到基类好了
 */
class XBaseSectionModel<Data>: NSObject,HandyJSON,ListDiffable {
    var dataList: [Data] = [Data]()

    required override init() {
        super.init()
    }
    
    init(dataList:[Data]) {
        super.init()
        self.dataList = dataList
    }
    
    // MARK: ListDiffable
    func diffIdentifier() -> NSObjectProtocol {
       return self
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
       return self === object ? true : self.isEqual(object)
    }
}

