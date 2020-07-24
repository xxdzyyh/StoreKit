//
//  XBaseCollectionViewCell.swift
//  SPARKVIDEO
//
//  Created by XXXXon 2020/7/15.
//

import UIKit

class XBaseCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        didInitialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        didInitialize()
    }

    func didInitialize() {
        
    }

    class func register(for collectionView:UICollectionView) {
        register(for: collectionView, identifier: self.className)
    }
    
    class func register(for collectionView:UICollectionView, identifier:String? = nil) {
        var reuseIdentifier = identifier
        if reuseIdentifier == nil {
           reuseIdentifier = self.className
        }
        let classBundle = Bundle.init(for: self)
        let path = classBundle .path(forResource: className, ofType: "nib")
        if path != nil {
            let nib = UINib(nibName: self.className, bundle: nil)
            collectionView.register(nib, forCellWithReuseIdentifier: reuseIdentifier!)
        } else {
            collectionView.register(self, forCellWithReuseIdentifier: reuseIdentifier!)
        }
    }
    
    class func cell(for collectionView:UICollectionView, identifier:String? = nil, indexPath:IndexPath) -> XBaseCollectionViewCell {
        var reuseIdentifier = identifier
        if reuseIdentifier == nil {
           reuseIdentifier = self.className
        }
        return collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier!, for: indexPath) as! XBaseCollectionViewCell
    }
    
    func config(model:Any) {
        
    }
}
