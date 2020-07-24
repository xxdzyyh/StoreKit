//
//  LoginViewController.swift
//  StoreKit
//
//  Created by XXXXon 2020/7/21.
//  Copyright © 2020 sckj. All rights reserved.
//

import UIKit

var token : String? = ""

class LoginViewController: UIViewController {

    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        let vc = SystemNotificationVC(notification: "13WERKEROIP3O4MERLMLERKLSKRWEKRLWEKREWRNWERQEWQWEQ")
//         vc.view.frame = CGRect(x: 38, y: SCREEN_HEIGHT, width: SCREEN_WIDTH-76, height: 380)
//
//
//         let popVC = SystemNoticePopVC()
//         popVC.contentView = vc.view
//         popVC.show()
//
//         _ = vc.okButton.rx.tap.takeUntil(popVC.rx.deallocated).subscribe(onNext: { [weak popVC] () in
//             popVC?.hide()
//         })
        
        
    }
    
    @IBAction func onLogin(_ sender: Any) {
        let api = UserAPI.login(phone: self.phoneTextField.text!, pass: self.passwordTextField.text!, authToken: "")
        _ = Network.request(api,dataType: ResponseModel<JSON>.self).subscribe(onSuccess: { (res) in
            /*
             {"msg":"操作成功","code":0,"data":{"vodAccId":"80439165","customerId":"37514fca53ee40cbb263fe025bea2d0a","accId":"28794053","neteaseToken":"f7ea091bc8878d757285bc51a2963cb1","token":"828ad65140ecda64753f6aec19fbaaed"}}
             */
            
            token = (res.data!["token"]).stringValue
            
            let user = UserInfoModel.init()
            user.access_token = token ?? ""
            UserManager.shared.user = user
            UserManager.shared.requestUserInfo()
            self.dismiss(animated: true, completion: nil)
        }) { (error) in
            
        }
    }
}
