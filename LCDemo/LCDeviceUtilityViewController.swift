//
//  LCDeviceUtilityViewController.swift
//  LCSKitDemo
//
//  Created by menglingchao on 2020/9/15.
//  Copyright © 2020 MengLingChao. All rights reserved.
//

import UIKit
import LCSKit

class LCDeviceUtilityViewController: LCBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        getIdfaAndIdfv()
        getMachine()
    }
    // MARK: -
    private func getIdfaAndIdfv() {
        print("menglc idfa \(LCSDeviceUtility.idfa())")
        print("menglc identifierForVendor \(LCSDeviceUtility.identifierForVendor())")
    }
    private func getMachine() {
        print("menglc idfa \(LCSDeviceUtility.machine())")
    }
}
