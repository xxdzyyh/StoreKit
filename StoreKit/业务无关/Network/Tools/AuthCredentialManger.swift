//
//  AuthCredentialManger.swift
//  NMWeiShi
//
//  Created by XXXX on 2020/5/6.
//

import Foundation

final class AuthCredentialManger {
    
    static func shouldVerificationTrust(host: String) -> Bool {
        host.lowercased() == URL(string: baseUrl)?.host?.lowercased()
    }
    
    #if SecurityData
    
    private static let avmpInit: Bool = {
        let avmpInit = JAQAVMPSignature.initialize()
        return avmpInit
    }()
    /// 进行阿里云签名
    class func avmpSign(_ params: Data?) -> String {
        if avmpInit {
            // https://help.aliyun.com/document_detail/86036.html?spm=a2c4g.11186623.6.574.2da22a5c6dbEaM
            if let signData = JAQAVMPSignature.avmpSign(3, input: params),
                let signResult = String(data: signData, encoding: .utf8) {
                return signResult
            }
        }
        return kEmptyString
    }
    #endif
}
