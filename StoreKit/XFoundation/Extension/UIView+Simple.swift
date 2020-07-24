//
//  UIView+Simple.swift
//  SPARKVIDEO
//
//  Created by XXXXon 2020/7/23.
//

import UIKit

extension UIView {
    
    func addCornerRadius(cornerRadius:CGFloat) {
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
    }
    
    func addShadow(shadowColor:UIColor,shadowOpacity : Float = 0.3,shadowOffset : CGSize = CGSize(width:3,height:3),shadowRadius : CGFloat = 5.0) {
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowRadius = shadowRadius
    }
}
