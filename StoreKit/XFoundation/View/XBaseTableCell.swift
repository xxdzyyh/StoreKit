//
//  XTableViewCell.swift
//  XFoundation
//
//  Created by xiaoniu on 2018/10/26.
//  Copyright © 2018年 com.learn. All rights reserved.
//

import UIKit

public class XBaseTableCell: UITableViewCell {

    var data : Any?
        
    //MARK: - 高度计算
        
    static func cellHeight() -> (CGFloat) {
        return 44.0
    }
    
    static func cellHeight(with data:Any) -> (CGFloat) {
        return 44.0
    }
    
    //MARK: - 数据填充
    
   func config(model:Any) {
        
    }
    
    // MARK: - 注册创建
    class func register(for tableView:UITableView, identifier:String? = nil) {
        var reuseIdentifier = identifier
        if reuseIdentifier == nil {
          reuseIdentifier = self.className
        }
        let classBundle = Bundle.init(for: self)
        let path = classBundle .path(forResource: className, ofType: "nib")
        if (path != nil) {
            let nib = UINib.init(nibName: className, bundle: classBundle)
            
            tableView.register(nib, forCellReuseIdentifier: reuseIdentifier!)
        } else {
            tableView.register(self, forCellReuseIdentifier: reuseIdentifier!)
        }
    }

    static func cell(for tableView: UITableView, identifier:String? = nil) -> (UITableViewCell) {
        var reuseIdentifier = identifier
        if reuseIdentifier == nil {
          reuseIdentifier = self.className
        }
        var cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier!)
        if cell == nil {
            register(for: tableView, identifier: reuseIdentifier!)
            cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier!)
        }
        return cell!
    }
}
