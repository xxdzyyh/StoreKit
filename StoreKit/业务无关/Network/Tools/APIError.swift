//
//  APIError.swift
//  iOSAppNext
//
//  Created by XXXX on 2019/12/25.
//  Copyright © 2019 -. All rights reserved.
//

import Foundation

let kAPISuccessCode = 0
let kAccessTokenExpiredCode = 2

struct APIError: Swift.Error {
    let code: Int
    let msg: String
    
    init(code: Int, msg: String) {
        self.code = code
        self.msg = msg
    }
    
    var localizedDescription: String {
        msg
    }
}


extension URLError {
    
    init(statusCode: Int) {
        self.init(.unknown)
    }
}
