//
//  LCStringExtensionViewController.swift
//  LCSKitDemo
//
//  Created by menglingchao on 2020/9/15.
//  Copyright © 2020 MengLingChao. All rights reserved.
//

import UIKit
import LCSKit

class LCStringExtensionViewController: LCBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
//        useUrlEncode()
//        useUrlDecode()
        useSubstringFromIndex()
        useSubstringToIndex()
    }
    // MARK: -
    private func useUrlEncode() {//URL编码
        let string = "https://www.baidu.com/s?ie=UTF-8&wd=mac电脑&name=你猜啊"
        let encodeString = string.lcs_urlEncode()
        print("menglc string = \(string),\n encodeString = \(encodeString ?? "nil")")
    }
    private func useUrlDecode() {//URL解码
        let string = "https://www.baidu.com/s?ie=UTF-8&wd=mac电脑&name=你猜啊"
        let encodeString = string.lcs_urlEncode()
        let decodeString = (encodeString ?? "").lcs_urlDecode()
        print("menglc string = \(string),\n encodeString = \(encodeString ?? "nil"),\n decodeString = \(decodeString ?? "nil")")
    }
    private func useSubstringFromIndex() {//
        let string = "abcdefg"
        let string2 = string.lcs_substringFromIndex(1)
        print("menglc useSubstringFromIndex \(string2)")
    }
    private func useSubstringToIndex() {//
        let string = "abcdefg"
        let string2 = string.lcs_substringToIndex(string.count - 1)
        print("menglc useSubstringToIndex \(string2)")
    }
}
