//
//  AAALBaseModel.swift
//  iOSAppNext
//
//  Created by XXXX on 2020/1/3.
//  Copyright © 2020 -. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import RxCocoa

enum DataRefreshStatus {
    case hasMoreData
    case hasNoMoreData
    case error
}

protocol AnyDisposeBagContainer {
    var disposeBag: DisposeBag { get }
}

protocol DataRefreshViewModelProtocol: AnyDisposeBagContainer, AnyObject {
//    [ShortVideoRecordModel]
    associatedtype Data
    var dataList: [Data] { get set }
    var currentPage: Int { get set }
    var pageLimit: Int { get }
    
    var endSubject: PublishSubject<DataRefreshStatus> { get }
    var didRefreshSubject: PublishSubject<()> { get }
    var didLoadMoreSubject: PublishSubject<Range<Int>> { get }
    
    var refreshIndicator: ActivityIndicator { get }
    var refreshing: Driver<Bool> { get }
    
    func refreshDataAPI(page: Int, limit: Int) -> Single<ResponseModel<[Data]>>
    func refreshData()
    func loadNextPageData()
}

extension DataRefreshViewModelProtocol {
    
    var pageLimit: Int { 30 }
    var refreshing: Driver<Bool> { refreshIndicator.asDriver() }
    
    func refreshData() {
        request(page: 1, limit: pageLimit)
    }
    
    func refreshAll() {
        request(page: 1, limit: max(pageLimit, dataList.count))
    }
    
    func loadNextPageData() {
        request(page: currentPage + 1, limit: pageLimit)
    }
    
    func request(page: Int, limit: Int) {
        
        let request = refreshDataAPI(page: page, limit: limit)
            .trackActivity(refreshIndicator)
        
        Observable<Void>
            .create({ (observer) -> Disposable in
                observer.onNext(())
                return Disposables.create {
                    observer.onCompleted()
                }
            })
            .withLatestFrom(refreshing)
            .filter({ $0 == false })
            .flatMapLatest({ (_) in
                request
            })

            .subscribe(onNext: { [weak self] (resp) in
                guard let sself = self else { return }
                if page == 1 {
                    self?.dataList.removeAll()
                }
                let list = resp.data ?? []
                sself.dataList.append(contentsOf: list)
                sself.currentPage = page
                
                let status: DataRefreshStatus
                status = list.count > 0 ? .hasMoreData : .hasNoMoreData
                sself.endSubject.onNext(status)
                if page == 1 {
                    sself.didRefreshSubject.onNext(())
                } else {
                    let lowerBound = sself.dataList.count - list.count
                    sself.didLoadMoreSubject.onNext(lowerBound..<sself.dataList.count)
                }
            }, onError: { [weak self] _ in
                self?.endSubject.onNext(.error)
            })
            .disposed(by: disposeBag)
    }
}
