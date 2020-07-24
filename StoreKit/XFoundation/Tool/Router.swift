//
//  Router.swift
//  iOSAppNext
//
//  Created by XXXX on 2019/12/23.
//  Copyright © 2019 -. All rights reserved.
//

import Foundation
import URLNavigator
import QMUIKit

@objc 
final class Router: NSObject {
    private static let navigator: NavigatorType = {
        let navigator = Navigator()
        initialize(navigator)
        return navigator
    }()
    
    static func initialize(_ navigator: NavigatorType) {
        
        // 网页
        navigator.register("http://<path:_>", webViewControllerFactory)
        navigator.register("https://<path:_>", webViewControllerFactory)
        
        // Alert
        navigator.handle("sckjexchange://alert", alertHandlerFactory)
        
        // 注册其他模块入口URL规则...
//        navigator.handle("sckjexchange://login") { (url, values, cxt) -> Bool in
//            let loginVc = LoginViewController()
//            return navigator.present(loginVc) != nil
//        }
    }
}

//MARK: - Navigation
extension Router {
    @discardableResult
    static func open(_ url: URLNavigator.URLConvertible) -> Bool {
        print("open url: \(url)")
        
        if let _ = navigator.push(url) {
            return true
        }
        if let _ = navigator.present(url, wrap: UINavigationController.self) {
            return true
        }
        return navigator.open(url)
    }
    
    @discardableResult
    @objc(openURL:)
    static func open(url: URL) -> Bool {
        open(url)
    }
    
    @discardableResult
    @objc(openUrlStr:)
    static func open(url: String) -> Bool {
        if let url = URL(string: url) {
            return open(url)
        }
        return false
    }
    
    @discardableResult
    @objc
    static func show(_ viewController: UIViewController,
                     from: UIViewController? = nil) -> UIViewController? {
        show(viewController, from: from, wrap: UINavigationController.self, animated: true, completion: nil)
    }
    
    @discardableResult
    @objc
    static func show(_ viewController: UIViewController,
                     from: UIViewController? = nil,
                     wrap: UINavigationController.Type? = UINavigationController.self) -> UIViewController? {
        show(viewController, from: from, wrap: wrap, animated: true, completion: nil)
    }
    
    @discardableResult
    @objc
    static func show(_ viewController: UIViewController,
                     from: UIViewController? = nil,
                     wrap: UINavigationController.Type? = UINavigationController.self,
                     animated: Bool = true,
                     completion: (()->Void)? = nil) -> UIViewController? {
        
        var result: UIViewController? = nil
        CATransaction.animate({
            result = navigator.pushViewController(viewController, from: from?.navigationController, animated: animated)
        }) {
            if result != nil { completion?() }
        }
        if result == nil {
            result = navigator.presentViewController(viewController, wrap: wrap, from: from, animated: animated, completion: completion)
        }
        return result
    }
    
    @discardableResult
    @objc
    static func present(_ viewController: UIViewController,
                        from: UIViewController? = nil,
                        wrap: UINavigationController.Type? = UINavigationController.self) -> UIViewController? {
        present(viewController, from: from, wrap: wrap, animated: true, completion: nil)
    }
    
    @discardableResult
    @objc
    static func present(_ viewController: UIViewController,
                        from: UIViewController? = nil,
                        wrap: UINavigationController.Type? = UINavigationController.self,
                        animated: Bool = true,
                        completion: (()->Void)? = nil) -> UIViewController? {
        return navigator.presentViewController(viewController, wrap: wrap, from: from, animated: animated, completion: completion)
    }
    
    @objc
    static func showTab(at index: Int) {
        guard let tabCtrl = UIApplication.shared.delegate?.window??.rootViewController as? UITabBarController else {
            return
        }
        tabCtrl.selectedIndex = index
    }
}

//MARK: - Factories
extension Router {
    /// 跳转webView
    private static func webViewControllerFactory(
        url: URLNavigator.URLConvertible,
        values: [String: Any],
        context: Any?
    ) -> UIViewController? {
        
        // 传本地token
//        var set = CharacterSet()
//        set.formUnion(.urlHostAllowed)
//        set.formUnion(.urlPathAllowed)
//        set.formUnion(.urlQueryAllowed)
//        set.formUnion(.urlFragmentAllowed)
//        guard let urlString = url.urlStringValue.addingPercentEncoding(withAllowedCharacters: set) else {
//            return nil
//        }
//        guard var fullURL = url.urlValue else { return nil }
//        if urlString.queryParameters["needToken"]?.boolValue == true, let access_token = UserModel.default.access_token {
//            let urlString = fullURL.absoluteString.appendingQuery(dict: ["token": access_token])
//            fullURL = urlString.urlValue!
//        }
//        
//        let webCtrl = WebPageViewController()
//        webCtrl.requestURL = fullURL
//        webCtrl.titleString = url.queryParameters["title"]
//        return webCtrl
        return nil
    }
    
    private static func alertHandlerFactory(url: URLNavigator.URLConvertible, values: [String: Any], context: Any?) -> Bool {
        guard let title = url.queryParameters["title"] else {
            return false
        }
        let message = url.queryParameters["message"]
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        return navigator.present(alertController) != nil
    }
}
