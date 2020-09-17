//
//  LCUrlEncodeViewController.swift
//  LCSKitDemo
//
//  Created by menglingchao on 2020/9/15.
//  Copyright © 2020 MengLingChao. All rights reserved.
//

import UIKit

class LCUrlEncodeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .white
        
        useUrlEncode()
        useUrlDecode()
    }
    // MARK: -
    func useUrlEncode() {//URL编码
        let string = "https://www.baidu.com/s?ie=UTF-8&wd=mac电脑&name=你猜啊"
        let encodeString = string.lcs_urlEncode()
        print("menglc string = \(string),\n encodeString = \(encodeString ?? "nil")")
    }
    func useUrlDecode() {//URL解码
        let string = "https://www.baidu.com/s?ie=UTF-8&wd=mac电脑&name=你猜啊"
        let encodeString = string.lcs_urlEncode()
        let decodeString = (encodeString ?? "").lcs_urlDecode()
        print("menglc string = \(string),\n encodeString = \(encodeString ?? "nil"),\n decodeString = \(decodeString ?? "nil")")
    }
}
