//
//  UserManager.swift
//  iOSAppNext
//
//  Created by XXXX on 2019/12/24.
//  Copyright © 2019 -. All rights reserved.
//

import Foundation
import HandyJSON
import YYCategories
import KeychainSwift
import RxSwift

@objcMembers
final class UserManager: NSObject {
    
    static let shared = UserManager()
    
    private lazy var keychain = KeychainSwift(keyPrefix: UserManager.kTouchFaceIDPrefix)
    
    @objc var user: UserInfoModel? {
        didSet {
            if let _ = user {
                saveUserInfo()
            } else {
                deleteUserInfo()
            }
        }
    }
    
    private override init() {
        super.init()
        user = userInfoFromCache()
        cleanupUserInfoIfReinstalled()
        
    }
    
    // 用户重装以后清除keychain中的信息
    @objc func cleanupUserInfoIfReinstalled() {
        if user == nil || username == nil {
            pwdLogin = nil
            pwdPay = nil
        }
    }
    
    @discardableResult
    @objc func doAutoLogin() -> Bool {
//        if let _ = user?.access_token {
//            if NTESLoginManager.shared().doAutoLogin() {
//                return true
//            } else {
//                resetBioMetricsGuide()
//                cleanupUserInfo()
//                return false
//            }
//        } else {
//            return false
//        }
        return true
    }
    
    @objc func notifyLoginSuccess() {
        requestUserInfo()
        NotificationCenter.default.post(name: UserManager.Notifications.didLogin, object: nil)
    }
    
    @objc func loginExpired() {
        // IM 退出登录
//        NTESLoginManager.shared().logout { (_) in
//            NotificationCenter.default.post(name: UserManager.Notifications.loginExpired, object: nil)
//        }
    }
    
    @objc func logout(_ completion: ((Error?)->Void)? = nil) {
        // IM 退出登录
//        NTESLoginManager.shared().logout(completion)
    }
    
    func nimDidLogout() {
        resetBioMetricsGuide()
        cleanupUserInfo()
        NotificationCenter.default.post(name: UserManager.Notifications.didLogout, object: nil)
    }
    
    @objc func cleanupUserInfo() {
        user = nil
        pwdPay = nil
        // 默认记住用户名和密码
    }
    
    //MARK: - Request User Info
    private var isLoadingUserInfo = false
    
    func requestUserInfo() {
        if !isLoggedIn || isLoadingUserInfo { return }
        isLoadingUserInfo = true

        let api = UserAPI.getCustomerInformation
        Network.request(api, dataType: [String:Any].self, showErrorMsg: false)
            .do(onSuccess: { [weak self] (data) in
                self?.updateUserInfo(from: data)
            }, onDispose: { [weak self] in
                self?.isLoadingUserInfo = false
            })
            .subscribe()
            .disposed(by: disposeBag)
    }
    
    func requesRealtUserInfo() {
        if !isLoggedIn || isLoadingUserInfo { return }
        isLoadingUserInfo = true

        let api = UserAPI.getRealInformation
        Network.request(api, dataType: [String:Any].self, showErrorMsg: false)
            .do(onSuccess: { [weak self] (data) in
//                self?.updateUserInfo(from: data)
                self?.updateUserInfoWithAuthInfo(auth: data)
            }, onDispose: { [weak self] in
                self?.isLoadingUserInfo = false
            })
            .subscribe()
            .disposed(by: disposeBag)
    }
    
    
    func updateUserInfoWithAuthInfo(auth:[String:Any]?) {
        if let auth = auth {
            if let realName = auth["realName"] as? String {
                self.user?.realName = realName
            }
            
            if let cardNum = auth["cardNum"] as? String {
                self.user?.cardNum = cardNum
            }
            
            if let authId = auth["authId"] as? String {
                self.user?.authId = authId
            }
        }
    }
    
    var tempDispose : Disposable?
    func getVodAccId() {
        let api = UserAPI.getVodAccid
        tempDispose = Network.request(api, dataType: ResponseModel<String>.self).subscribe(onSuccess: { (res) in
            if res.data != nil {
                self.user?.vodAccId = res.data!
            }
            self.tempDispose?.dispose()
        }) { (error) in
            self.tempDispose?.dispose()
        }
    }
    
    
    /// 获取系统配置
    func getSystemConfig() {
        
        let api = UserAPI.getSystemCongif(xhb: "XMB_PRICE")

        Network.request(api, dataType: JSON.self)
            .do(onSuccess: { (result) in
                self.xhb_price = result.data?.string
            })
        .subscribe()
        .disposed(by: disposeBag)
    }

}



//MARK: - Cache User Data
extension UserManager {
    // User Defaults Keys
    private static let kUserInfoKey = "App_UserInfo_Key"
    private static let kUserNameKey = "App_UserName_Key"
    // Keychain Keys
    private static let kTouchFaceIDPrefix = "\(bundleId).touchfaceid"
    private static let kTouchFaceIDPwd = "\(kTouchFaceIDPrefix).pwd"
    private static let kTouchFaceIDPayPwd = "\(kTouchFaceIDPrefix).payPwd"
    private static let kXHB_Price = "xhb_price"
    
    //MARK: user info
    private func saveUserInfo() {
        if let json = user?.toJSONString(),
            let data = json.data(using: .utf8) {
            UserDefaults.standard.set(data, forKey: UserManager.kUserInfoKey)
        }
    }
    
    private func updateUserInfo(from dict: [String: Any]?) {
        if var user = self.user, let dict = dict, dict.count > 0 {
            JSONDeserializer.update(object: &user, from: dict)
            saveUserInfo()
            NotificationCenter.default.post(name: UserManager.Notifications.didUpdateUserInfo, object: nil)
        }
    }
    
    private func userInfoFromCache() -> UserInfoModel? {
        guard let data = UserDefaults.standard.data(forKey: UserManager.kUserInfoKey),
            let json = String(data: data, encoding: .utf8)
            else { return nil }
        return JSONDeserializer<UserInfoModel>.deserializeFrom(json: json)
    }
    
    private func deleteUserInfo() {
        UserDefaults.standard.removeObject(forKey: UserManager.kUserInfoKey)
        NotificationCenter.default.post(name: UserManager.Notifications.didUpdateUserInfo, object: nil)
    }
    
    //MARK: username
    @objc var username: String? {
        get { UserDefaults.standard.string(forKey: UserManager.kUserNameKey) }
        set {
            if let username = newValue {
                UserDefaults.standard.set(username, forKey: UserManager.kUserNameKey)
            } else {
                UserDefaults.standard.removeObject(forKey: UserManager.kUserNameKey)
            }
        }
    }
    
    //MARK: 登录密码
    @objc var pwdLogin: String? {
        get { keychain.getEncrypt(UserManager.kTouchFaceIDPwd) }
        set { keychain.setEnctypt(newValue, forKey: UserManager.kTouchFaceIDPwd) }
    }
    
    //MARK: 支付密码(指纹/面容ID支付)
    @objc var pwdPay: String? {
        get { keychain.getEncrypt(UserManager.kTouchFaceIDPayPwd) }
        set { keychain.setEnctypt(newValue, forKey: UserManager.kTouchFaceIDPayPwd) }
    }
    
    /// 重设开启指纹登陆引导
    @objc func resetBioMetricsGuide() {
        let key = kIgnoredOpenBioMetrics + (currentUser?.customerId ?? kEmptyString)
        UserDefaults.standard.removeObject(forKey: key)
    }
    
    /// 市场参考
    @objc var xhb_price: String? {
        get { keychain.getEncrypt(UserManager.kXHB_Price) }
        set { keychain.setEnctypt(newValue, forKey: UserManager.kXHB_Price) }
    }
}


extension KeychainSwift {
    // AES 加密 Key
    private static let kAESKey = Data(bytes: [69, 104, 78, 104, 84, 113, 87, 113, 72, 114, 98, 55, 54, 74, 73, 56, 78, 118, 100, 104, 112, 119, 52, 72, 88, 55, 115, 66, 75, 80, 109, 51] as [UInt8], count: 32) //  "EhNhTqWqHrb76JI8Nvdhpw4HX7sBKPm3".data(using: .utf8)
    
    @discardableResult
    fileprivate func setEnctypt(_ value: String?, forKey key: String) -> Bool {
        if let data = value?.data(using: .utf8) as NSData?,
            let encrypted = data.aes256Encrypt(withKey: KeychainSwift.kAESKey, iv: nil) {
            return set(encrypted, forKey: key)
        } else {
            return delete(key)
        }
    }
    
    @discardableResult
    fileprivate func getEncrypt(_ key: String) -> String? {
        if let data = getData(key) as NSData?,
            let decrypted = data.aes256DecryptWithkey(KeychainSwift.kAESKey, iv: nil) {
            return String(data: decrypted, encoding: .utf8)
        }
        return nil
    }
}

//MARK: - Notifications
extension UserManager {
    
    @objc static let DidLoginNotification = "UserManager.Notifications.didLogin"
    @objc static let DidCancelLoginNotification = "UserManager.Notifications.didCancelLogin"
    @objc static let DidLogoutNotification = "UserManager.Notifications.didLogout"
    @objc static let LoginExpiredNotification = "UserManager.Notifications.loginExpired"
    @objc static let DidUpdateUserInfoNotification = "UserManager.Notifications.didUpdateUserInfo"
    
    struct Notifications {
        // 现在IM登录成功和账号密码登录成功都发送 didLogin 通知，但是IM登录成功很可能token没有
        static let didLogin = Notification.Name(rawValue: DidLoginNotification)
        static let didCancelLogin = Notification.Name(rawValue: DidCancelLoginNotification)
        static let didLogout = Notification.Name(rawValue: DidLogoutNotification)
        static let loginExpired = Notification.Name(rawValue: LoginExpiredNotification)
        
        static let didUpdateUserInfo = Notification.Name(rawValue: DidUpdateUserInfoNotification)
    }
    
    static func observeUserLogin(_ block: @escaping (Notification)->Void, disposedBy disposeBag: DisposeBag) {
        return NotificationCenter.default.rx
            .notification(UserManager.Notifications.didLogin)
            .subscribe(onNext: block)
            .disposed(by: disposeBag)
    }
    
    static func observeUserCancelLogin(_ block: @escaping (Notification)->Void, disposedBy disposeBag: DisposeBag) {
        return NotificationCenter.default.rx
            .notification(UserManager.Notifications.didCancelLogin)
            .subscribe(onNext: block)
            .disposed(by: disposeBag)
    }
    
    static func observeUserLogout(_ block: @escaping (Notification)->Void, disposedBy disposeBag: DisposeBag) {
        return NotificationCenter.default.rx
            .notification(UserManager.Notifications.didLogout)
            .subscribe(onNext: block)
            .disposed(by: disposeBag)
    }
    
    static func observeUserExpired(_ block: @escaping (Notification)->Void, disposedBy disposeBag: DisposeBag) {
        return NotificationCenter.default.rx
            .notification(UserManager.Notifications.loginExpired)
            .throttle(.seconds(1), latest: true, scheduler: MainScheduler.instance)
            .subscribe(onNext: block)
            .disposed(by: disposeBag)
    }
    
    static func observeUserInfoUpdate(_ block: @escaping (Notification)->Void, disposedBy disposeBag: DisposeBag) {
        return NotificationCenter.default.rx
            .notification(UserManager.Notifications.didUpdateUserInfo)
            .throttle(.seconds(1), latest: true, scheduler: MainScheduler.instance)
            .subscribe(onNext: block)
            .disposed(by: disposeBag)
    }
}
