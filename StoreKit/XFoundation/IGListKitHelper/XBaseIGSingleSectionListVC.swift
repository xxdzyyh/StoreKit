//
//  XBaseIGSingleSectionListVC.swift
//  StoreKit
//
//  Created by XXXXon 2020/7/24.
//  Copyright © 2020 sckj. All rights reserved.
//

import UIKit
import IGListKit

/// 只有一个section，使用IGListKit实现CollectionView设置
class XBaseIGSingleSectionListVC: XBaseCollectionVC, ListAdapterDataSource, ListSingleSectionControllerDelegate {
    
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        adapter.collectionView = self.collectionView
        adapter.dataSource = self
    }

    //  MARK: ListAdapterDataSource
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return dataList.map { $0 as! ListDiffable }
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        let configureBlock = { (item: Any, cell: UICollectionViewCell) in
            guard let cell = cell as? XEmptyCollectionCell else { return }
        
            cell.config(model: item)
        }

        let sizeBlock = { (item: Any, context: ListCollectionContext?) -> CGSize in
           guard let context = context else { return CGSize() }
           return CGSize(width: context.containerSize.width, height: 44)
        }
        let sectionController = ListSingleSectionController(nibName: "XEmptyCollectionCell",
                                                           bundle: nil,
                                                           configureBlock: configureBlock,
                                                           sizeBlock: sizeBlock)
        sectionController.selectionDelegate = self

        return sectionController
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        nil
    }
    
    // MARK: ListSingleSectionControllerDelegate
    func didSelect(_ sectionController: ListSingleSectionController, with object: Any) {
        print(object)
    }
}
