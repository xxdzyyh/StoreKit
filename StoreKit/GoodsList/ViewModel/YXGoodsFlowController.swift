//
//  YXGoodsFlowController.swift
//  ZJVideo
//
//  Created by XXXXon 2020/7/14.
//

import UIKit

class YXGoodsFlowController: ListSectionController,ListSupplementaryViewSource {
    var data : YXGoodsListMdoel?

    init(data:YXGoodsListMdoel?) {
        super.init()
        self.data = data
        supplementaryViewSource = self
        self.minimumLineSpacing = 0
        self.minimumInteritemSpacing = 0
        self.inset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
    }

    override func numberOfItems() -> Int {
        return data?.dataList?.count ?? 0
    }

    override func sizeForItem(at index: Int) -> CGSize {
        let width = collectionContext?.containerSize.width ?? 0
        let itemSize = floor((width-24)/2)
        let h = (210+index%2*20)
        return CGSize(width: itemSize, height:CGFloat(h))
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
            
            view.mainLabel.text = data?.title
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
            return CGSize(width: collectionContext!.containerSize.width, height: 68)
        } else {
            return CGSize(width: 0, height: 0)
        }
    }
}
