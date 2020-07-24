//
//  SystemNotificationVC.swift
//  SPARKVIDEO
//
//  Created by XXXXon 2020/7/22.
//

import UIKit

class SystemNotificationVC: UIViewController,QMUIModalPresentationContentViewControllerProtocol {

    @IBOutlet weak var okButton: UIButton!
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var label: UILabel!
    
    var notification : String = ""
    init(notification:String) {
        super.init(nibName: nil, bundle: nil)

        self.notification = notification
    }
    
    var height : CGFloat = 380
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.bgView.layer.cornerRadius = 8
        self.bgView.layer.shadowColor = UIColor.init(white: 0, alpha: 0.5).cgColor
        self.bgView.layer.shadowOffset = CGSize.zero
        self.bgView.layer.shadowRadius = 5
        self.bgView.layer.shadowOpacity = 0.8
        
        label.textColor = UIColor.colorWith(hex: 0x333333, alpha: 0.5)
        do {
            let attStr = try NSAttributedString.init(data: self.notification.data(using: .unicode)!, options: [NSAttributedString.DocumentReadingOptionKey.documentType : NSAttributedString.DocumentType.html], documentAttributes: nil)
            
            let mAttStr = attStr.mutableCopy() as! NSMutableAttributedString
            
            let attributes = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14),NSAttributedString.Key.foregroundColor:UIColor.colorWith(hex: 0x333333, alpha: 0.5)]
            mAttStr.addAttributes(attributes, range: NSRange.init(location: 0, length: mAttStr.length))
            label.attributedText = mAttStr
            
            self.view.height = 380 - 150 + label.intrinsicContentSize.height
            
        } catch {
            
        }

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
//        if self.okButton.gradientLayer == nil {
//            self.okButton.addThemeGradientLayer()
//        }
    }
    
    deinit {
//        log.debug("deinit")
    }
    
    // MARK: QMUIModalPresentationContentViewControllerProtocol
    
    func  preferredContentSize(in controller: QMUIModalPresentationViewController, keyboardHeight: CGFloat, limitSize: CGSize) -> CGSize {
        return CGSize(width: 300, height: self.height)
    }
}
