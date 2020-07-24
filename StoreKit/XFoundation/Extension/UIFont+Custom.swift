//
//  UIFont+Custom.swift
//  
//
//  Created by Alex on 2020/2/13.
//  Copyright © 2020 Eric Wu. All rights reserved.
//

import UIKit

extension UIFont {
    
    @objc
    class func pingFangRegular(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont(name: "PingFangSC-Regular", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
    }
    
    @objc
    class func pingFangMedium(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont(name: "PingFangSC-Medium", size: fontSize) ?? UIFont.boldSystemFont(ofSize: fontSize)
    }

    @objc
    class func pingFangSemibold(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont(name: "PingFangSC-Semibold", size: fontSize) ?? UIFont.boldSystemFont(ofSize: fontSize)
    }

    @objc
    class func pingFangBold(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont(name: "PingFang-SC-Bold", size: fontSize) ?? UIFont.boldSystemFont(ofSize: fontSize)
    }
}
