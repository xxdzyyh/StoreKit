//
//  String+Numbers.swift
//  
//
//  Created by Alex on 2020/2/16.
//  Copyright © 2020 Eric Wu. All rights reserved.
//

import Foundation

extension String {
    
    public init(number: Int, padding: Int) {
        let format = "%0\(padding)d"
        self.init(format: format, number)
    }
    
    //MARK: - Decimal Number
    public func removeDecimalLastZeros() -> String {
        var result = self
        while result.contains(".") && result.hasSuffix("0") {
            let index = result.index(result.endIndex, offsetBy: -1)
            result = String(result[..<index])
        }
        if result.hasSuffix(".") {
            let index = result.index(result.endIndex, offsetBy: -1)
            result = String(result[..<index])
        }
        return result
    }
    
    public func retainDecimal(_ digits: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = digits
        formatter.maximumFractionDigits = digits
        formatter.usesGroupingSeparator = false
        var decimal = NSDecimalNumber(string: isEmpty ? "0" : self, locale: nil)
        if decimal.decimalValue == .nan {
            decimal = NSDecimalNumber(string: "0")
        }
        if let value = formatter.string(for: decimal) {
            return value
        }
        return "0"
    }
    
    func toDecimalNumber() -> NSDecimalNumber {
        let num = NSDecimalNumber(string: self, locale: NSLocale(localeIdentifier: "zh_Hans_CN"))
        if num == NSDecimalNumber.notANumber {
            return .zero
        }
        return num
    }
    
    // MARK: - Int, Double, Float, Int8, Int16, Int32, Int64
    
    public var boolValue: Bool? {
        let trueValues = ["true", "yes", "1"]
        let falseValues = ["false", "no", "0"]
        let lowerSelf = lowercased()
        if trueValues.contains(lowerSelf) {
            return true
        } else if falseValues.contains(lowerSelf) {
            return false
        } else {
            return nil
        }
    }
    
    public var doubleValue: Double {
        let decimal = NSDecimalNumber(string: self, locale: nil)
        return decimal == .notANumber ? .zero : decimal.doubleValue
    }
    
    public var floatValue: Float {
        return Float(doubleValue)
    }
    
    public var intValue: Int {
        return Int(doubleValue)
    }
    
    public var uIntValue: UInt? {
        return UInt(doubleValue)
    }
    
    public var int8Value: Int8 {
        return Int8(doubleValue)
    }
    
    public var uInt8Value: UInt8 {
        return UInt8(doubleValue)
    }
    
    public var int16Value: Int16 {
        return Int16(doubleValue)
    }
    
    public var uInt16Value: UInt16 {
        return UInt16(doubleValue)
    }
    
    public var int32Value: Int32 {
        return Int32(doubleValue)
    }
    
    public var uInt32Value: UInt32 {
        return UInt32(doubleValue)
    }
    
    public var int64Value: Int64 {
        return Int64(doubleValue)
    }
    
    public var uInt64Value: UInt64 {
        return UInt64(doubleValue)
    }
}
