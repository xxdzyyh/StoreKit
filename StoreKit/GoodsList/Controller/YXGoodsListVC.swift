//
// YXGoodsListVC.swift
// BFMoney
//
// Created by XXXXon 2020/07/14.
// Copyright © 2020 xiaoniu88. All rights reserved.
//

import UIKit

func test() -> [GoodsModel] {
    let goods = GoodsModel()
    
    goods.goodsName = "商品名称"
    goods.price = 123.6666
    goods.goodsSale = 456
    goods.goodsImg = "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1594734290738&di=7012e9bfed72527f40af158d443446c1&imgtype=0&src=http%3A%2F%2F5b0988e595225.cdn.sohucs.com%2Fimages%2F20171002%2Fc8a480faad78426b8955e91eed3c4715.jpeg"
    
    return [goods, goods, goods, goods]
}

class YXGoodsListVC: UIViewController,CHTCollectionViewDelegateWaterfallLayout,UICollectionViewDataSource,UICollectionViewDelegate {

    var dataList : [GoodsModel]?
           
    // 因为最下面的布局是不规则的，需要使用CHTCollectionViewWaterfallLayout,用IGListKit不是很好实现
    var collectionView: UICollectionView = {
       let layout = CHTCollectionViewWaterfallLayout()
        layout.minimumColumnSpacing = 6
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
       return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()

    lazy var headerVC: YXHomePageVC = {
        let vc = YXHomePageVC()
        vc.collectionView.isScrollEnabled = false
        return vc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "优选中心"
        self.edgesForExtendedLayout = UIRectEdge.init()
    
        self.dataList = test()
        
        self.view.backgroundColor = UIColor.colorWith(hex: 0x090D19)

        self.setupSubviews()
        self.setupConstraints()
    }
    
    func setupSubviews() {
        self.collectionView.setHeaderRefresh {
            print("setHeaderRefresh")
            self.collectionView.endRefresh()
        }
        
        self.view.addSubview(collectionView)

        XEmptyCollectionReusableView.register(for: self.collectionView)
        YXGoodsFlowCell.register(for: self.collectionView)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    func setupConstraints() {
        self.collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if (kind.elementsEqual("CHTCollectionElementKindSectionHeader")) {
            let v = XEmptyCollectionReusableView.dequeueReusable(for: collectionView, indexPath: indexPath)
            
            if self.headerVC.view.superview == nil || v.subviews.count == 0 {
                v.addSubview(self.headerVC.view)
                self.headerVC.view.snp.makeConstraints { (make) in
                    make.edges.equalToSuperview()
                }
            }
            
            return v
        } else {
            let v = XEmptyCollectionReusableView.dequeueReusable(for: collectionView, indexPath: indexPath)
            return v
        }
    }
    
    func collectionView(_ collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(895)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "YXGoodsFlowCell", for: indexPath) as! YXGoodsFlowCell
        cell.config(model: dataList![indexPath.row])
        cell.backgroundColor = UIColor.colorWith(hex: 0x131D35)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if dataList != nil {
            return dataList!.count
        }
        return 0
    }

    // MARK: CHTCollectionViewDelegateWaterfallLayout
    func collectionView(_ collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, sizeForItemAt indexPath: IndexPath!) -> CGSize {
        return CGSize(width:floor((collectionView.width-24)/2),height:250 + CGFloat.random(in: 0...5) * 10)
    }
}

