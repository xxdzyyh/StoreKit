//
//  VMAPIProtocols.swift
//  iOSAppNext
//
//  Created by XXXX on 2019/12/31.
//  Copyright © 2019 -. All rights reserved.
//

import Foundation


protocol LoginAPI {
    func login(_ phone: String, _ password: String, _ authToken: String) -> Single<Bool>
}

protocol ResetPwdAPI {
    func resetPwd(_ phone: String, _ password: String, _ code: String) -> Single<Bool>
}

protocol ModifyPwdAPI {
    func modifyPwd(oldPwd: String?, newPwd: String, code: String) -> Single<Bool>
}

protocol SignUpAPI {
    func signUp(_ phone: String, _ logPwd: String, _ payPwd: String, _ code: String, _ shareCode: String) -> Single<Bool>
}

protocol ModifyUserInfoAPI {
    func modifyUser(avatar: String?, nickname: String?) -> Single<Bool>
}

