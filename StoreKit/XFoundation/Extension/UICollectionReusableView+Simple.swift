//
//  UICollectionReusableView+Simple.swift
//  StoreKit
//
//  Created by XXXXon 2020/7/21.
//  Copyright © 2020 sckj. All rights reserved.
//

import UIKit

enum XSupplementaryViewKind {
    case header
    case footer
}

extension UICollectionReusableView {
    
    /// 注册到重用队列
    /// - Parameters:
    ///   - collectionView: 目标collectionView
    ///   - kind: 字符串常量太长了，用枚举代替
    ///   - identifier: 重用标识，可以不传，默认为类名
    class func register(for collectionView:UICollectionView, kind:XSupplementaryViewKind = .header, identifier:String? = nil) {
        let kindString = kind == .header ? UICollectionView.elementKindSectionHeader : UICollectionView.elementKindSectionFooter
        var reuseIdentifier = identifier
        if reuseIdentifier == nil {
            reuseIdentifier = self.className
        }
        let path = Bundle.main.path(forResource: self.className, ofType: "nib")
        if path != nil {
            let nib = UINib(nibName: self.className, bundle: nil)
            collectionView.register(nib, forSupplementaryViewOfKind: kindString, withReuseIdentifier: reuseIdentifier!)
        } else {
            collectionView.register(self, forSupplementaryViewOfKind: kindString, withReuseIdentifier: reuseIdentifier!)
        }
    }
 
    
    /// 获取重用的SupplementaryView
    /// - Parameters:
    ///   - collectionView: 对应的collectionView
    ///   - kind: <#kind description#>
    ///   - indexPath: <#indexPath description#>
    ///   - identifier: <#identifier description#>
    /// - Returns: <#description#>
    class func dequeueReusable(for collectionView:UICollectionView, kind:XSupplementaryViewKind = .header, indexPath:IndexPath, identifier:String? = nil) -> UICollectionReusableView {
        let kindString = (kind == .header ? UICollectionView.elementKindSectionHeader : UICollectionView.elementKindSectionFooter)
        var reuseIdentifier = identifier
        if reuseIdentifier == nil {
            reuseIdentifier = self.className
        }
        return collectionView.dequeueReusableSupplementaryView(ofKind: kindString, withReuseIdentifier: reuseIdentifier!, for: indexPath)
    }
}
