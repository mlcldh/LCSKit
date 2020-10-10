//
//  NSObject+LCSKit.swift
//  LCSKit
//
//  Created by menglingchao on 2020/9/15.
//

import Foundation

extension NSObject {
    public func lcs_JSONString() -> String? {
        let jsonData = try! JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
        let string = String(data: jsonData, encoding: .utf8)
        
        return string
    }
}
