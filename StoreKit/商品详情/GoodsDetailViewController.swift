//
//  GoodsDetailViewController.swift
//  NMWeiShi
//
//  Created by XXXX on 2020/5/14.
//

import UIKit
import TYCyclePagerView

enum GoodsDetailCellType : Int {
    case goodsImages
    case desc
    case separator1
    case color
    case params
    case separator2
    case comment
    case separator3
    case user
    case shop
}

class GoodsDetailViewController: XBaseTableVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GoodsDetailCellType.shop.rawValue+1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = GoodsDetailCellType.init(rawValue: indexPath.row)
        switch cellType {
        case .goodsImages:
            let cell = XBaseTableCell.cell(for: tableView)
            return cell
        case .desc:
            let cell = FirstTableViewCell.cell(for: tableView)
            return cell
        case .color:
            let cell = SecondTableViewCell.cell(for: tableView)
        return cell
        case .params:
            let cell = SecondTableViewCell.cell(for: tableView)
            return cell
        case .comment:
            let cell = ThirdTableViewCell.cell(for: tableView)
            return cell
        case .user:
            let cell = FourthTableViewCell.cell(for: tableView)
             return cell
        case .shop:
            let cell = FifthTableViewCell.cell(for: tableView)
            return cell
        case .none:
            return XBaseTableCell.cell(for: tableView)
        case .some(.separator1):
            let cell = XBaseTableCell.cell(for: tableView)
            cell.backgroundColor = UIColor.clear
            return cell
        case .some(.separator2):
            let cell = XBaseTableCell.cell(for: tableView)
            cell.backgroundColor = UIColor.clear
            return cell
        case .some(.separator3):
            let cell = XBaseTableCell.cell(for: tableView)
            cell.backgroundColor = UIColor.clear
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellType = GoodsDetailCellType.init(rawValue: indexPath.row)
        switch cellType {
        case .goodsImages:
            return 343
        case .desc:
            return 107
        case .color:
            return 44
        case .params:
            return 44
        case .comment:
            return 253
        case .user:
            return 62
        case .shop:
            return 295
        case .none:
            return 60
        case .some(.separator1):
            return 10
        case .some(.separator2):
            return 10
        case .some(.separator3):
            return 10
        }
    }
}

