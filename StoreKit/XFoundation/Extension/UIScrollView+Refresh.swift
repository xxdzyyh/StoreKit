//
//  UIScrollView+Refresh.swift
//  iOSAppNext
//
//  Created by XXXX on 2019/12/26.
//  Copyright © 2019 -. All rights reserved.
//

import UIKit
import MJRefresh

extension UIScrollView {
    
    func setHeaderRefresh(_ block: @escaping ()->Void) {
        setHeaderRefresh(block, config: nil)
    }
    
    func setHeaderRefresh(_ block: @escaping ()->Void, config: ((MJRefreshNormalHeader)->Void)?) {
        let header = MJRefreshNormalHeader(refreshingBlock: block)
        header.isAutomaticallyChangeAlpha = true
        mj_header = header
        config?(header)
    }
    
    func setFooterRefresh(_ block: @escaping ()->Void) {
        mj_footer = MJRefreshBackNormalFooter(refreshingBlock: block)
        mj_footer?.isAutomaticallyChangeAlpha = true
    }
    
    func beginHeaderRefreshing(_ block: (()->Void)? = nil) {
        if let block = block {
            mj_header?.beginRefreshing(completionBlock: block)
        } else {
            mj_header?.beginRefreshing()
        }
    }
    
    func beginFooterRefreshing(_ block: (()->Void)? = nil) {
        if let block = block {
            mj_footer?.beginRefreshing(completionBlock: block)
        } else {
            mj_footer?.beginRefreshing()
        }
    }
    
    func endRefresh() {
        mj_header?.endRefreshing()
        mj_footer?.endRefreshing()
    }
    
    func endRefreshWithNoMoreData() {
        mj_header?.endRefreshing()
        mj_footer?.endRefreshingWithNoMoreData()
    }
    
    func isRefreshing() -> Bool {
        return mj_header?.isRefreshing ?? false || mj_footer?.isRefreshing ?? false
    }
}
