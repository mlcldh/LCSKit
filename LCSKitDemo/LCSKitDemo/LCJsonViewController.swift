//
//  LCJsonViewController.swift
//  LCSKitDemo
//
//  Created by menglingchao on 2020/10/10.
//  Copyright © 2020 MengLingChao. All rights reserved.
//

import UIKit

class LCJsonViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        getJSONString()
        getJSONObject()
    }
    // MARK: -
    func getJSONString() {
//        let obj:[String] = []
//        let obj = ["Tom", "Jim", "Jordon"]
        let obj:[String: Any] = ["name": "Tom", "age": 22, "height": 1.98]
        if let objNS = obj as NSObject?, let jsonString = objNS.lcs_JSONString() {
            print("menglc getJSONString \(jsonString)")
        }
    }
    func getJSONObject() {
//        let jsonString = " "
//        let jsonString = "[\"Tom\",\"Jim\",\"Jordon\"]"
        let jsonString = "{\"name\": \"Tom\", \"age\": 22, \"height\": 1.98}"
        if let jsonObject = jsonString.lcs_JSONObject() {
            print("menglc getJSONObject \(jsonObject)")
        }
    }
}