//
//  Double+NotRouding.swift
//  
//
//  Created by Alex on 2020/2/13.
//  Copyright © 2020 Eric Wu. All rights reserved.
//

import Foundation

extension Double {
    
    func priceValue() -> String {
        return self.string.retainDecimal(2)
    }
    
    func twoAfterPointValue() -> String {
        return self.string.retainDecimal(2)
    }
    
    func fourAfterPointValue() -> String {
        return self.string.retainDecimal(4)
    }
    
    
    
    /// 向下取整
    ///
    /// - Parameter bit: 保留小数位
    func floorValue(bit: Int = 0) -> Double {
        return notRounding(position: Int16(bit), roundingMode: .down).doubleValue
    }

    /// 向下取整

    func floorValue(bit: Int = 0) -> String {
        return notRounding(position: Int16(bit), roundingMode: .down).stringValue
    }

    /// 向上取整
    ///
    /// - Parameter bit: 保留小数位
    func ceilValue(bit: Int = 0) -> Double {
        return notRounding(position: Int16(bit), roundingMode: .up).doubleValue
    }

    func ceilValue(bit: Int = 0) -> String {
        return notRounding(position: Int16(bit), roundingMode: .up).stringValue
    }

    /*
     NSRoundPlain,   // Round up on a tie(四舍五入)
     NSRoundDown,    // Always down == truncate(只舍不入)
     NSRoundUp,      // Always up(只入不舍)
     NSRoundBankers  // on a tie round so last digit is even(也是四舍五入,这是和NSRoundPlain不一样,如果精确的哪位是5,
     它要看精确度的前一位是偶数还是奇数,如果是奇数,则入,偶数则舍,例如scale=1,表示精确到小数点后一位, NSDecimalNumber 为1.25时,
     NSRoundPlain结果为1.3,而NSRoundBankers则是1.2),下面是例子:
     https://www.jianshu.com/p/4a1477da1cb9
     */
    func notRounding(position: Int16, roundingMode: NSDecimalNumber.RoundingMode) -> NSDecimalNumber {
        let handler = NSDecimalNumberHandler(roundingMode: roundingMode, scale: Int16(position), raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: true)
        let value = String(self).retainDecimal(Int(position))
        let ouncesDecimal = NSDecimalNumber(string: value, locale: nil)
        let roundedOunces = ouncesDecimal.rounding(accordingToBehavior: handler)
        return roundedOunces
    }

    /// 格式化为，亿，千万，百万，万等单位
    func formatToLocalCny(_ position: Int16 = 2) -> String {
        if self >= 1000000000000 {
            let value = (self / 1000000000000).notRounding(position: position, roundingMode: .plain).stringValue
            return "\(value)万亿"
        } else if self >= 100000000 {
            let value = (self / 100000000).notRounding(position: position, roundingMode: .plain).stringValue
            return "\(value)亿"
//        } else if self >= 10000000 {
//            let value = (self / 10000000).notRounding(position: position, roundingMode: .plain).stringValue
//            return "\(value)千万"
        } else if self >= 10000 {
            let value = (self / 10000).notRounding(position: position, roundingMode: .plain).stringValue
            return "\(value)万"
        } else {
            return notRounding(position: position, roundingMode: .plain).stringValue
        }
    }
}
