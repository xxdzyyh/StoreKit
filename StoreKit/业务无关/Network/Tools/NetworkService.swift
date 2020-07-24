//
//  Network.swift
//  iOSAppNext
//
//  Created by XXXX on 2019/12/23.
//  Copyright © 2019 -. All rights reserved.
//

import Moya
import Alamofire

struct Network {
    
    //MARK: - Reachability
    static var isConnected: Bool {
        NetworkReachabilityManager.default?.isReachable ?? false
    }
    
    static func startMonitoring() {
        NetworkReachabilityManager.default?.startListening(onUpdatePerforming: { (status) in
            print("network status did change to \(status)")
        })
    }
    
    //MARK: - MoyaProvider Config
    private static let endpointClosure = { (target: MultiTarget) -> Endpoint in
        
//        let url = target.baseURL.appendingPathComponent(target.path)
        let url = URL(target: target)
        
        let sampleResponseClosure = { () -> (EndpointSampleResponse) in
            return .networkResponse(200, target.sampleData)
        }
        
        var endpoint = Endpoint(url: url.absoluteString,
                                sampleResponseClosure: sampleResponseClosure,
                                method: target.method,
                                task: target.task,
                                httpHeaderFields: target.headers)
        return endpoint
    }
    
    private static let requestClosure = { (endpoint: Endpoint, done: MoyaProvider.RequestResultClosure) in
        do {
            var request = try endpoint.urlRequest()
            if let body = request.httpBody {
                
            } else {
                
            }
            done(.success(request))
        } catch {
            done(.failure(MoyaError.underlying(error, nil)))
        }
    }
    
    private static let manager: Session = {
        let config = URLSessionConfiguration.default
        config.headers = .default
        config.timeoutIntervalForRequest = 30
        config.timeoutIntervalForResource = 60
        config.urlCredentialStorage = nil
        
        return Session(configuration: config, startRequestsImmediately: false, interceptor: RequestRetryHandler())
    }()
    
    #if DEBUG
    private static let plugins: [PluginType] = [
        AuthPlugin(tokenClosure: { return currentUser?.access_token }),
        NetworkLoggerPlugin(configuration: NetworkLoggerPlugin.Configuration(logOptions: .verbose))
    ]
    #else
    private static let plugins: [PluginType] = [
        AuthPlugin(tokenClosure: { return currentUser?.access_token })
    ]
    #endif
    
    private static let provider = MoyaProvider(endpointClosure: endpointClosure,
                                               requestClosure: requestClosure,
                                               session: manager,
                                               plugins: plugins,
                                               trackInflights: false)
    
    private static let stubbingProvider = MoyaProvider(endpointClosure: endpointClosure,
                                               requestClosure: requestClosure,
                                               stubClosure: MoyaProvider.immediatelyStub,
                                               session: manager,
                                               plugins: plugins,
                                               trackInflights: false)

    
    //MARK: - Request Methods
    static func request(_ target: TargetType,
                        stub: Bool = false,
                        showErrorMsg: Bool = true,
                        showSuccessMsg: Bool = false) 
        -> Single<JSON?> 
    {
        return request(target,
                       dataType: JSON.self,
                       stub: stub,
                       showErrorMsg: showErrorMsg,
                       showSuccessMsg: showSuccessMsg)
            .map({ $0.data })
    }
    
    static func request<T>(_ target: TargetType,
                           dataType: T.Type,
                           stub: Bool = false,
                           showErrorMsg: Bool = true,
                           showSuccessMsg: Bool = false) 
        -> Single<T?> 
    {
        return request(target,
                       dataType: ResponseModel<T>.self,
                       stub: stub,
                       showErrorMsg: showErrorMsg,
                       showSuccessMsg: showSuccessMsg)
            .map { $0.data }
    }
    
    static func request<T>(_ target: TargetType,
                           dataType: T.Type,
                           stub: Bool = false,
                           showErrorMsg: Bool = true,
                           showSuccessMsg: Bool = false) 
        -> Single<T> where T: ResponseMappable  
    {
        let provider = stub ? stubbingProvider : self.provider
        return provider.rx
            .request(MultiTarget(target))
            .filterSuccessfulStatusCodes()
            .handleNetworkError(showErrorMsg)
            // 将数据转成 Model
            .map(type: T.self)
            .handleAPIError(showSuccessMsg, showErrorMsg)
    }
    
    static func requestWithProgress<T>(_ target: TargetType,
                                       dataType: T.Type, 
                                       stub: Bool = false,
                                       showErrorMsg: Bool = true,
                                       showSuccessMsg: Bool = false)
        -> Observable<(Double, T?)> where T: ResponseMappable
    {
        requestWithProgress(target,
                            stub: stub,
                            showErrorMsg: showErrorMsg)
            .map(type: T.self)
            .`do`(onNext: { (e) in
                if let model = e.1 {
                    try Network.handleAPIError(model, showSuccessMsg, showErrorMsg)
                }
            })
    }
    
    static func requestWithProgress(_ target: TargetType, 
                                    stub: Bool = false,
                                    showErrorMsg: Bool = true)
        -> Observable<ProgressResponse>
    {
        let provider = stub ? stubbingProvider : self.provider
        return provider.rx
            .requestWithProgress(MultiTarget(target))
            .filterSuccessfulStatusCodes()
            .handleNetworkError(showErrorMsg)
    }
}


//MARK: - 错误处理

extension ObservableType where Element == ProgressResponse {
    
    func handleNetworkError(_ showErrorMsg: Bool) -> Observable<Element> {
        catchError({ (error) -> Observable<Element> in
            Network.handleNetworkError(error, showErrorMsg)
            //throw error
            return .error(error)
        })
    }
}

extension ObservableType where Element == (Double, JSON?) {
    
    func handleAPIError(_ showSuccessMsg: Bool, _ showErrorMsg: Bool) -> Observable<(Double, JSON?)> {
        `do`(onNext: { (e) in
            if let model = e.1 {
                try Network.handleAPIError(model, showSuccessMsg, showErrorMsg)
            }
        })
    }
}
    
extension PrimitiveSequence where Trait == SingleTrait, Element == Response {
    
    func handleNetworkError(_ showErrorMsg: Bool) -> Single<Element> {
        catchError({ (error) -> PrimitiveSequence<SingleTrait, Element> in
            Network.handleNetworkError(error, showErrorMsg)
            return .error(error)
        })
    }
}

extension PrimitiveSequence where Trait == SingleTrait, Element: ResponseMappable {
    
    func handleAPIError(_ showSuccessMsg: Bool, _ showErrorMsg: Bool) -> Single<Element> {
        `do`(onSuccess: { (model) in
            try Network.handleAPIError(model, showSuccessMsg, showErrorMsg)
        })
    }
}

extension Network {
    
    static func handleNetworkError(_ error: Error, _ showErrorMsg: Bool) {
        if error.isRequestCancelled() {
            return
        }
        // 这里统一处理更加底层的网络错误，比如服务器404或者500等常见错误。
        // 将底层网络框架返回的错误提示，在这里转换为更加友好的用户提示，然后把错误抛给业务层进行处理。
        if let moyaError = error as? MoyaError {
            print("catch moya error: \(moyaError), \nresponse: \(String(describing: moyaError.response))")
            
            switch moyaError {
            case let .underlying(error, _):
                // now can access NSError error.code or whatever
                // e.g. NSURLErrorTimedOut or NSURLErrorNotConnectedToInternet
                if let urlError = error as? URLError {
                    switch urlError.code {
                    case .cancelled:
                        // 请求取消
                        break
                    case .notConnectedToInternet:
                        break
                    case .timedOut:
                        break
                    case .networkConnectionLost:
                        break
                    default:
                        break
                    }
                }
                if showErrorMsg {
                    Toast.showError(Network.localizedStringFromURLError(error))
                }
            case let .statusCode(response):
                if showErrorMsg {
                    let error = URLError(statusCode: response.statusCode)
                    Toast.showError(Network.localizedStringFromURLError(error))
                }
                
            default: break
                //                case .imageMapping(let response):
                //                case .jsonMapping(let response):
                //                case .stringMapping(let response):
                //                case .objectMapping(let error, let response):
                //                case .encodableMapping(let error):
                //                case .statusCode(let response):
                //                case .requestMapping:
                //                case .parameterEncoding(let error):
            }
        } else {
            print("catch error 1: \(error)")
        }
    }
    
    static func localizedStringFromURLError(_ error: Error) -> String {
        var msg = "网络请求失败，请稍后重试。"
        if let urlError = error as? URLError {
            switch urlError.code {
            case URLError.Code.cannotFindHost:
                msg = "连接服务器失败，请稍后重试。"
            case URLError.Code.notConnectedToInternet:
                msg = "网络似乎已经断开，请检查您的网络。"
            case URLError.Code.timedOut:
                msg = "网络访问超时，请稍后再试。"
            case URLError.Code.cancelled:
                msg = kEmptyString
                //            case URLError.Code.badServerResponse:
                //                msg = "服务器端故障，请稍后再试。"
                //        case URLError.Code.networkConnectionLost:
            //            msg = "请关闭代理后重试。"
            case URLError.Code.cannotConnectToHost: // 未能连接到服务器
                break
            default: break
            }
        }
        return msg
    }
    
    static func handleAPIError<T: ResponseMappable>(_ model: T, _ showSuccessMsg: Bool, _ showErrorMsg: Bool) throws {
        
        // 通用的业务数据处理逻辑，判断业务请求是否成功，即code是否等于0
        if model.code == kAPISuccessCode {
            if showSuccessMsg { Toast.showSuccess(model.msg) }
        } else {
            if model.code == kAccessTokenExpiredCode {
                // 处理Token过期等异常，//TODO: 刷新Token
                UserManager.shared.loginExpired()
            }
            // 统一错误展示，Toast
            if showErrorMsg {
                Toast.showError(model.msg)
            }
            
            let apiError = APIError(code: model.code, msg: model.msg)
            print("catch api error: \(apiError)")
           
            throw apiError
        }
    }
}







//MARK: - 旧式接口

extension Network {
    
    typealias Completion<T> = (_ result: Swift.Result<T, Error>) -> Void
    
    static func request<T>(_ target: TargetType,
                           dataType: T.Type,
                           showSuccessMsg: Bool = false,
                           showErrorMsg: Bool = true,
                           completion: @escaping Completion<T?>) -> Cancellable {
        return request(target, dataType: ResponseModel<T>.self, showSuccessMsg: showSuccessMsg, showErrorMsg: showErrorMsg) { (result) in
            switch result {
            case let .success(model):
                completion(.success(model.data))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    static func request<T>(_ target: TargetType,
                           dataType: T.Type,
                           showSuccessMsg: Bool = false,
                           showErrorMsg: Bool = true,
                           completion: @escaping Completion<T>) -> Cancellable where T: ResponseMappable {
        
        provider.request(MultiTarget(target)) { result in
            switch result {
            case let .success(response):
                do {
                    let _ = try response.filterSuccessfulStatusCodes()
                    let model = try response.map(type: T.self)
                    try handleAPIError(model, showSuccessMsg, showErrorMsg)
                    
                    if showSuccessMsg { Toast.showSuccess(model.msg) }
                    completion(.success(model)) 
                } catch {
                    completion(.failure(error))
                }

            case let .failure(moyaError):
                handleNetworkError(moyaError, showErrorMsg)
                completion(.failure(moyaError))
            }
        }
    }
}
