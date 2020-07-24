//
//  StoreApi.swift
//  StoreKit
//
//  Created by XXXXon 2020/7/21.
//  Copyright © 2020 sckj. All rights reserved.
//

import UIKit

enum StoreApi {
    case selectGoodsList
}

extension StoreApi : TargetType {
    // 请求方式，在这里配置参数
    var task: Task {
        var params = [String: Any]()
        switch self {
        case .selectGoodsList:
            break
        }
        // 不需要默认参数的在 case 内返回
        setDefaultParams(&params)
        return .requestParameters(parameters: params, encoding: URLEncoding.default)
    }
    
    var path: String {
        switch self {
        case .selectGoodsList:
            return "/api/mall/selectGoodsList"
        default:
            return ""
        }
    }
}
