//
//  String+LCSKit.swift
//  LCSKit
//
//  Created by menglingchao on 2020/9/15.
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
    public func lcs_JSONObject() -> Any? {
        guard let stringNS = self as? NSString, let jsonData = data(using: .utf8), let jsonObject = try? JSONSerialization.jsonObject(with: jsonData) else {
            return nil
        }
        return jsonObject
    }
}
