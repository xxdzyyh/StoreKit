//
//  Error+isRequestCancelled.swift
//  
//
//  Created by Alex on 2020/2/11.
//  Copyright © 2020 Eric Wu. All rights reserved.
//

import Foundation

extension Error {
    func isRequestCancelled() -> Bool { false }
}

extension URLError {
    func isRequestCancelled() -> Bool {
        code == .cancelled
    }
}

extension MoyaError {
    func isRequestCancelled() -> Bool {
        switch self {
        case let .underlying(error, _):
            return (error as? URLError)?.isRequestCancelled() ?? false
        default: return false
        }
    }
}
