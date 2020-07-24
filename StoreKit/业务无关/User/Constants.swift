//
//  Constants.swift
//  iOSAppNext
//
//  Created by XXXX on 2019/12/23.
//  Copyright © 2019 -. All rights reserved.
//

import Foundation
import AdSupport

// 一些常量

public let CRCOMPS_DATE: [Calendar.Component] = [.year, .month, .day]
public let CRCOMPS_TIME: [Calendar.Component] = [.hour, .minute, .second]

let bundleId = String(CFBundleGetIdentifier(CFBundleGetMainBundle()))
let buildNum = Bundle.main.infoDictionary![kCFBundleVersionKey as String] as! String
let appVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
let appName = Bundle.main.infoDictionary!["CFBundleDisplayName"] as! String
let appScheme = "fingershortvideo"

let LOCALE_CN = NSLocale(localeIdentifier: "zh_Hans_CN")

let CRIdfv = UIDevice.current.identifierForVendor?.uuidString
let CRIdfa: String = {
    var idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
    if #available(iOS 10.0, *) { // ios10更新之后一旦开启了 设置->隐私->广告->限制广告跟踪之后  获取到的idfa将会是一串00000
        if !ASIdentifierManager.shared().isAdvertisingTrackingEnabled {
            if let idfv = CRIdfv {
                idfa = idfv // idfv 是一定可以获取到的
            }
        }
    }
    return idfa
}()


var SCREEN_WIDTH: CGFloat {
    return UIScreen.main.bounds.width
}
var SCREEN_HEIGHT: CGFloat {
    return UIScreen.main.bounds.height
}

let screenWidthScale = SCREEN_WIDTH / 375.0

let ONE_PIXEL = 1 / UIScreen.main.scale


let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
let libDir = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).first!
let cachesDir = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first!
let tmpDir = NSTemporaryDirectory()

public typealias CRVoidBlock = () -> Void
public typealias CRCompletionTask = CRVoidBlock



//MARK: - <#mark#>
let kWechatText = "微信"
let kAipayText = "支付宝"
let kBankText = "银行卡"
let kFPM = "FPM"
let kDGPT = "DGPT"
let kUSDT = "USDT"

// MARK: - NSUserDefault key

let kUserInfoKey = "kUserInfoKey"
let kContentType = "Content-Type"
let kAuthorization = "Authorization"
let kSelectedPaymentType = "kSelectedPaymentType"//选中币币交易=1，法币=2，3买, 4卖
let kIgnoredGuideVersionKey = "kIgnoredGuideVersionKey"
let kIgnoredOrderGuideKey = "kIgnoredOrderGuideKey" //订单引导
let kLaunchedOnceKey = "kLaunchedOnceKey"
let kClientIpKey = "kClientIpKey"
let kFirstTimeKey = "kFirstTimeKey"
//touch face ID
let kTouchFaceIDPrefix = "kTouchFaceIDPrefix"
let kTouchFaceIDPassword = "kTouchFaceIDPassword"
let kTouchFaceIDPayPwd = "kTouchFaceIDPayPwd"

let kIgnoredOpenBioMetrics = "kIgnoredOpenBioMetrics"//忽略开启指纹引导

let kIgnoredThirdpartyPrompt = "kIgnoredThirdpartyPrompt"//忽略跳入第三方应用提示

// MARK: - file name
let kFILE_SettingsDefault = "SettingsDefault.plist"

//MARK: - 常用正则表达式

/// 正则表达式：判断是否是十进制数字
/// - Parameter accuracy: 最大精度
public func REPatternDecimal(accuracy: Int) -> String {
    "^[0-9]*.?[0-9]{0,\(accuracy)}$"
}

/// 正则表达式：判断是否符合身份证号格式
let REPatternChinaIDCard = "(^\\d{15}$)|(^\\d{17}([0-9]|X)$)"
/// 输入时判断使用
let REPatternChinaIDCardForInput = "(^\\d{0,15}$)|(^\\d{0,17}([0-9]|X)$)"

/* 正则表达式：判断是否符合手机号格式
 * 
 * 移动号段: 134,135,136,137,138,139,147,150,151,152,157,158,159,170,178,182,183,184,187,188
 * 联通号段: 130,131,132,145,155,156,170,171,175,176,185,186
 * 电信号段: 133,149,153,170,173,177,180,181,189
 * "^[1][3-9][0-9]{9}$"
 */
let REPatternMobilePhoneNumber = "^(\\+\\d{2}-)?(\\d{2,3}-)?([1][3-9][0-9]{9})$"
/// 输入时判断使用
let REPatternMobilePhoneNumberForInput = "^(\\+\\d{0,2}-)?(\\d{0,3}-)?([1][3-9][0-9]{0,9})$"

/// 正则表达式：判断是否符合邮箱地址格式
let REPatternEmail = "^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$"
/// 输入时判断使用
//let REPatternEmailForInput = "^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$"

/*
 * 判断是否符合 URL 格式
 * // (https?|ftp|file)://[-A-Za-z0-9+&@#/%?=~_|!:,.;]+[-A-Za-z0-9+&@#/%=~_|]
 */
let REPatternURL = "(https?)://[-A-Za-z0-9+&@#/%?=~_|!:,.;]+[-A-Za-z0-9+&@#/%=~_|]"


// 判断是否是整数
let REPatternInteger = "^\\d+$"


//MARK: - Symbols

public let kBracketBigBegin = "{"
public let kBracketBigEnd = "}"
public let kSeparatorComma = ","
public let kSeparatorSlash = "/"
public let kSeparatorDot = "."
public let kSymbolQuestion = "?"
public let kSeparatorBitAnd = "&"
public let kSymbolEqual = "="
public let kWhitespace = " "
public let kEmptyString = ""
public let kSeparatorSolidDot = "●"


