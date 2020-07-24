//
//  FifthTableViewCell.swift
//  NMWeiShi
//
//  Created by XXXX on 2020/5/15.
//

import UIKit

class FifthTableViewCell: XBaseTableCell {
    
    var picture:UIImage = UIImage() {
        didSet {
            self.picturesView.image = picture
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(picturesView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        picturesView.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalToSuperview()
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
    
    //MARK: - 懒加载
    private lazy var picturesView:UIImageView = {
       let iv = UIImageView()
        return iv
    }()
    
//    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
//
//        let scale = newWidth / image.size.width
//        let newHeight = image.size.height * scale
//        UIGraphicsBeginImageContext(CGSize(width:newWidth, height:newHeight))
//        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
//        let newImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//
//        return newImage!
//    }
}
