//
//  SecondTableViewCell.swift
//  NMWeiShi
//
//  Created by XXXX on 2020/5/15.
//

import UIKit

class SecondTableViewCell: XBaseTableCell {
    
    lazy var infoLabel: QMUILabel = {
        let label = QMUILabel.init()
        label.font = .pingFangBold(ofSize: 14)
        label.textColor = UIColor.qd_descriptionText
        label.textAlignment = .left
        return label
    }()
    
    lazy var chooseLabel: QMUILabel = {
        let label = QMUILabel.init()
                label.font = .pingFangBold(ofSize: 14)
        label.textColor = UIColor.qd_titleText
        label.textAlignment = .left
        return label
    }()
    
    lazy var arrowBtn: QMUIButton = {
        let btn = QMUIButton.init(type: .custom)
        btn.setImage(R.image.sy_spxq_jiantou2_white(), for: .normal)
        btn.isUserInteractionEnabled = false
        return btn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColor.qd_shopMain
        self.contentView.addSubview(infoLabel)
        self.contentView.addSubview(chooseLabel)
        self.contentView.addSubview(arrowBtn)
        
        infoLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(12)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(36)
        }
        arrowBtn.snp.makeConstraints { (make) in
            make.width.height.equalTo(15)
            make.right.equalToSuperview().offset(-12)
            make.centerY.equalToSuperview()
        }
        chooseLabel.snp.makeConstraints { (make) in
            make.left.equalTo(infoLabel.snp.right)
            make.top.bottom.equalToSuperview()
            make.right.equalTo(arrowBtn.snp.left)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
