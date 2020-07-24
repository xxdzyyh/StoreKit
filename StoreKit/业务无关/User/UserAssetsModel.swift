//
//  MyAssetsModel.swift
//  iOSAppNext
//
//  Created by XXXX on 2020/1/5.
//  Copyright © 2020 -. All rights reserved.
//

import Foundation
import HandyJSON

class UserAssetsModel: HandyJSON {
    var id: Int = 0
    var userId: Int = 0
    var createDate = Date(timeIntervalSince1970: 0)
    var updateDate = Date(timeIntervalSince1970: 0)
    var balanceCoin: Float = 0.0
    var warrantCoin: Float = 0.0
    var delFlag: Bool = false
    var insuranceCoin: Float = 0.0
    var payPass: String = ""
    var lockedCoin: Float = 0.0
    
    required init() {}
    
//    func mapping(mapper: HelpingMapper) {
//        TransformOf<Date, Int>(fromJSON: { (number) -> Date in
//                let timeInterval = TimeInterval(number ?? 0)
//                return Date.timeIntervalSince1970Number(number: timeInterval)
//            }, toJSON: { (createDate) -> Int in
//                return Int(createDate?.timeIntervalSince1970 ?? 0)
//            })
//        
//    }
}

