//
//  YXGoodsListController.swift
//  ZJVideo
//
//  Created by XXXXon 2020/7/14.
//

import UIKit

class YXGoodsListMdoel : NSObject {
    var isFlow : Bool = false
    var title : String?
    var desc : String?
    var dataList : [GoodsModel]?
}

extension YXGoodsListMdoel: ListDiffable {

    func diffIdentifier() -> NSObjectProtocol {
        return self
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return self === object ? true : self.isEqual(object)
    }
}

class YXGoodsListController : ListSectionController,ListSupplementaryViewSource {
    var data : YXGoodsListMdoel?

    init(data:YXGoodsListMdoel?) {
        super.init()
        self.data = data
        supplementaryViewSource = self
        self.minimumLineSpacing = 0
        self.minimumInteritemSpacing = 0
        self.inset = UIEdgeInsets(top: 0, left: 12, bottom: 10, right: 12)
    }
    
    override func numberOfItems() -> Int {
        return data?.dataList?.count ?? 0
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        let width = collectionContext?.containerSize.width ?? 0
        let itemSize = floor((width-24)/3)
        return CGSize(width: itemSize, height: 210)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell : YXGoodsCell = collectionContext?.dequeueReusableCell(withNibName: "YXGoodsCell", bundle: nil, for: self, at: index) as? YXGoodsCell else {
            fatalError()
        }
        
        if data?.dataList != nil && data!.dataList!.count > 0 {
            cell.config(model: data!.dataList![index])
        }
        
        cell.backgroundColor = UIColor.colorWith(hex: 0x0F1327)
        
        return cell
    }
    
    // MARK: ListSupplementaryViewSource
    
    func supportedElementKinds() -> [String] {
        return [UICollectionView.elementKindSectionHeader]
    }
    
    func viewForSupplementaryElement(ofKind elementKind: String, at index: Int) -> UICollectionReusableView {
        switch elementKind {
        case UICollectionView.elementKindSectionHeader:
            guard let view = collectionContext?.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                                     for: self,
                                                                                     nibName: "YXGoodsSectionSupplyView",
                                                                                     bundle: nil,
                                                                                     at: index) as? YXGoodsSectionSupplyView else {
                                                                                        fatalError()
            }
            
            if let title = data?.title {
                if title.count > 2 {
                    let pre = String(title[..<title.index(title.startIndex,offsetBy: 2)])
                    let suf = String(title[title.index(title.startIndex,offsetBy: 2)..<title.index(title.startIndex,offsetBy: title.count)])
                    let att = NSMutableAttributedString.init()
                    let s1 = NSAttributedString.init(string: pre,attributes: [NSAttributedString.Key.foregroundColor : UIColor.qd_tint])
                    let s2 = NSAttributedString.init(string: suf,attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
                    
                    att.append(s1)
                    att.append(s2)
                    view.mainLabel.attributedText = att
                } else {
                    view.mainLabel.text = title
                }
                
            } else {
               view.mainLabel.text = data?.title
            }
            
            view.descLabel.text = data?.desc
            
            return view
        case UICollectionView.elementKindSectionFooter:
            return UICollectionReusableView.init()
        default:
            fatalError()
        }
    }
    
    func sizeForSupplementaryView(ofKind elementKind: String, at index: Int) -> CGSize {
        if elementKind.elementsEqual(UICollectionView.elementKindSectionHeader) {
            return CGSize(width: collectionContext!.containerSize.width, height: 58)
        } else {
            return CGSize(width: 0, height: 0)
        }
    }
}
