//
//  XFDemoTableViewController.swift
//  LearnSwift
//
//  Created by wangxuefeng on 2018/6/26.
//  Copyright © 2018年 yunmai. All rights reserved.
//

import UIKit

/*！
	XFDemoTableViewController接收特定数据格式的dataSoure,进行默认的展示和处理

	dataSource结构

	[
		[
			"key" : "ViewController",
		 	"value" : "XXVC",
		 	"desc" : "this is type"
		]
	]
 
 
 class VarTypeVC : XFDemoTableViewController {
 
     override func viewDidLoad() {
         super.viewDidLoad()
         
         dataSource = [[ActionKey.value:"dictionary",ActionKey.key:ActionType.Method],
                       [ActionKey.value : "withLatestFromVC",ActionKey.key.rawValue:ActionType.ViewController]
                       [ActionKey.value:"array",ActionKey.key:ActionType.Method]];
        
     }
 
    @objc func array() {
        var array : Array<String> = Array.init();
        
        array.append("www");
        
        print(array)
    }
 }
 
*/

enum ActionKey : String {
    case key   = "key"
    case value = "value"
    case desc  = "desc"
}

enum ActionType {
    case ViewController
    case Method
    case Others
}

class XDemoTableVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    lazy var tableView : UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = 60
        return tableView
    }()
    
    var dataSource: NSArray! {
        didSet {
            if Thread.current.isMainThread {
                self.tableView.reloadData()
            } else {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
	override func viewDidLoad() {
		super.viewDidLoad()
		
		dataSource = [];
		
		
		self.view.addSubview(self.tableView)
		self.tableView.frame = self.view.bounds
	}
	
	
	///MARK
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.dataSource.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		var cell = tableView.dequeueReusableCell(withIdentifier: "Cell");
		
		if cell == nil {
            cell = UITableViewCell.init(style:UITableViewCell.CellStyle.subtitle, reuseIdentifier: "Cell")
		}
		
        let item = self.dataSource[indexPath.row] as! NSDictionary;
        
        let className = item[ActionKey.value] as! String
        let type : ActionType = item[ActionKey.key.rawValue] as! ActionType
        let desc = item[ActionKey.desc] as? String
        
		cell?.textLabel?.text = className
        cell?.detailTextLabel?.text = {
            switch type {
            case ActionType.ViewController:
                return "UIViewController " + (desc ?? "")
            case ActionType.Method:
                return "Method " + (desc ?? "")
            case ActionType.Others:
                return "Others " + (desc ?? "")
            }
        }()
        
		return cell!
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let item = self.dataSource[indexPath.row] as! NSDictionary;
		
		let value = item[ActionKey.value] as! String
        let type = item[ActionKey.key.rawValue] as! ActionType
		
		switch type {
		case .ViewController:
			let obj = RuntimeHelper.instanceForClassName(value)
			self.navigationController?.pushViewController(obj as! UIViewController, animated: true)
        case .Method:
            let select = Selector.init(value);
            self.perform(select);
		default:
			print("cannot deal with type #{}")
		}
	}
}
