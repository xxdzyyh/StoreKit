//
//  GoodCategoryController.swift
//  ZJVideo
//
//  Created by XXXXon 2020/7/13.
//

import UIKit
import IGListKit
import Rswift

extension GoodsCategoryModel: ListDiffable {

    func diffIdentifier() -> NSObjectProtocol {
        return self
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return self === object ? true : self.isEqual(object)
    }
}

class GoodCategoryController: ListSectionController,ListSupplementaryViewSource {
    var data : GoodsCategoryModel?

    init(data:GoodsCategoryModel?) {
        super.init()
        self.data = data
        supplementaryViewSource = self
        self.minimumLineSpacing = 10
        self.minimumInteritemSpacing = 0
    }
    
    override func numberOfItems() -> Int {
        return data?.dataList?.count ?? 0
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        let width = collectionContext?.containerSize.width ?? 0
        let itemSize = floor(width / 5)
        return CGSize(width: itemSize, height: 64)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell : GoodsCategoryCell = collectionContext?.dequeueReusableCell(withNibName: "GoodsCategoryCell", bundle: nil, for: self, at: index) as? GoodsCategoryCell else {
            fatalError()
        }
        
        if data?.dataList != nil && data!.dataList!.count > 0 {
            cell.config(model: data!.dataList![index])
        }
        
        return cell
    }
    
    // MARK: ListSupplementaryViewSource
       
       func supportedElementKinds() -> [String] {
           return [UICollectionView.elementKindSectionHeader]
       }
       
       func viewForSupplementaryElement(ofKind elementKind: String, at index: Int) -> UICollectionReusableView {
           switch elementKind {
           case UICollectionView.elementKindSectionHeader:
               guard let view = collectionContext?.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, for: self, class: XEmptyCollectionReusableView.self, at: index) as? XEmptyCollectionReusableView else {
                                                                                           fatalError()
               }
               
               if view.subviews.count == 0 {
                    let imageView = UIImageView.init(image: R.image.mall_notice())
                    view.addSubview(imageView)
                    imageView.snp.makeConstraints { (make) in
                        make.centerY.equalToSuperview()
                        make.left.equalTo(12)
                    }
                    let label = UILabel.init()
                    label.text = "这里是公告的内容，公告的内容"
                    label.textColor = UIColor.colorWith(hex: 0xFFFFFF,alpha:0.6)
                    label.font = UIFont.systemFont(ofSize: 13)
                    view.addSubview(label)
                    label.snp.makeConstraints { (make) in
                        make.centerY.equalToSuperview()
                        make.left.equalTo(imageView.snp.right).offset(8)
                    }
               }
               
               return view
           case UICollectionView.elementKindSectionFooter:
               return UICollectionReusableView.init()
           default:
               fatalError()
           }
       }
       
       func sizeForSupplementaryView(ofKind elementKind: String, at index: Int) -> CGSize {
           if elementKind.elementsEqual(UICollectionView.elementKindSectionHeader) {
               return CGSize(width: collectionContext!.containerSize.width, height: 53)
           } else {
               return CGSize(width: 0, height: 0)
           }
       }
}

