//
//  UserModel.swift
//  iOSAppNext
//
//  Created by XXXX on 2019/12/28.
//  Copyright © 2019 -. All rights reserved.
//

import Foundation
import HandyJSON

enum UserRealnameState: Int, HandyJSONEnum {
    case no = 0
    case completed = 1
    
    func displayName() -> String {
        switch self {
        case .no:       return "未认证"
        case .completed:  return "已认证"
        }
    }
}

enum UserGendor: Int, HandyJSONEnum {
    case unknown = -1
    case male = 1
    case female = 0
    
    func displayName() -> String {
        switch self {
        case .unknown:  return ""
        case .male:     return "男"
        case .female:   return "女"
        }
    }
}

@objcMembers
final class UserInfoModel: NSObject, HandyJSON {
    
    // 合伙人地区ID
    var agentAreaId: String = kEmptyString
    // 合伙人地区名称
    var agentAreaName: String = kEmptyString
    /// 合伙人ID
    var agentId: String = kEmptyString
    // 合伙人名称
    var agentName: String = kEmptyString
    // 合伙人活跃度
    var agentPower: String = kEmptyString
    // 合伙人星级
    var agentStar: String = kEmptyString
    
    var access_token: String = kEmptyString
    var refresh_token: String?
    var expires_in: Int = 0
    
    /// 主播星级
    var anchorStar : Int = 0
    
    /// App 平台用户ID
    var customerId: String = kEmptyString
    
    /// 网易云信 accId
    var accId: String = kEmptyString
    
    var vodAccId: String = kEmptyString
    /// 网易云信 token
    var neteaseToken: String = kEmptyString
    
    var teamNum: Int = 0
    
    /// 头像
    var customerHead: String = kEmptyString
    
    /// 是否好友(1是 0否)
    var flagFriend: Int = 0
    
    /// 是否关注(1是 0否)
    var flagFollow: Int = 0
    
    /// 关注数
    var followNum: Int = 0
    
    /// 实名认证(1已认证 0未认证)
    var flagAuth: UserRealnameState?
    
    func updateAuth(isAuth : Bool) {
        if isAuth {
            self.flagAuth = .completed
        } else {
            self.flagAuth = .no
        }
    }
    
    // 支付宝认证(0未认证 1已认证)
    var aliAuth : Bool = false
    
    /// 可用的星火币
    var coinNum: Float = 0.0
    
    /// 推荐码
    var inviteCode:String = kEmptyString
    
    /// 省ID
    var provinceId: String = kEmptyString
    
    /// 省名称
    var provinceName: String = kEmptyString
    
    /// 市ID
    var cityId: String = kEmptyString
    
    /// 市名称
    var cityName: String = kEmptyString
    
    /// 县区ID
    var areaId: String = kEmptyString
    
    /// 县区名
    var areaName: String = kEmptyString
    
    /// 作品数
    var worksNum: Int = 0
    
    /// 粉丝数
    var fansNum: Int = 0 
    
    var customerArea: String = kEmptyString
    var salfNum: Int = 0
    var teamPower: Float = 0.0
    
    /// 昵称
    var customerName: String = kEmptyString
    
    /// 身份证号
    var cardNum: String = kEmptyString
    
    /// 真名
    var realName: String = kEmptyString

    var authId : String = kEmptyString
    
    var customerPhone: String = kEmptyString
    var birthday:String = kEmptyString
    var createTime: String?
    
    /// 个性签名
    var customerMessage: String = kEmptyString
    var levelStar: CGFloat = 0
    var levelId: String = kEmptyString
    
    /// 点赞数
    var likeNum: Int = 0
    var usdtNum: Float = 0.0
    
    /// 年龄
    var customerAge: Int = 0
    var moneyNum: Float = 0.0
    var levelName: String = kEmptyString
    
    /// 性别
    var customerSex: UserGendor = .unknown
    
    var xhb_price: String = "0"
    
    // 存储数据
    // 可以实名认证次数
    var authNum : Int = 0
    
    
    convenience init?(userId: String?) {
        guard let uid = userId else { return nil }
        self.init()
        self.customerId = uid
    }
    
    func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.access_token <-- "token"
        
        mapper <<<
            self.fansNum <-- "beFollowNum"
    }

}
