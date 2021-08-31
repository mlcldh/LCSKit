//
//  LCBaseViewController.swift
//  LCSKitDemo
//
//  Created by menglingchao on 2020/12/18.
//  Copyright © 2020 MengLingChao. All rights reserved.
//

import UIKit

class LCBaseViewController: UIViewController {
    
    deinit {
        print("menglc deinit \(self)")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .white
        
        title = "\(self.classForCoder)"
    }
}
