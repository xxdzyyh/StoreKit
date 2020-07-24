//
//  DefaultDataRefreshViewModel.swift
//  iOSAppNext
//
//  Created by XXXX on 2020/1/4.
//  Copyright © 2020 -. All rights reserved.
//

import Foundation

class DefaultDataRefreshViewModel<Data>: XBaseSectionModel<Data>, DataRefreshViewModelProtocol {        
    var currentPage: Int = 0
    
    let endSubject = PublishSubject<DataRefreshStatus>()
    let refreshIndicator = ActivityIndicator()
    
    let didRefreshSubject = PublishSubject<()>()
    let didLoadMoreSubject = PublishSubject<Range<Int>>()
    
    func refreshDataAPI(page: Int, limit: Int) -> Single<ResponseModel<[Data]>> {
        .just(ResponseModel())
    }
}
