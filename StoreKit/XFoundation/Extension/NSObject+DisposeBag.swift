//
//  UIViewController+Rx.swift
//  NMWeiShi
//
//  Created by XXXX on 2020/4/20.
//  Copyright © 2020 Eric Wu. All rights reserved.
//

import UIKit

extension NSObject {
    
    private struct AssociatedKeys {
        static var disposeBagKey = 0
    }
    
    var disposeBag: DisposeBag {
        get {
            if let bag = objc_getAssociatedObject(self, &AssociatedKeys.disposeBagKey) as? DisposeBag {
                return bag
            } else {
                let bag = DisposeBag()
                objc_setAssociatedObject(self, &AssociatedKeys.disposeBagKey, bag, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return bag
            }
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.disposeBagKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
}
