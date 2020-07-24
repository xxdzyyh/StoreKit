//
//  XLineView.swift
//  StoreKit
//
//  Created by XXXXon 2020/7/21.
//  Copyright © 2020 sckj. All rights reserved.
//

import UIKit

enum XLineStype {
    case defalut   // 实现
    case dash      // 虚线
}

enum XLinePostion : Int {
    case top
    case bottom
    case left
    case right// 直线
    case leftTopToRightBottom
    case leftBottomToRightTop// 斜线
}

class XLineView: UIView {
    var lineStyle : XLineStype = .defalut
        
    // 一像素宽，如果为true忽略lineWidth
    var isOnePixelWidth = false
    
    var lineWidth : CGFloat = 1
    
    // 开始间距
    var startInsert : CGFloat = 0
    // 结束间距
    var endInsert : CGFloat = 0
    // 线的位置
    var linePostion : XLinePostion = .top
    
    var lineColor : UIColor? = UIColor(red: 0.88, green: 0.88, blue: 0.88, alpha: 1)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        self.backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        
        if self.lineColor == nil {
            self.lineColor = UIColor(red: 0.88, green: 0.88, blue: 0.88, alpha: 1)
        }
        
        context?.setStrokeColor(self.lineColor!.cgColor)
        context?.setShouldAntialias(false)
    
        if self.lineStyle == .dash {
            context?.setLineDash(phase: 0, lengths: [1.0,1.0])
        }
        
        var pixelAdjustOffset: CGFloat = 0
        if isOnePixelWidth {
            lineWidth = 1/UIScreen.main.scale
            if (Int(lineWidth * UIScreen.main.scale)+1) % 2 == 0 {
                pixelAdjustOffset = (1/UIScreen.main.scale)/2
            }
        }
        context?.setLineWidth(lineWidth)
        var pt1,pt2 : CGPoint
    
        if isOnePixelWidth {
            switch self.linePostion {
            case .top:
                pt1 = CGPoint(x: self.startInsert, y: 1-pixelAdjustOffset)
                pt2 = CGPoint(x: self.width-self.endInsert, y: 1-pixelAdjustOffset)
            case .bottom:
                pt1 = CGPoint(x: self.startInsert, y: self.height-pixelAdjustOffset)
                pt2 = CGPoint(x: self.width-self.endInsert, y: self.height-pixelAdjustOffset)
            case .left:
                pt1 = CGPoint(x: 1-pixelAdjustOffset, y: self.startInsert)
                pt2 = CGPoint(x: 1-pixelAdjustOffset, y: self.height-endInsert)
            case .right:
                pt1 = CGPoint(x: self.width-pixelAdjustOffset, y: self.startInsert)
                pt2 = CGPoint(x: self.width-pixelAdjustOffset, y: self.height-endInsert)
            case .leftBottomToRightTop:
                pt1 = CGPoint(x: 0, y:self.height-pixelAdjustOffset)
                pt2 = CGPoint(x: self.width, y: 1-pixelAdjustOffset)
            case .leftTopToRightBottom:
                pt1 = CGPoint(x: 0, y:1-pixelAdjustOffset)
                pt2 = CGPoint(x: self.width, y: self.height-pixelAdjustOffset)
            }
        } else {
            switch self.linePostion {
            case .top:
                pt1 = CGPoint(x: self.startInsert, y: lineWidth/2)
                pt2 = CGPoint(x: self.width-self.endInsert, y: lineWidth/2)
            case .bottom:
                pt1 = CGPoint(x: self.startInsert, y: self.height-lineWidth/2)
                pt2 = CGPoint(x: self.width-self.endInsert, y: self.height-lineWidth/2)
            case .left:
                pt1 = CGPoint(x: lineWidth/2, y: self.startInsert)
                pt2 = CGPoint(x: lineWidth/2, y: self.height-endInsert)
            case .right:
                pt1 = CGPoint(x: self.width-lineWidth/2, y: self.startInsert)
                pt2 = CGPoint(x: self.width-lineWidth/2, y: self.height-endInsert)
            case .leftBottomToRightTop:
                pt1 = CGPoint(x: 0, y:self.height-pixelAdjustOffset)
                pt2 = CGPoint(x: self.width, y: 1-pixelAdjustOffset)
            case .leftTopToRightBottom:
                pt1 = CGPoint(x: 0, y:1-pixelAdjustOffset)
                pt2 = CGPoint(x: self.width, y: self.height-pixelAdjustOffset)
            }
        }
        
        context?.move(to: pt1)
        context?.addLine(to: pt2)
        context?.strokePath()
    }
}
