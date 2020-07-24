//
//  UserManager+Requests.swift
//  
//
//  Created by Alex on 2020/2/27.
//  Copyright © 2020 Eric Wu. All rights reserved.
//

import Foundation
import RxSwift
//MARK: - VMAPIProtocols Default Implementations

/// 修改密码
final class ModifyPwd: ModifyPwdAPI {
    
    func modifyPwd(oldPwd: String?, newPwd: String, code: String) -> Single<Bool> {
        let api = UserAPI.upLoginPassword(oldPass: oldPwd ?? "", newPass: newPwd, code: code)
        return Network.request(api, dataType: JSON.self, showSuccessMsg: true)
            .map({ (res) -> Bool in
                return res.code == 0
            })
    }
}

/// 修改支付密码
final class ModifyPayPwd: ModifyPwdAPI {
    
    func modifyPwd(oldPwd: String? = nil, newPwd: String, code: String) -> Single<Bool> {
        let api = UserAPI.modifyPayPass(code: code, newPass: newPwd)
        return Network.request(api, dataType: JSON.self, showSuccessMsg: true)
            .map({ (res) -> Bool in
                return res.code == 0
            })
    }
}

/// 登录
extension UserManager: LoginAPI {
    
    /// 先登录 App 服务器，再使用登录接口返回的云信 accid 和 token 登录网易云信服务器
    func login(_ phone: String, _ password: String, _ authToken: String) -> Single<Bool> {
        
        username = phone
        pwdLogin = nil
        
        let api = UserAPI.login(phone: phone, pass: password, authToken: authToken)
        return Network.request(api, dataType: UserInfoModel.self)
            .flatMap({ [weak self] (user) -> Single<UserInfoModel?> in
                guard let selfStrong = self, let user = user else {
                    return .just(nil)
                }
                
                selfStrong.user = user
                
                return Single<UserInfoModel?>.create { (observer) -> Disposable in
                    observer(.success(user))
                    return Disposables.create {}
                }
            })
            .do(onSuccess: { [weak self] (user) in
                guard let selfStrong = self,
                    let _ = user?.access_token
                    else {
                        return
                }
                selfStrong.user = user
                selfStrong.pwdLogin = password
                NotificationCenter.default.post(name: UserManager.Notifications.didLogin, object: nil)
                selfStrong.requestUserInfo()
            })
            .map({ $0?.access_token != nil })
    }
}

/// 充值密码
extension UserManager: ResetPwdAPI {
    
    func resetPwd(_ phone: String, _ password: String, _ code: String) -> Single<Bool> {
        let api = UserAPI.forgotPass(phone: phone, pass: password, code: code)
        return Network.request(api, dataType: JSON.self, showSuccessMsg: true)
            .map { (res) -> Bool in
                return res.code == kAPISuccessCode
        }
    }
}

/// 注册
extension UserManager: SignUpAPI {
    
    /// 注册时后台会创建一个网易云信账户，登录时先登录 App 服务器，再使用登录接口返回的云信 accid 和 token 登录网易云信服务器
    func signUp(_ phone: String, _ logPwd: String, _ payPwd: String, _ code: String, _ inviteCode: String) -> Single<Bool> {
        
        username = phone
        pwdLogin = nil
        
        let api = UserAPI.register(phone: phone, pass: logPwd, payPwd: payPwd, code: code, inviteCode: inviteCode)
        return Network.request(api, dataType: JSON.self)
            .do(onSuccess: { [weak self] (_) in
                self?.pwdLogin = logPwd
            })
            .map({ (res) -> Bool in
                return res.code == kAPISuccessCode
            })
    }
}
/// 修改用户资料
extension UserManager: ModifyUserInfoAPI {
    
    func modifyUser(avatar: String? = nil, nickname: String? = nil) -> Single<Bool> {
        let api = UserAPI.upUserHead(customerHead: avatar, customerName: nickname)
        return Network.request(api, dataType: JSON.self, showSuccessMsg: true)
            .map { (res) -> Bool in
                return res.code == kAPISuccessCode
        }
    }
}

/// 编辑用户头像
extension UserManager {
    
    func updateUserAvatar(with image: UIImage) -> Single<Bool> {
        return upload(image: image)
            .flatMap({ (imgUrl) -> Single<JSON> in
                let api = UserAPI.upUserHead(customerHead: imgUrl, customerName: nil)
                return Network.request(api, dataType: JSON.self, showSuccessMsg: true)
            })
            .map({ $0.code == kAPISuccessCode })
    }
    
//    func upPaymentCode(_ qr: UIImage, type: PayMethod) -> Single<Bool> {
//        return upload(image: qr)
//            .flatMap({ (imgUrl) -> Single<JSON> in
//                let api = UserAPI.upPaymentCode(type: type.rawValue, url: imgUrl)
//                return Network.request(api, dataType: JSON.self, showSuccessMsg: true)
//            })
//            .map({ $0.code == kAPISuccessCode })
//    }
//    
//    //MARK: - 上传图片
//    func uploadWithProgress(image: UIImage) -> Observable<(Double, String?)> {
//        let data = image.jpegData(compressionQuality: 0.8) ?? Data()
//        let api = FileAPI.upload(data, "image.jpg")
//        return Network.requestWithProgress(api, dataType: JSON.self)
//            .map({ ($0, $1?["url"].string) })
//    }
    
    func upload(image: UIImage) -> Single<String> {
        let data = image.jpegData(compressionQuality: 0.8) ?? Data()
        let api = FileAPI.uploadFileData(data, "image.jpg")
        return Network.request(api, dataType: String.self)
            .map({ $0 ?? "" })
    }
}
