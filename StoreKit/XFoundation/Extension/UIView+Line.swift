//
//  UIView+Line.swift
//  StoreKit
//
//  Created by XXXXon 2020/7/21.
//  Copyright © 2020 sckj. All rights reserved.
//

import UIKit

extension UIView {

    /// 添加一条线
    /// - Parameters:
    ///   - position: 线的位置
    ///   - startInsert: 起始内间距，默认0
    ///   - endInsert: 结束内间距，默认0
    ///   - lineWidth: 线的宽，默认1pt
    ///   - isOnePixelWidth: 一像素线，默认false
    ///   - ignoreIfExist: 相同位置如果已经存在XLineView，忽略本次添加
    func addLine(position:XLinePostion = .bottom,lineColor:UIColor = UIColor.qd_separator,startInsert:CGFloat = 0,endInsert:CGFloat = 0,lineWidth:CGFloat = 1,isOnePixelWidth:Bool = false,ignoreIfExist:Bool = true) {
        
        let startTag = 5432
        if ignoreIfExist {
            let res = self.viewWithTag(startTag + position.rawValue)
            if res != nil && res is XLineView {
                return
            }
        }
        
        var rect = CGRect.zero
        let v = XLineView.init(frame: rect)
        switch position {
        case .top:
            rect = CGRect(x: 0, y: 0, width: self.width, height: lineWidth)
        case .bottom:
            rect = CGRect(x: 0, y: self.height-lineWidth, width: self.width, height: lineWidth)
        case .left:
            rect = CGRect(x: 0, y: 0, width: lineWidth, height: self.height)
        case .right:
            rect = CGRect(x: self.width-lineWidth, y: 0, width: lineWidth, height: self.height)
        case .leftTopToRightBottom:
            rect = self.bounds
        case .leftBottomToRightTop:
            rect = self.bounds
        }
        v.startInsert = startInsert
        v.endInsert = endInsert
        v.lineWidth = lineWidth
        v.isOnePixelWidth = isOnePixelWidth
        v.tag = startTag + position.rawValue
        v.frame = rect
        v.lineColor = lineColor
        self.addSubview(v)
    }
    
    func removeLine(in position:XLinePostion) {
        let startTag = 5432
        let res = self.viewWithTag(startTag + position.rawValue)
        if res != nil && res is XLineView {
            res?.removeFromSuperview()
            return
        }
    }
}
