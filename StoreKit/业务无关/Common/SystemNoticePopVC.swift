//
//  SystemNoticePopVC.swift
//  SPARKVIDEO
//
//  Created by XXXXon 2020/7/22.
//

import UIKit

class SystemNoticePopVC: UIViewController {
    var containerWindow : QMUIModalPresentationWindow?
    let dimView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dimView.alpha = 0
        self.dimView.backgroundColor = UIColor.colorWith(hex: 0x000000, alpha: 0.35)
        self.view.addSubview(self.dimView)
        
        self.dimView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.contentView != nil {
            self.view.bringSubviewToFront(self.contentView!)
        }
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
            self.dimView.alpha = 1
            self.contentView?.centerY = self.view.centerY
        }
    }
    
    deinit {
//        log.debug("deinit")
    }
    
    var contentView : UIView? {
       didSet {
           self.view.addSubview(contentView!)
            contentView?.snp.makeConstraints({ (make) in
                make.left.equalTo(38)
                make.right.equalTo(-38)
                make.center.equalToSuperview()
            })
       }
   }
    
    var previousKeyWindow : UIWindow?
    func show() {
        self.previousKeyWindow = UIApplication.shared.keyWindow;
        if self.containerWindow  == nil {
            self.containerWindow = QMUIModalPresentationWindow()
            
            self.containerWindow?.windowLevel = UIWindow.Level.alert
            self.containerWindow?.backgroundColor = .clear
        }
        
        self.containerWindow?.rootViewController = self
        self.containerWindow?.makeKeyAndVisible()
    }
    
    
    func hide() {
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
            self.dimView.alpha = 0
        }) { (finished) in
            
            if (UIApplication.shared.keyWindow == self.containerWindow) {
               if (self.previousKeyWindow?.isHidden ?? false) {
                   // 保护了这个 issue 记录的情况，避免主 window 丢失 keyWindow https://github.com/Tencent/QMUI_iOS/issues/315
                UIApplication.shared.delegate!.window!!.makeKey()
               } else {
                self.previousKeyWindow?.makeKey()
               }
           }
            
            self.view.removeFromSuperview()
            self.containerWindow?.isHidden = true
            self.containerWindow?.rootViewController = nil
        }
    }
}
