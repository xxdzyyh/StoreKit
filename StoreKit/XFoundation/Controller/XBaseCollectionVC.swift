//
//  XBaseCollectionVC.swift
//  SPARKVIDEO
//
//  Created by XXXXon 2020/7/22.
//

import UIKit

class XBaseCollectionVC: XBaseVC,UICollectionViewDelegate,UICollectionViewDataSource {

    // 数据源
    var dataList : [Any] = [Any]()
        
    override func setupSubviews() {
        super.setupSubviews()
        
        self.registerCell()
        self.view.addSubview(self.collectionView)
    }
    
    override func setupConstriants() {
        super.setupConstriants()
        
        self.collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return XEmptyCollectionCell.cell(for: collectionView, indexPath: indexPath)
    }
        
    // MARK: register cell or reusableView
    func registerCell() {
        
    }
    
    // MARK: Lazy Init
    lazy var collectionLayout : UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.size.width, height: 100)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let v = UICollectionView(frame: CGRect.zero, collectionViewLayout: self.collectionLayout)
        
        v.delegate = self
        v.dataSource = self
        v.backgroundColor = .clear
        return v
    }()
}
