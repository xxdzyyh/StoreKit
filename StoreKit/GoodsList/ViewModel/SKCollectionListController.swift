//
//  SKCollectionListController.swift
//  StoreKit
//
//  Created by XXXXon 2020/7/23.
//  Copyright © 2020 sckj. All rights reserved.
//

import UIKit
import SwipeCellKit

class SKCollectionListController: SKGoodsListController, SwipeCollectionViewCellDelegate {
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext!.dequeueReusableCell(withNibName: "SKCollectionCell", bundle: nil, for: self, at: index) as! SKCollectionCell

        cell.config(model: self.data.dataList[index])
        cell.delegate = self
        
        return cell
    }
    
    // MARK: SwipeCollectionViewCellDelegate
    func collectionView(_ collectionView: UICollectionView, editActionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
     
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            // handle action by updating model with deletion
        
        }
        
        return [deleteAction]
    }
}
