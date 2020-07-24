//
//  String+XF.swift
//  SPARKVIDEO
//
//  Created by XXXXon 2020/7/17.
//

import Foundation

extension String {
    
    /// 获取子串，包含起始位置
    /// - Parameter index: 起始位置
    /// - Returns: 结果
    func xf_subString(from index:Int) -> String {
        if index <= 0 {
            return self
        }
        
        if index >= self.count {
            return ""
        }
        
        return String(self[self.index(self.startIndex,offsetBy: index)..<self.index(self.startIndex,offsetBy: self.count)])
    }
    
    
    /// 获取子串，不包含结束位置
    /// - Parameter index: 结束位置
    /// - Returns: 结果
    func xf_subString(to index:Int) -> String  {
        if index >= self.count {
            return self
        }
        
        if index <= 0 {
            return ""
        }
        
        return String(self[..<self.index(self.startIndex,offsetBy: index)])
    }
}
