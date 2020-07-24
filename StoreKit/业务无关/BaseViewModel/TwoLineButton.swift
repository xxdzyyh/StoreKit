//
//  TwoLineButton.swift
//  iOSAppNext
//
//  Created by XXXX on 2020/1/3.
//  Copyright © 2020 -. All rights reserved.
//

import UIKit
import QMUIKit

class TwoLineButton: QMUIButton {

    var topText: String {
        didSet { updateTitle() }
    }
    var bottomText: String {
        didSet { updateTitle() }
    }
    
    var topFont: UIFont = .systemFont(ofSize: 20) {
        didSet { updateTitle() }
    }
    var bottomFont: UIFont = .systemFont(ofSize: 10) {
        didSet { updateTitle() }
    }
    
    var topColor: UIColor = .x333 {
        didSet { updateTitle() }
    }
    var bottomColor: UIColor = .x999 {
        didSet { updateTitle() }
    }
    
    init(topText: String, bottomText: String) {
        self.topText = topText
        self.bottomText = bottomText
        super.init(frame: CGRect.zero)
        titleLabel?.numberOfLines = 2
        contentHorizontalAlignment = .center
        updateTitle()
        sizeToFit()
    }
    
    required init?(coder: NSCoder) {
        self.topText = ""
        self.bottomText = ""
        super.init(coder: coder)
        titleLabel?.numberOfLines = 2
    }
    
    func updateTitle() {
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        style.lineSpacing = 5
        
        let attrStr = NSMutableAttributedString(string: topText, attributes: [
            NSAttributedString.Key.font : topFont,
            NSAttributedString.Key.foregroundColor: topColor,
            NSAttributedString.Key.paragraphStyle: style
        ])
        attrStr.append(NSAttributedString(string: "\n"))
        attrStr.append(NSAttributedString(string: bottomText, attributes: [
            NSAttributedString.Key.font : bottomFont,
            NSAttributedString.Key.foregroundColor: bottomColor,
            NSAttributedString.Key.paragraphStyle: style
        ]))
        setAttributedTitle(attrStr, for: .normal)
    }
}
