//
//  FourthTableViewCell.swift
//  NMWeiShi
//
//  Created by XXXX on 2020/5/15.
//

import UIKit

class FourthTableViewCell: XBaseTableCell {
    
    //MARK: - 赋值
    private var bannerSource = [
        R.image.popup_bg,
        R.image.popup_bg,
        R.image.popup_bg,
    ]
    var isPicture = false {
        didSet {
            shopName.text = "美妆博主小于的店"
            goodsNum.text = "共99件商品"
            
            /// 设置评论图片
            let margin:CGFloat = 12
            let imgW:CGFloat = (SCREEN_WIDTH - margin * 4)/3
            let imgH:CGFloat = imgW * 175 / 110
            let model = GoodsModel()
            model.price = 249.5
            model.courierPrice = 328

            model.goodsImg = "https://goss.veer.com/creative/vcg/veer/800water/veer-308318668.jpg"
            for item in self.goodsView.subviews {
                if item.isKind(of: SKGoodsCell.self) || item.isKind(of: UIControl.self) {
                    item.removeFromSuperview()
                }
            }
            for i in 0..<3 {
                let imgX:CGFloat = margin + ((margin + imgW) * CGFloat(i))
//                let iv = UIImageView.init(image:UIImage.init(resource: bannerSource[i]))
                let iv = SKGoodsCell()
                iv.model = model
//                iv.lvlLive.isHidden = true
                iv.frame = CGRect(x: imgX, y: 0, width: imgW, height: imgH)
                iv.layer.cornerRadius = 4
                iv.layer.masksToBounds = true
                self.goodsView.addSubview(iv)
                
                let control = UIControl.init()
                control.frame = CGRect(x: imgX, y: 0, width: imgW, height: imgH)
                control.addTarget(self, action: #selector(clickFindGoods), for: .touchUpInside)
                self.goodsView.addSubview(control)
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColor.qd_shopMain
        self.contentView.addSubview(icon)
        self.contentView.addSubview(shopName)
        self.contentView.addSubview(shop)
        self.contentView.addSubview(goodsNum)
        self.contentView.addSubview(inpuShopBtn)
        self.contentView.addSubview(line)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(findAllBtn)
        self.contentView.addSubview(goodsView)  

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        icon.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(12)
            make.width.height.equalTo(40)
            make.top.equalToSuperview().offset(12)
        }
        
        shopName.snp.makeConstraints { (make) in
            make.left.equalTo(icon.snp.right).offset(12)
            make.top.equalTo(icon.snp.top)
        }
        
        shop.snp.makeConstraints { (make) in
            make.left.equalTo(icon.snp.right).offset(12)
            make.bottom.equalTo(icon.snp.bottom)
            make.width.equalTo(72)
        }
        
        goodsNum.snp.makeConstraints { (make) in
            make.left.equalTo(shop.snp.right).offset(4)
            make.centerY.equalTo(shop.snp.centerY)
        }
        
        inpuShopBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-12)
            make.centerY.equalTo(icon.snp.centerY)
            make.height.equalTo(30)
            make.width.equalTo(72)
        }
        
        inpuShopBtn.layer.masksToBounds = true
        inpuShopBtn.layer.cornerRadius = 15
        
        line.snp.makeConstraints { (make) in
            make.height.equalTo(0.5)
            make.left.right.equalToSuperview()
            make.top.equalTo(icon.snp.bottom).offset(12)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(12)
            make.height.equalTo(44)
            make.top.equalTo(line.snp.bottom)
        }
        
        findAllBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-12)
            make.centerY.equalTo(titleLabel.snp.centerY)
        }
        
        goodsView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom)
            make.width.equalTo(SCREEN_WIDTH)
            make.height.equalTo((SCREEN_WIDTH - 12 * 4)/3 * 175 / 110)
        }
    }
    //MARK: - 点击方法
    @objc func clickInputShop() {
        print("进入店铺")
    }
    
    @objc func clickFindAll() {
        print("查看全部")
    }

    @objc func clickFindGoods() {
        print("查看商品")
    }
    
    //MARK: - 懒加载
    
    /// 头像
    private lazy var icon: UIImageView = {
        let iv = UIImageView.init(image: R.image.sk_store())
        return iv
    }()
    
    /// 店名
    private lazy var shopName: QMUILabel = {
        let label = QMUILabel.init()
        label.textAlignment = .left
        label.textColor = UIColor.qd_titleText
        label.font = .pingFangRegular(ofSize: 14)
        return label
    }()
    
    /// 他的小店
    private lazy var shop: QMUILabel = {
        let label = QMUILabel.init()
        label.backgroundColor = UIColor.qd_shopMain.withAlphaComponent(0.9)
        label.text = "他的小店"
        label.textAlignment = .center
        label.textColor = UIColor.qd_titleText
        label.font = .pingFangRegular(ofSize: 12)
        return label
    }()
    
    /// 商品数
    private lazy var goodsNum: QMUILabel = {
        let label = QMUILabel.init()
        label.textAlignment = .left
        label.textColor = UIColor.qd_descriptionText
        label.font = .pingFangRegular(ofSize: 12)
        return label
    }()
    
    /// 进入店铺按钮
    private lazy var inpuShopBtn: QMUIButton    = {
        let btn = QMUIButton.init(type: .custom)
        btn.setTitle("进入店铺", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.titleLabel?.font = .pingFangRegular(ofSize: 14)
        btn.backgroundColor = UIColor.qd_tint
        btn.addTarget(self, action: #selector(clickInputShop), for: .touchUpInside)
        return btn
    }()
    
    /// 店铺推荐
    private lazy var titleLabel: QMUILabel = {
        let label = QMUILabel.init()
        label.text = "店铺推荐"
        label.textAlignment = .left
        label.textColor = UIColor.qd_titleText
        label.font = .pingFangRegular(ofSize: 16)
        return label
    }()
    
    /// 查看全部
    private lazy var findAllBtn: QMUIButton = {
        let btn = QMUIButton.init(type: .custom)
        btn.setTitle("进入店铺", for: .normal)
        btn.setTitleColor(UIColor.qd_tint, for: .normal)
        btn.setImage(R.image.sy_spxq_jiantou2_yellow(), for: .normal)
        btn.titleLabel?.font = .pingFangRegular(ofSize: 14)
        btn.addTarget(self, action: #selector(clickFindAll), for: .touchUpInside)
        btn.imagePosition = .right
        return btn
    }()
    
    /// 推荐商品
    private lazy var goodsView: UIView = {
        let v = UIView.init()
        return v
    }()
    
    private lazy var line: UIView = {
        let v = UIView.init()
        v.backgroundColor = UIColor.qd_shopMain.withAlphaComponent(0.9)
        return v
    }()

}
