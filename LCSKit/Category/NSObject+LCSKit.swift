//
//  NSObject+LCSKit.swift
//  LCSKit
//
//  Created by menglingchao on 2020/9/15.
//  Copyright © 2020 MengLingChao. All rights reserved.
//

import Foundation

extension NSObject {
    
    /// 错误
    public enum LCSObjectError: Error {
        case invalidJSONObject
    }
    
    /// 将返回自己对应的JSON字符串
    /// - Returns: JSON字符串
    public func lcs_JSONString() throws -> String? {
        guard JSONSerialization.isValidJSONObject(self) else {//需要加这个判断，否则执行try JSONSerialization.data可能会闪退
            throw LCSObjectError.invalidJSONObject
        }
        let jsonData = try JSONSerialization.data(withJSONObject: self, options: [])
        let string = String(data: jsonData, encoding: .utf8)
        return string
    }
}
