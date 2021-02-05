//
//  LCJsonViewController.swift
//  LCSKitDemo
//
//  Created by menglingchao on 2020/10/10.
//  Copyright © 2020 MengLingChao. All rights reserved.
//

import UIKit

class LCJsonViewController: LCBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        getJSONString()
        getJSONObject()
    }
    // MARK: -
    private func getJSONString() {
        let obj = " "
//        let obj:[String] = []
//        let obj = ["Tom", "Jim", "Jordon"]
//        let obj:[String: Any] = ["name": "Tom", "age": 22, "height": 1.98]
        
//        class Person: NSObject {
//            var name: String
//            var age: Int
//            var height: Double
//            init(name aName: String, age aAge: Int, height aHeight: Double) {
//                name = aName
//                age = aAge
//                height = aHeight
//                super.init()
//            }
//        }
        
//        let obj = Person(name: "James", age: 36, height: 2.06)
//        let obj = [Person(name: "James", age: 36, height: 2.06)]
        
        do {
            if let objNS = obj as NSObject?, let jsonString = try objNS.lcs_JSONString() {
                print("menglc getJSONString \(jsonString)")
            } else {
                print("menglc getJSONString nil")
            }
        } catch LCSObjectError.invalidJSONObject {
            print("menglc lcs_JSONString LCSMessageError invalidJSONObject.")
        } catch {
            print("menglc lcs_JSONString error: \(error).")
        }
    }
    private func getJSONObject() {
        let jsonString = " "
//        let jsonString = "[\"Tom\",\"Jim\",\"Jordon\"]"
//        let jsonString = "{\"name\": \"Tom\", \"age\": 22, \"height\": 1.98}"
        do {
            if let jsonObject = try jsonString.lcs_JSONObject() {
                print("menglc getJSONObject \(jsonObject)")
            }
        } catch {
            print("menglc lcs_JSONObject error: \(error).")
        }
    }
}
