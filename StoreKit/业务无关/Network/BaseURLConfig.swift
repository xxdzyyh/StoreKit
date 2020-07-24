//
//  BaseURLConfig.swift
//  iOSAppNext
//
//  Created by XXXX on 2019/12/25.
//  Copyright © 2019 -. All rights reserved.
//

import Moya
import MobileCoreServices

/*
 ⚠️⚠️⚠️⚠️⚠️⚠️ ATTENTION: ⚠️⚠️⚠️⚠️⚠️⚠️
 如果需要上架 App Store，请务必使用 https 请求
 并且删除 info.plist 中的 App Transport Security Settings -> Allow Arbitrary Loads
 */


var baseUrl: String {
    "http://www.baidu.com"
}

var baseShareUrl: String {
    "http://www.baidu.com"
}

//MARK: - TargetType 默认实现
// 如果需要定制，请在对应的 Target 中重写
extension TargetType {
    
    // 默认域名，如果有连接其他域名的 api，请在对应的 Target 中重写
    var baseURL: URL {
        return URL(string: baseUrl)!
    }
    
    // 默认请求方式，如果需要定制请在对应的 Target 中重写
    var method: Moya.Method {
        return .post
    }
    
    // 默认单元测试模拟数据
    var sampleData: Data {
        return "".data(using: .utf8)!
    }
    
    // 默认请求头
    var headers: [String : String]? {
        return ["Content-Type": "application/x-www-form-urlencoded; charset=UTF-8"]
    }
    
}

//MARK: - TargetType 工具方法
extension TargetType {
    
    // 设置默认请求参数，按需调用
    func setDefaultParams(_ params: inout [String: Any]) {
        params["token"] = currentUser?.access_token
    }
    
    // 根据后缀查询 mime type
    func mimeTypeFor(pathExtension: String) -> String {
        if
            let id = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension as CFString, nil)?.takeRetainedValue(),
            let contentType = UTTypeCopyPreferredTagWithClass(id, kUTTagClassMIMEType)?.takeRetainedValue()
        {
            return contentType as String
        }

        return "application/octet-stream"
    }
}

