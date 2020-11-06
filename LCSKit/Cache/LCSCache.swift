//
//  LCSCache.swift
//  Pods
//
//  Created by menglingchao on 2020/11/2.
//

import UIKit
import YYCache

class LCSCache: NSObject {
    override init() {
        super.init()
        
        let yycache = YYCache(path: "")
        print("menglc yycache \(yycache)")
    }
}
