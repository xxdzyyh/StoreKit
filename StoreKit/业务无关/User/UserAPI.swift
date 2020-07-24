//
//  UserAPI.swift
//  iOSAppNext
//
//  Created by XXXX on 2019/12/24.
//  Copyright © 2019 -. All rights reserved.
//

import Foundation
import Moya

enum UserAPI {
        
    //  用户登录
    case login(phone: String, pass: String, authToken: String)
    
    //  用户注册 phone: 手机号, logPwd: 登录密码, payPwd: 安全密码, code: 短信验证码, inviteCode: 邀请码
    case register(phone: String, pass: String, payPwd: String, code: String, inviteCode: String)
    
    //  忘记密码
    case forgotPass(phone: String, pass: String, code: String)
    
    //  修改头像昵称 customerHead：头像地址，customerName：昵称
    case upUserHead(customerHead: String?, customerName: String?)
    
    // 修改性别
    case updateSex(sex : Int)
    
    // key "customerMessage"  个人介绍
    //
    //
    //
    case updateUserInfo(key: String,value: String)
    
    //  修改密码
    case upLoginPassword(oldPass: String, newPass: String, code: String)
    
    //  修改支付密码
    case modifyPayPass(code: String, newPass: String)
    
    //  获取系统配置
    case getSystemCongif(xhb: String)
    
    //  获取用户信息
    case getCustomerInformation
    
    //  过去用户真实信息
    case getRealInformation
    
    //  我的邀请码
    case getInviteCode
    
    //  团队统计
    case getTeamCount
    
    // 获取会员VodAccid
    case getVodAccid
    // 获取图片验证码
//    case getKey

    // 实名认证 trueName: 姓名, userCard: 身份证
    case autonymUser(trueName: String, userCard: String)
    
    // 实名认证 trueName: 姓名, userCard: 身份证 第三方返回 认证状态(1认证通过 2认证失败)
    case pushAuth(trueName: String, userCard: String, authResponse:String,authStatus : Int)

    case selectAuthNum
    
    // 实名认证，人工审核
    case pushAuthImage(realName:String, cardNum:String, frontImage:String, backImage:String,customerImage:String)
    
    // 个人等级列表
    case selectLevelList
    
    // 主播等级
    case selectAnchorList
    
    // 获取支付宝授权路径
    case getAlipayAuthUrl
    
    // 支付宝认证(id传code)
    case pushAliAuth(code:String)
}

extension UserAPI: TargetType {
    
    // 请求方式，在这里配置参数
    var task: Task {
        var params = [String: Any]()
        
        switch self {
            
        case let .login(phone, pass, authToken):
            params["phone"] = phone
            params["pass"] = pass
//            params["authToken"] = authToken
            
        case let .register(phone, pass, _, code, inviteCode):
            params["phone"] = phone
            params["pass"] = pass
            //params["payPwd"] = payPwd
            params["code"] = code
            params["inviteCode"] = inviteCode
            
        case let .forgotPass(phone, pass, code):
            params["phone"] = phone
            params["pass"] = pass
            params["code"] = code
            
        case let .upUserHead(customerHead, customerName):
            if let userHead = customerHead {
                params["customerHead"] = userHead
            }
            if let userName = customerName {
                params["customerName"] = userName
            }
            
        case let .upLoginPassword(oldPass, newPass, code):
            params["oldPass"] = oldPass
            params["newPass"] = newPass
            params["code"] = code
            
        case let .modifyPayPass(code, newPass):
            params["newPass"] = newPass
            params["code"] = code
            
        case let .getSystemCongif(xhb):
            params["id"] = xhb
            
        case .getCustomerInformation:
            break // 需要 token 参数
        case .getRealInformation:
            break
        case .getInviteCode:
            break
            
        case .getTeamCount:
            break
            
        case .selectAuthNum:
            break
            
        case .getVodAccid:
            break
            
        case .selectLevelList:
            break
            
        case let .updateSex(sex):
            params["customerSex"] = sex
            
        case let .updateUserInfo(key, value):
            params[key] = value
            
        case let .autonymUser(trueName, userCard):
            params["realName"] = trueName
            params["cardNum"] = userCard
            
        case let .pushAuth(trueName, userCard, authResponse, authStatus):
            params["realName"] = trueName
            params["cardNum"] = userCard
            params["authResponse"] = authResponse
            params["authStatus"] = authStatus
//            params["encryption"] = "\(currentUserToken ?? ""),\(trueName),\(userCard)".des()
        
        case let .pushAuthImage(realName, cardNum, frontImage, backImage, customerImage):
            params["realName"] = realName
            params["cardNum"] = cardNum
            params["frontImage"] = frontImage
            params["backImage"] = backImage
            params["customerImage"] = customerImage
            
        case .selectAnchorList:
            break
            
        case .getAlipayAuthUrl:
            break
        
        case let .pushAliAuth(code):
            params["id"] = code
        }
        
        // 不需要默认参数的在 case 内返回
        setDefaultParams(&params)
        return .requestParameters(parameters: params, encoding: URLEncoding.default)
    }
    
    // 通过statuscode过滤返回内容
    
    // 请求路径
    var path: String {
        switch self {
        case .login:
            return "/api/login/login"
        case .register:
            return "/api/login/registerUser"
        case .upLoginPassword:
            return "/api/login/modifyLoginPass"
        case .upUserHead:
            return "/api/login/modifyCustomerInfo"
        case .forgotPass:
            return "/api/login/forgetPass"
        case .modifyPayPass:
            return "/api/login/modifyPayPass"
        case .getCustomerInformation:
            return "/api/customer/selectCustomer"
        case .getSystemCongif:
            return "/api/common/selectConfig"
        case .getRealInformation:
            return "/api/customer/selectAuth"
            
        case .getInviteCode:
            return "/api/customer/selectInvite"

        case .getVodAccid:
            return "/api/login/getVodAccid"
            
        case .autonymUser:
            return "/api/customer/pushAuth"
            
        case .pushAuth:
            return "/api/customer/pushAuth"
            
        case .getTeamCount:
            return "/api/customer/selectTeamCount"
            
        case .selectAuthNum:
            return "/api/customer/selectAuthNum"
            
        case .updateSex:
            return "/api/login/modifyCustomerInfo"
       
        case .updateUserInfo:
            return "/api/login/modifyCustomerInfo"
            
        case .pushAuthImage:
            return "/api/customer/pushAuthImage"
            
        case .selectLevelList:
            return "/api/customer/selectLevelList"
            
        case .selectAnchorList:
            return "/api/customer/selectAnchorList"

        case .getAlipayAuthUrl:
            return "/api/alipay/getAliLoginSgin"
            
        case .pushAliAuth:
            return "/api/alipay/pushAliAuth"
        }
    }
}

