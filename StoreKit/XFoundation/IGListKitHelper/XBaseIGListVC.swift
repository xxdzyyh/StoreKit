//
//  XBaseIGListVC.swift
//  StoreKit
//
//  Created by XXXXon 2020/7/21.
//  Copyright © 2020 sckj. All rights reserved.
//

import UIKit
import IGListKit

class XBaseIGListVC: XBaseVC, ListAdapterDataSource {

    var data : [ListDiffable]? = nil
    
    lazy var adapter : ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let v = UICollectionView(frame: .zero, collectionViewLayout: layout)
        v.backgroundColor = UIColor.clear
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        adapter.collectionView = collectionView
        adapter.dataSource = self
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        
        self.view.addSubview(self.collectionView)
    }
    
    override func setupConstriants() {
        super.setupConstriants()
        
        self.collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

    // MARK: ListAdapterDataSource
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        if data != nil {
            return data!
        } else {
            return []
        }
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return XBaseSectionController(data: object as! XBaseSectionModel<Any>)
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}
