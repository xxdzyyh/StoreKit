//
//  YouxuanHomePageVC.swift
//  ZJVideo
//
//  Created by XXXXon 2020/7/13.
//

import UIKit
import IGListKit


func testData() -> [Any] {
    
    let banner = XBaseSectionModel<[YXBannerModel]>()
    
    let bannerItem = YXBannerModel()
    bannerItem.img = "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1594816290401&di=b48956170587d5e800ef58cfd3522575&imgtype=0&src=http%3A%2F%2Fp2.so.qhimgs1.com%2Ft01dfcbc38578dac4c2.jpg"
    
    let bannerItem2 = YXBannerModel()
    bannerItem2.img = "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1594816333048&di=b415379686885a61bd2af4d6802ab24f&imgtype=0&src=http%3A%2F%2Fa3.att.hudong.com%2F00%2F38%2F01300000241358127660380294217.jpg"
    
   
    banner.dataList = [[bannerItem,bannerItem2,bannerItem,bannerItem2]]

    let category : GoodsCategoryModel = GoodsCategoryModel()
    let model = GoodsCategoryItemModel()
    
    model.classifyName = "上衣"
    model.classifyImg = "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1594734290738&di=7012e9bfed72527f40af158d443446c1&imgtype=0&src=http%3A%2F%2F5b0988e595225.cdn.sohucs.com%2Fimages%2F20171002%2Fc8a480faad78426b8955e91eed3c4715.jpeg"
    category.dataList = [model,model,model,model,model,model,model,model]
    
    let todayGodds = YXGoodsListMdoel()
    todayGodds.title = "每日爆款"
    todayGodds.desc = "/美好新生活"
    let goods = GoodsModel()
    
    goods.goodsName = "商品名称"
    goods.price = 123.6666
    goods.goodsSale = 456
    goods.goodsImg = "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1594734290738&di=7012e9bfed72527f40af158d443446c1&imgtype=0&src=http%3A%2F%2F5b0988e595225.cdn.sohucs.com%2Fimages%2F20171002%2Fc8a480faad78426b8955e91eed3c4715.jpeg"
    
    todayGodds.dataList = [goods, goods, goods]
    
    
    let recomment = YXGoodsListMdoel()
    recomment.title = "每日爆款"
    recomment.desc = "/美好新生活"
    recomment.dataList = [goods, goods, goods]
    
    
    return [banner, category, todayGodds, recomment]
}

class YXHomePageVC: XBaseVC {
    
    lazy var adapter : ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
    
    
    var data : [Any] = testData()
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.colorWith(hex: 0x090D19)
        self.view.addSubview(collectionView)
        adapter.collectionView = collectionView
        adapter.dataSource = self
        
        self.collectionView.setHeaderRefresh {
            print("setHeaderRefresh")
            self.collectionView.endRefresh()
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
}

extension YXHomePageVC : ListAdapterDataSource, ListAdapterMoveDelegate {
    
    // MARK: - ListAdapterMoveDelegate
    func listAdapter(_ listAdapter: ListAdapter, move object: Any, from previousObjects: [Any], to objects: [Any]) {
        data = objects
    }
    
    // MARK: ListAdapterDataSource

    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return data.map { $0 as! ListDiffable }
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        switch object {
        case is GoodsCategoryModel:
            return GoodCategoryController(data: object as? GoodsCategoryModel)
            
        case is YXGoodsListMdoel:
            let data = object as? YXGoodsListMdoel
            if data?.isFlow ?? false {
                return YXGoodsFlowController(data: data)
            } else {
                return YXGoodsListController(data: data)
            }
        case is XBaseSectionModel<Any>:
            return YXBannerController(data: object as! XBaseSectionModel<[YXBannerModel]>)
            
        default:
            return GoodCategoryController(data: nil)
        }
    }

    func emptyView(for listAdapter: ListAdapter) -> UIView? { return nil }
}
