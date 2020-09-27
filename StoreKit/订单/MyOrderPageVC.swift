////
//// MyOrderPageVC.swift
//// BFMoney
////
//// Created by sckj on 2020/07/25.
//// Copyright © 2020 xiaoniu88. All rights reserved.
////
//
//import UIKit
//import JXPagingView
//import JXSegmentedView
//
//
///// 全部 代付款 待发货 待收货 待点评
//enum MyOrderType : Int {
//	case all
//	case waitPay
//    case waitSend
//    case waitReciver
//    case waitComment
//}
//
//class MyOrderPageVC: XBaseVC {
//
//	override func viewDidLoad() {
//	    super.viewDidLoad()
//
//	}
//
//    override func setupSubviews() {
//        super.setupSubviews()
//        self.view.addSubview(self.pagingView)
//    }
//
//    override func setupConstriants() {
//        super.setupConstriants()
//
//        pagingView.snp.makeConstraints { (make) in
//            if #available(iOS 11.0, *) {
//                make.edges.equalTo(view.safeAreaLayoutGuide)
//            } else {
//                // Fallback on earlier versions
//                make.left.right.equalToSuperview()
//                make.top.equalTo(topLayoutGuide.snp.bottom).offset(10)
//                make.bottom.equalTo(bottomLayoutGuide.snp.top)
//            }
//        }
//    }
//
//    //MARK: - Subviews
//
//    private lazy var pagingView: JXPagingView = {
//        let view = JXPagingView(delegate: self)
//        view.frame = CRScreenBounds()
//        view.mainTableView.gestureDelegate = self
//        view.backgroundColor = .qd_backgroundColorLighten
//        view.mainTableView.backgroundColor = .qd_backgroundColorLighten
//
//        return view
//    }()
//
//    private lazy var segmentedDataSource: JXSegmentedTitleDataSource = {
//        let dataSource = JXSegmentedTitleDataSource()
//
//        dataSource.titles = ["全部","待付款","待发货","待收款","点"]
//        dataSource.titleNormalColor = .white
//        dataSource.titleNormalFont = .pingFangRegular(ofSize: 15)
//        dataSource.titleSelectedColor = .white
//        dataSource.titleSelectedFont = .pingFangRegular(ofSize: 15)
//        dataSource.isTitleZoomEnabled = true
//        dataSource.titleSelectedZoomScale = 18.0 / 15.0
//        dataSource.isItemWidthZoomEnabled = true
//        dataSource.itemWidthSelectedZoomScale = 18.0 / 15.0
//        return dataSource
//    }()
//
//	private lazy var segControl: JXSegmentedView = {
//        let seg = JXSegmentedView()
//        seg.frame = CGRect(x: 0, y: 12, width: 60, height: 44)
//
//        let indicator = JXSegmentedIndicatorLineView()
//        indicator.indicatorCornerRadius = 1
//        indicator.indicatorColor = .white
//        indicator.indicatorHeight = 3
//        indicator.indicatorWidth = 30
//        seg.indicators = [indicator]
//
//        seg.backgroundColor = QDThemeManager.currentTheme?.themeBackgroundColor()
//        seg.dataSource = segmentedDataSource
//        seg.listContainer = self.pagingView.listContainerView
//        seg.isContentScrollViewClickTransitionAnimationEnabled = false
//
//        return seg
//    }()
//}
//
//extension MyOrderPageVC: JXPagingViewDelegate {
//
//    func tableHeaderViewHeight(in pagingView: JXPagingView) -> Int {
//        return 0
//    }
//
//    func tableHeaderView(in pagingView: JXPagingView) -> UIView {
//        return UIView.init()
//    }
//
//    func heightForPinSectionHeader(in pagingView: JXPagingView) -> Int {
//        44
//    }
//
//    func viewForPinSectionHeader(in pagingView: JXPagingView) -> UIView {
//         segControl
//    }
//
//    func numberOfLists(in pagingView: JXPagingView) -> Int {
//        segmentedDataSource.titles.count
//    }
//
//    func pagingView(_ pagingView: JXPagingView, initListAtIndex index: Int) -> JXPagingViewListViewDelegate {
//         let vc = MyOrderVC(type:MyOrderType(rawValue: index))
//         return vc
//    }
//}
//
//extension MyOrderPageVC: JXPagingMainTableViewGestureDelegate {
//    func mainTableViewGestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//        //禁止segmentedView左右滑动的时候，上下和左右都可以滚动
//        if otherGestureRecognizer == segControl.collectionView.panGestureRecognizer {
//            return false
//        }
//        return gestureRecognizer.isKind(of: UIPanGestureRecognizer.self) && otherGestureRecognizer.isKind(of: UIPanGestureRecognizer.self)
//    }
//}
//
//
