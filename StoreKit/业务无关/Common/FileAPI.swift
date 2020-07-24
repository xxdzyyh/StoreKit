//
//  FileAPI.swift
//  iOSAppNext
//
//  Created by XXXX on 2019/12/28.
//  Copyright © 2019 -. All rights reserved.
//

import Foundation
import Moya

enum FileAPI {
    case uploadFileData(_ data: Data, _ filename: String)
    case uploadFileAtFileURL(_ fileURL: URL)
    
    case uploadMultiFileData(_ infoArray: [(data: Data, filename: String)])
    case uploadMultiFileWithFileURL(_ fileURLArray: [URL])
}

extension FileAPI: TargetType {
    var path: String {
        switch self {
        case .uploadFileData, .uploadFileAtFileURL:
            return "/api/common/uploadImage"
        case .uploadMultiFileData, .uploadMultiFileWithFileURL:
            return "/api/common/uploadImages"
        }
    }
    
    var task: Task {
        var params = [String: Any]()
        switch self {
        case let .uploadFileData(data, filename):
            let ext = filename.split(separator: ".").last?.string ?? ""
            let mimeType = mimeTypeFor(pathExtension: ext)
            let formData = Moya.MultipartFormData(provider: .data(data), name: "file", fileName: filename, mimeType: mimeType)
//            var multipart = [formData]
//            if let token = currentUser?.token {
//                let tokenData = MultipartFormData(provider: .data(token.data(using: .utf8)!), name: "token")
//                multipart.append(tokenData)
//            }
            return .uploadCompositeMultipart([formData], urlParameters: params)
            
        case let .uploadFileAtFileURL(fileURL):
            let formData = Moya.MultipartFormData(provider: .file(fileURL), name: "file")
            return .uploadCompositeMultipart([formData], urlParameters: params)
            
        case let .uploadMultiFileData(infoArray):
            var multipart = [Moya.MultipartFormData]()
            for (data, filename) in infoArray {
                let ext = filename.split(separator: ".").last?.string ?? ""
                let mimeType = mimeTypeFor(pathExtension: ext)
                let formData = Moya.MultipartFormData(provider: .data(data), name: "file", fileName: filename, mimeType: mimeType)
                multipart.append(formData)
            }
            return .uploadCompositeMultipart(multipart, urlParameters: params)
            
        case let .uploadMultiFileWithFileURL(fileURLArray):
            var multipart = [Moya.MultipartFormData]()
            for fileURL in fileURLArray {
                let formData = Moya.MultipartFormData(provider: .file(fileURL), name: "file")
                multipart.append(formData)
            }
            return .uploadCompositeMultipart(multipart, urlParameters: params)
        }
    }
}
