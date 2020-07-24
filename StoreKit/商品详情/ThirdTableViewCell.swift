//
//  ThirdTableViewCell.swift
//  NMWeiShi
//
//  Created by XXXX on 2020/5/15.
//

import UIKit
import Rswift

class ThirdTableViewCell: XBaseTableCell {
    //MARK: - 赋值
    
    var pictures:[ImageResource] = [] {
        didSet {
            /// 设置评论图片
            if pictures.count > 0 {
                self.findAll.isHidden = false
                self.titleLabel.text = "宝贝评论(116)"

                let margin:CGFloat = 12
                let imgW:CGFloat = (SCREEN_WIDTH - margin * 4)/3
                let imgH:CGFloat = imgW
                
                for item in self.imagesView.subviews {
                    if item.isKind(of: UIImageView.self) || item.isKind(of: UIControl.self) {
                        item.removeFromSuperview()
                    }
                }
                
                for i in 0..<pictures.count {
                    let imgX:CGFloat = margin + ((margin + imgW) * CGFloat(i))
                    let iv = UIImageView.init(image:UIImage.init(resource: pictures[i]))
                    iv.frame = CGRect(x: imgX, y: 0, width: imgW, height: imgH)
                    iv.layer.cornerRadius = 4
                    iv.layer.masksToBounds = true
                    self.imagesView.addSubview(iv)
                    
                    let control = UIControl.init()
                    control.frame = CGRect(x: imgX, y: 0, width: imgW, height: imgH)
                    control.addTarget(self, action: #selector(clickFindBigImage), for: .touchUpInside)
                    self.imagesView.addSubview(control)
                }
            } else {
                self.findAll.isHidden = true
                self.titleLabel.text = "暂无评论！"
            }
        }
    }
    //MARK: - 设置UI
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.backgroundColor = UIColor.qd_shopMain
        self.contentView.addSubview(findAll)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(line)
        self.contentView.addSubview(icon)
        self.contentView.addSubview(userName)
        self.contentView.addSubview(date)
        self.contentView.addSubview(infoLabel)
        self.contentView.addSubview(imagesView)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        findAll.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-12)
            make.top.equalToSuperview()
            make.width.equalTo(72)
            make.height.equalTo(44)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(12)
            make.centerY.equalTo(findAll.snp.centerY)
        }
        
        line.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(0.5)
            make.top.equalTo(findAll.snp.bottom)
        }
        
        icon.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(12)
            make.top.equalTo(line.snp.bottom).offset(12)
            make.height.width.equalTo(36)
        }
        icon.layer.cornerRadius = 18
        icon.layer.masksToBounds = true
        
        userName.snp.makeConstraints { (make) in
            make.left.equalTo(icon.snp.right).offset(8)
            make.top.equalTo(icon.snp.top)
        }
        
        date.snp.makeConstraints { (make) in
            make.bottom.equalTo(icon.snp.bottom)
            make.left.equalTo(icon.snp.right).offset(8)
        }
        
        infoLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.top.equalTo(icon.snp.bottom).offset(12)
        }

        imagesView.snp.makeConstraints { (make) in
            make.top.equalTo(infoLabel.snp.bottom).offset(12)
            make.left.right.equalToSuperview()
            if self.pictures.count > 0 {
                make.height.equalTo((SCREEN_WIDTH - 12 * 4)/3)
            } else {
                make.height.equalTo(0)
            }
        }

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - 点击方法
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    /// 点击查看全部评论
    @objc func clickFindAllBtn() {
        print("查看全部评论")
    }
    
    @objc func clickFindBigImage() {
        print("查看图片")
    }
    
    //MARK: - 懒加载
    lazy var findAll: QMUIButton = {
        let btn = QMUIButton.init(type: .custom)
        btn.setTitle("查看全部", for: .normal)
        btn.setTitleColor(UIColor.qd_tint, for: .normal)
        btn.titleLabel?.font = .pingFangRegular(ofSize: 14)
        btn.setImage(R.image.sy_spxq_jiantou2_yellow(), for: .normal)
        btn.imagePosition = .right
        btn.addTarget(self, action: #selector(clickFindAllBtn), for: .touchUpInside)
        return btn
    }()
    
    /// 标题
    lazy var titleLabel: QMUILabel = {
        let label = QMUILabel.init()
        label.text = "宝贝评论(116)"
        label.font = .pingFangRegular(ofSize: 16)
        label.textColor = UIColor.qd_titleText
        return label
    }()
    
    /// 头像
    lazy var icon: UIImageView = {
        let iv = UIImageView.init(image: nil)

        return iv
    }()
    
    /// 用户名
    lazy var userName: QMUILabel = {
        let label = QMUILabel.init()
        label.textColor = UIColor.qd_titleText
        label.font = .pingFangRegular(ofSize: 14)
        label.textAlignment = .left
        label.text = "柠***檬"
        return label
    }()
    
    /// 日期
    lazy var date: QMUILabel = {
        let label = QMUILabel.init()
        label.textAlignment = .left
        label.text = "2020-05-15 13:11:50"
        label.textColor = UIColor.qd_descriptionText
        label.font = .pingFangRegular(ofSize: 12)
        return label
    }()
    
    /// 内容
    lazy var infoLabel: QMUILabel = {
        let label = QMUILabel.init()
        label.text = "👍这也太闪了吧，超级赞！👍这也太闪了吧，超级赞！👍这也太闪了吧，超级赞！👍这也太闪了吧，超级赞！👍这也太闪了吧，超级赞！👍这也太闪了吧，超级赞！👍"
        label.textColor = UIColor.qd_titleText
        label.font = .pingFangRegular(ofSize: 14)
        label.numberOfLines = 2
        return label
    }()
    
    /// 评论图片
    lazy var imagesView: UIView = {
        let v = UIView.init()
        return v
    }()
    
    /// 分割线
    lazy var line: UIView = {
        let v = UIView.init()
        v.backgroundColor = UIColor.qd_shopMain.qmui_colorWithAlphaAdded(toWhite: 0.9)
        return v
    }()
}
