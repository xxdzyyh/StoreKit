//
//  PageContainerModel.swift
//
//  Created by Alex on 2020/6/1.
//

import UIKit
import HandyJSON

class PageContainerModel<Item>: HandyJSON where Item: HandyJSON {
    var total: Int = 0
    var current: Int = 0
    var size: Int = 0
    var pages: Int = 0
    var records: [Item] = []
    
    required init() {}
}
