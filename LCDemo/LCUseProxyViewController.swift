//
//  LCUseProxyViewController.swift
//  LCDemo
//
//  Created by menglingchao on 2022/10/27.
//

import UIKit
import LCSKit

class LCUseProxyViewController: LCBaseViewController {
    
    var timer: Timer?
    
    deinit {
        timer?.invalidate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        useProxy()
    }
    // MARK: - 
    private func useProxy() {
        let proxy = LCSProxy<Timer> { _ in
            print("menglc timerAction \(Date().timeIntervalSince1970)")
        }
        
        timer = Timer(timeInterval: 1, target: proxy, selector: #selector(proxy.proxyAction), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .common)
    }
}
