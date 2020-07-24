//
//  YXBannerController.swift
//  SPARKVIDEO
//
//  Created by XXXXon 2020/7/15.
//

import UIKit
import FSPagerView
    
class YXBannerController: XBaseSectionController<[YXBannerModel]> {
    
    lazy var pagerView: FSPagerView = {
        let v = FSPagerView()
        v.delegate = self
        v.dataSource = self
        v.automaticSlidingInterval = 3
        v.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "Cell")
        return v
    }()
    
    override init(data: XBaseSectionModel<[YXBannerModel]>) {
        super.init(data: data)
        
        self.inset = UIEdgeInsets(top: 10, left: 12, bottom: 0, right: 12)
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        let width = collectionContext?.containerSize.width ?? SCREEN_WIDTH
        return CGSize(width: width - 24, height: 145)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext!.dequeueReusableCell(of: XBaseCollectionViewCell.self, for: self, at: index)
            
        cell.backgroundColor = .orange
        
        if self.pagerView.superview == nil {
            cell.contentView.addSubview(self.pagerView)
            self.pagerView.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
        }
        
        return cell
    }
    
}

extension YXBannerController : FSPagerViewDataSource {
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "Cell", at: index)
        if let items = self.data.dataList.first {
            cell.imageView?.sd_setImage(with: items[index].img.URLValue(), completed: nil)
            cell.imageView?.contentMode = .scaleAspectFill
        }
        return cell
    }
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        let items = self.data.dataList.first
        return items?.count ?? 0
    }
}

extension YXBannerController : FSPagerViewDelegate {
    
}
