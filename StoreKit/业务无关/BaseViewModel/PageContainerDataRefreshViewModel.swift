//
//  DefaultDataRefreshViewModel.swift
//  iOSAppNext
//
//  Created by XXXX on 2020/1/4.
//  Copyright © 2020 -. All rights reserved.
//

import Foundation

class PageContainerDataRefreshViewModel<Data>: DefaultDataRefreshViewModel<Data>
    where Data: HandyJSON
{
    var pageInfo = PageContainerModel<Data>()
    
//    override var currentPage: Int {
//        set {}
//        get { pageInfo.pageNum }
//    }
//
//    override var hasMore: Bool {
//        set {}
//        get { pageInfo.hasNextPage }
//    }
        
    override func refreshDataAPI(page: Int, limit: Int) -> Single<ResponseModel<[Data]>> {
        refreshPageDataAPI(page: page, limit: limit)
//            .do(onSuccess: { [weak self] (resp) in
//                self?.pageInfo = resp.data ?? PageContainerModel<Data>()
//            })
            .map({ [weak self] (resp) -> ResponseModel<[Data]> in
                self?.pageInfo = resp.data ?? PageContainerModel<Data>()
                return ResponseModel(data: resp.data?.records)
            })
    }
    
    func refreshPageDataAPI(page: Int, limit: Int) -> Single<ResponseModel<PageContainerModel<Data>>> {
        .just(ResponseModel())
    }
}
