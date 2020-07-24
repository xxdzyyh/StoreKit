//
//  Observable+ProgressResponse.swift
//  
//
//  Created by Alex on 2020/2/11.
//  Copyright © 2020 Eric Wu. All rights reserved.
//

import Foundation

extension ObservableType where Element == ProgressResponse {
    
    /**
     Returns the `Response` if the `statusCode` falls within the specified range.
     
     - parameters:
     - statusCodes: The range of acceptable status codes.
     */
    func filter<R: RangeExpression>(statusCodes: R) -> Observable<Element> where R.Bound == Int {
        flatMap { (e) in
            Observable<Element>.create { (observer) -> Disposable in
                if e.completed {
                    do {
                        _ = try e.response?.filter(statusCodes: statusCodes)
                        observer.onNext(e)
                    } catch {
                        observer.onError(error)
                    }
                } else {
                    observer.onNext(e)
                }
                return Disposables.create()
            }
        }
    }
    
    /**
     Returns the `Response` if it has the specified `statusCode`.
     
     - parameters:
     - statusCode: The acceptable status code.
     */
    func filter(statusCode: Int) -> Observable<Element> {
        filter(statusCodes: statusCode...statusCode)
    }
    
    /**
     Returns the `Response` if the `statusCode` falls within the range 200 - 299.
     */
    func filterSuccessfulStatusCodes() -> Observable<Element> {
        filter(statusCodes: 200...299)
    }
    
    /**
     Returns the `Response` if the `statusCode` falls within the range 200 - 399.
     
     - throws: `MoyaError.statusCode` when others are encountered.
     */
    func filterSuccessfulStatusAndRedirectCodes() -> Observable<Element> {
        filter(statusCodes: 200...399)
    }
}
