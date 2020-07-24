//
//  UIColor+Ext.swift
//  NMWeiShi
//
//  Created by XXXX on 2020/5/7.
//

import UIKit

extension UIColor {
    
    @objc
    public convenience init(hex: Int, alpha: CGFloat = 1) {
        let r = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((hex & 0xFF00) >> 8) / 255.0
        let b = CGFloat((hex & 0xFF)) / 255.0
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
    
    @objc
    public class func colorWith(hex: Int, alpha: CGFloat = 1) -> UIColor {
        return UIColor(hex: hex, alpha: alpha)
    }
    
    @objc(initWithHexStr:alpha:)
    public convenience init?(hex: String, alpha: CGFloat = 1) {
        let hex = hex.replacingOccurrences(of: "#", with: "")
        
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha = alpha
        let scanner = Scanner(string: hex)
        var hexValue: CUnsignedLongLong = 0
        if scanner.scanHexInt64(&hexValue) {
            switch hex.count {
            case 3:
                red = CGFloat((hexValue & 0xF00) >> 8) / 15.0
                green = CGFloat((hexValue & 0x0F0) >> 4) / 15.0
                blue = CGFloat(hexValue & 0x00F) / 15.0
            case 4:
                red = CGFloat((hexValue & 0xF000) >> 12) / 15.0
                green = CGFloat((hexValue & 0x0F00) >> 8) / 15.0
                blue = CGFloat((hexValue & 0x00F0) >> 4) / 15.0
                alpha = CGFloat(hexValue & 0x000F) / 15.0
            case 6:
                red = CGFloat((hexValue & 0xFF0000) >> 16) / 255.0
                green = CGFloat((hexValue & 0x00FF00) >> 8) / 255.0
                blue = CGFloat(hexValue & 0x0000FF) / 255.0
            case 8:
                red = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                blue = CGFloat((hexValue & 0x0000FF00) >> 8) / 255.0
                alpha = CGFloat(hexValue & 0x000000FF) / 255.0
            default:
                // Invalid RGB string, number of characters after '#' should be either 3, 4, 6 or 8
                return nil
            }
        } else {
            // "Scan hex error
            return nil
        }
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    @objc(colorWithHexStr:alpha:)
    public class func colorWith(hex: String, alpha: CGFloat = 1) -> UIColor? {
        return UIColor(hex: hex, alpha: alpha)
    }
    
    @objc
    public func hexString(withAlpha: Bool = false) -> String {
        let comps = cgColor.components!
        let r = Int(comps[0] * 255)
        let g = Int(comps[1] * 255)
        let b = Int(comps[2] * 255)
        var hexString: String = "#"
        
        hexString += String(format: "%02X%02X%02X", r, g, b)
        
        if withAlpha {
            let a = Int(comps[3] * 255)
            hexString += String(format: "%02X", a)
        }
        return hexString
    }
    
//    qmui_random
//    public class func random() -> UIColor {
//        let r = CGFloat.random(in: 0..<256) / 255
//        let g = CGFloat.random(in: 0..<256) / 255
//        let b = CGFloat.random(in: 0..<256) / 255
//        return UIColor(red: r, green: g, blue: b, alpha: 1)
//    }
}
