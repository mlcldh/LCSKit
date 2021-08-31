//
//  UIColor+LCSKit.swift
//  LCSKit
//
//  Created by menglingchao on 2021/8/27.
//  Copyright © 2021 MengLingChao. All rights reserved.
//

import UIKit

extension UIColor {
    
    /// 通过十六进制获取颜色
    /// - Parameters:
    ///   - hexString: 十六进制字符串
    ///   - alpha: 透明
    /// - Returns: 颜色
    public class func lcs_color(hexString: String, alpha: CGFloat = 1) -> UIColor? {
        guard hexString.count == 6, let redString = hexString.lcs_substring(location: 0, length: 2) as String?, let red = redString.lcs_UInt32FromHexString(), let greenString = hexString.lcs_substring(location: 2, length: 2) as String?, let green = greenString.lcs_UInt32FromHexString(), let blueString = hexString.lcs_substring(location: 4, length: 2) as String?, let blue = blueString.lcs_UInt32FromHexString() else {
            return nil
        }
        return UIColor(red: CGFloat(red)/255, green: CGFloat(green)/255, blue: CGFloat(blue)/255, alpha: alpha)
    }
    
}
