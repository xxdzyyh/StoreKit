//
//  XTopTabBar.swift
//  XFoundation
//
//  Created by xiaoniu on 2018/11/1.
//  Copyright © 2018年 com.learn. All rights reserved.
//

import UIKit

@objc protocol XTopTabBarDelegate {
    
    @objc optional func titlesForTopTabBar(topTabBar: XTopTabBar) -> (Array<String>)
    @objc optional func attributeTitlesForTopbar(topTabBar: XTopTabBar) -> (Array<NSAttributedString>)
    @objc optional func topTabBarDidSelectedItemAtIndex(topTabBar: XTopTabBar,index: Int)
}

public class XTopTabBar: UIView,UIScrollViewDelegate {
    
    weak var delegate: XTopTabBarDelegate? {
        didSet {
            if (self.delegate != nil) {
                self .reloadData()
            }
        }
    }
    
    var titles: Array<Any>?
    
    var indicatorWidth: Float = 8.0
    var indicatorHeight: Float = 2.0
    var indicatorColor: UIColor?
    var indicatorView: UIView = UIView.init()
    
    var normalTitleColor: UIColor?
    var selectTitleColor: UIColor?
    var normalTitleFont: UIFont?
    var selectTitleFont: UIFont?
    
    weak var scrollView: UIScrollView? {
        didSet {
            self.scrollView?.isPagingEnabled = true
            self.scrollView?.delegate = self
        }
    }
    
    private(set) var buttons : Array<UIButton>?
    
    var selectedIndex : Int = 0
    
    func selectItemAtIndex(_ index:Int) {
        if self.selectedIndex == index {
            return;
        } else {
            self.onItemClick(button: self.buttons![index])
        }
    }
    
    var buttonContainer : UIScrollView = {
        let v = UIScrollView.init()
        
        v.tag = 10000
        v.showsVerticalScrollIndicator = false
        v.showsHorizontalScrollIndicator = false
        
        return v
    }()
    
    func reloadData() {
        if self.delegate != nil {
            
            var titles : Array<Any>? = self.delegate!.attributeTitlesForTopbar?(topTabBar: self)
            
            if titles != nil {
                self.titles = titles
            } else {
                titles = self.delegate!.titlesForTopTabBar?(topTabBar: self)
                
                if titles != nil {
                    self.titles = titles
                }
            }
            
            if (self.titles == nil) {
                return;
            }
            
            // items
            self.buttonContainer.frame = CGRect(x: 0.0, y: 0.0, width: self.bounds.size.width, height: self.bounds.size.height - CGFloat(self.indicatorHeight))
            
            let width = Int(self.bounds.size.width) / (self.titles?.count ?? 1)
            
            var array:Array<UIButton> = Array.init()
            
            for i in 0..<self.titles!.count {
                let button = UIButton.init(type: .custom)
                
                button.tag = i
                button.frame = CGRect(x: width * i, y: 0, width: width, height: Int(self.buttonContainer.bounds.size.height))
                button.titleLabel?.font = self.normalTitleFont ?? UIFont.systemFont(ofSize: 14)
                button.setTitleColor(self.normalTitleColor ?? UIColor.black, for: .normal)
                button.setTitleColor(self.selectTitleColor ?? UIColor.black, for: .selected)
            
                let title = self.titles![i]
                
                if title is NSAttributedString {
                    button.setAttributedTitle(title as? NSAttributedString, for: .normal)
                } else {
                    button.setTitle(title as? String, for: .normal)
                }
                
                button.addTarget(self, action: #selector(onItemClick(button:)), for: .touchUpInside)
                
                self.buttonContainer.addSubview(button)
                
                array.append(button)
            }
            
            self.buttons = array
            
            self.addSubview(self.buttonContainer)
        
            self.indicatorView.backgroundColor = self.indicatorColor ?? UIColor.orange
            self.indicatorView.frame = CGRect(x: 0, y: 0, width: CGFloat(self.indicatorWidth), height: CGFloat(self.indicatorHeight))
            self.indicatorView.center = CGPoint.init(x: CGFloat(width/2), y: self.bounds.size.height - CGFloat(self.indicatorHeight/2))

            self.addSubview(self.indicatorView)
        }
    }
    
    @objc private func onItemClick(button:UIButton) {
        let index = button.tag
        
        if (self.selectedIndex == index) {
            return;
        }
        
        // 按钮
        let selectedButton = self.buttons![self.selectedIndex]
        
        selectedButton.isSelected = false
        selectedButton.titleLabel?.font = self.normalTitleFont ?? UIFont.systemFont(ofSize: 14)
        
        button.isSelected = true
        button.titleLabel?.font = self.selectTitleFont ?? UIFont.systemFont(ofSize: 15)
        
        self.selectedIndex = index
        
        // 指示器
        if self.scrollView != nil {
            self.scrollView!.setContentOffset(CGPoint(x:Int(self.scrollView!.bounds.size.width)*index,y:0), animated: true)
        } else {
            UIView.animate(withDuration: 0.2) { 
                self.indicatorView.center = CGPoint(x: button.center.x, y: self.indicatorView.center.y)
            }
        }
        
        // 回调
        self.delegate?.topTabBarDidSelectedItemAtIndex?(topTabBar: self, index: index)
    }
    
    //MARK: - UIScrollViewDelegate
    
    /// 滑动scrollView的时候，同时滑动指示器
    ///
    /// - Parameter scrollView: 内容
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView == self.scrollView) {
            if scrollView.bounds.size.width == 0 {
                return
            }
            
            if (self.titles?.count == 0) {
                return
            }
            
            let x = scrollView.contentOffset.x
            let w = self.bounds.size.width/CGFloat(self.titles?.count ?? 1)
            
            self.indicatorView.center = CGPoint(x: (x/scrollView.bounds.size.width*w+w/2), y: self.indicatorView.center.y)
        }
    }
    
    // 直接滑动scrollView会触发，setContentOffset: animated: 不会触发
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if (scrollView == self.scrollView) {
            let index = Int(scrollView.contentOffset.x/scrollView.bounds.size.width)
            
            if index == self.selectedIndex {
                return
            }
            
            // 按钮
            let selectedButton = self.buttons![self.selectedIndex]
            
            selectedButton.isSelected = false
            selectedButton.titleLabel?.font = self.normalTitleFont ?? UIFont.systemFont(ofSize: 14)
            
            let button = self.buttons![index]
            
            button.isSelected = true
            button.titleLabel?.font = self.selectTitleFont ?? UIFont.systemFont(ofSize: 15)
            
            self.selectedIndex = index
        
            // 回调
            self.delegate?.topTabBarDidSelectedItemAtIndex?(topTabBar: self, index: index)
        }
    }
    
    
    
}
