//
//  RuntimeHelper.swift
//  LearnSwift
//
//  Created by yunmai on 2018/6/20.
//  Copyright © 2018年 yunmai. All rights reserved.
//

import UIKit

class RuntimeHelper: NSObject {
    
    /// 通过类名创建实例对象
    /// - Parameter className: 类名
    /// - Returns: 实例对象
    static func instanceForClassName(_ className : String) -> NSObject? {
        let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
		let fullName = nameSpace + "." + className
		let cla : AnyClass? = NSClassFromString(fullName)
		if cla != nil {
            let realClass = cla as! NSObject.Type
            return realClass.init();
		} else {
			return nil
		}
    }
    
}
