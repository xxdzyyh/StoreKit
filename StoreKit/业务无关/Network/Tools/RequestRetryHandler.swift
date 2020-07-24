//
//  RequestRetryHandler.swift
//  
//
//  Created by Alex on 2020/2/11.
//  Copyright © 2020 Eric Wu. All rights reserved.
//

import Alamofire

final class RequestRetryHandler: RequestInterceptor {
    
    private let lock = NSLock()
    private let maxRetryCount = 2
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        
        lock.lock(); defer { lock.unlock() }
        
        if let urlErr = request.task?.error as? URLError,
            urlErr.code == URLError.Code.timedOut,
            request.retryCount < maxRetryCount // 最多重试2次
        {
            if let url = request.request?.url {
                print("第\(request.retryCount + 1)次重试 \(url)")
            }
            completion(.retryWithDelay(0.5))
        } else {
            completion(.doNotRetry)
        }
    }

    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        #if SecurityData
        if let host = urlRequest.url?.host,
            AuthCredentialManger.shouldVerificationTrust(host: host) 
        {
            let wToken = AuthCredentialManger.avmpSign(urlRequest.httpBody)
            var urlRequest = urlRequest
            // aliyun 爬虫风险管理
            urlRequest.setValue(wToken, forHTTPHeaderField: "wToken")
        }
        #endif
        completion(.success(urlRequest))
    }
}
