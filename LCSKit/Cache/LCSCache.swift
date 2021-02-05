//
//  LCSCache.swift
//  Pods
//
//  Created by menglingchao on 2020/11/2.
//  Copyright © 2020 MengLingChao. All rights reserved.
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
