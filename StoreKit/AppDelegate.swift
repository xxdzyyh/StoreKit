//
//  AppDelegate.swift
//  StoreKit
//
//  Created by XXXXon 2020/7/21.
//  Copyright © 2020 sckj. All rights reserved.
//

import UIKit
import QMUIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = MainTabBarViewController()
        window?.makeKeyAndVisible()
        
        if currentUserToken == nil {
            let loginVC = LoginViewController()
                   
            window?.rootViewController?.present(loginVC, animated: true, completion: nil)
                   
        }
        ThemeManager.setup()
        return true
    }
}

