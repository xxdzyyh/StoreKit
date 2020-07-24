//
//  SKApplyShopVC.swift
//  ZJVideo
//
//  Created by XXXXon 2020/7/24.
//

import UIKit

class SKApplyShopVC: UIViewController {

    @IBOutlet weak var nameTextField: QMUITextField!
    @IBOutlet weak var phoneTextField: QMUITextField!
    @IBOutlet weak var shopNameTextField: QMUITextField!
    @IBOutlet weak var shopNumTextField: QMUITextField!
    
    @IBOutlet weak var shopImageButton: UIButton!
    @IBOutlet weak var shopCerImageButton: UIButton!
    @IBOutlet weak var commitButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.commitButton.addCornerRadius(cornerRadius: 3)
    }
    
    @IBAction func onShopImage(_ sender: UIButton) {
        ImagePicker.pickOnePhoto().subscribe(onNext: { (image) in
            sender.setImage(image, for: .selected)
            sender.isSelected = true
        }).disposed(by: self.disposeBag)
    }
    
    @IBAction func onShopCer(_ sender: UIButton) {
        ImagePicker.pickOnePhoto().subscribe(onNext: { (image) in
            sender.setImage(image, for: .selected)
            sender.isSelected = true
        }).disposed(by: self.disposeBag)
    }
    
    
}
