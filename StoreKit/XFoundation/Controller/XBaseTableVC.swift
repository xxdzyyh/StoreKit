//
//  XBaseTableVC.swift
//  StoreKit
//
//  Created by XXXXon 2020/7/24.
//  Copyright © 2020 sckj. All rights reserved.
//

import UIKit

class XBaseTableVC: XBaseVC, UITableViewDelegate, UITableViewDataSource {

    var dataList : [Any] = [Any]()
    
    override func setupSubviews() {
        super.setupSubviews()
        
        self.view.addSubview(self.tableView)
    }
    
    override func setupConstriants() {
        super.setupConstriants()
        
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK：UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = XBaseTableCell.cell(for: tableView) as! XBaseTableCell
        cell.config(model: self.dataList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0000001
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0000001
    }
    
    // MARK: Lazy Init
    lazy var tableView : UITableView = {
        let v = UITableView(frame: CGRect.zero, style: .plain)
        v.rowHeight = 60
        v.dataSource = self
        v.delegate = self
        v.showsVerticalScrollIndicator = false
        v.showsHorizontalScrollIndicator = false
        v.separatorStyle = .none
        v.tableFooterView = UIView.init()
        return v
    }()
}
