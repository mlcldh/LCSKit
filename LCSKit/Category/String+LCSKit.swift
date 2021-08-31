//
//  String+LCSKit.swift
//  LCSKit
//
//  Created by menglingchao on 2020/9/15.
//  Copyright © 2020 MengLingChao. All rights reserved.
//

import Foundation

extension String {
    
    /**URL编码*/
    public func lcs_urlEncode() -> String? {
        guard let encodeString = addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else {
            return nil
        }
        return encodeString
    }
    /**URL解码*/
    public func lcs_urlDecode() -> String? {
        guard let decodeString = removingPercentEncoding else {
            return nil
        }
        return decodeString
    }
    public func lcs_JSONObject() throws -> Any? {
        guard let jsonData = data(using: .utf8) else {
            return nil
        }
        let jsonObject = try JSONSerialization.jsonObject(with: jsonData)
        return jsonObject
    }
    /// 获取子字符串
    /// - Parameter index: 索引
    /// - Returns: 子字符串
    public func lcs_substringFromIndex(_ index: Int) -> String {
        String(self[self.index(startIndex, offsetBy: index)..<endIndex])
    }
    public func lcs_substringToIndex(_ index: Int) -> String {
        String(self[self.startIndex..<self.index(startIndex, offsetBy: index)])
    }
    /// 获取子字符串
    /// - Parameters:
    ///   - location: 起始位置
    ///   - length: 子字符串的长度
    /// - Returns: 子字符串
    public func lcs_substring(location: Int, length: Int) -> String {
        String(self[self.index(startIndex, offsetBy: location)..<self.index(startIndex, offsetBy: location + length)])
    }
    /// 将十六进制字符串转换为整形UInt32
    public func lcs_UInt32FromHexString() -> UInt32? {
        var intValue: UInt32 = 0
        let scanner = Scanner(string: self)
        guard scanner.scanHexInt32(&intValue) else {
            return nil
        }
        return intValue
    }
    /// 将十六进制字符串转换为整形UInt64
    public func lcs_UInt64FromHexString() -> UInt64? {
        var intValue: UInt64 = 0
        let scanner = Scanner(string: self)
        guard scanner.scanHexInt64(&intValue) else {
            return nil
        }
        return intValue
    }
}
