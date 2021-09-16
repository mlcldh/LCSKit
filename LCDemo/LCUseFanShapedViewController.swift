//
//  LCUseFanShapedViewController.swift
//  LCDemo
//
//  Created by menglingchao on 2021/9/15.
//  Copyright © 2021 MengLingChao. All rights reserved.
//

import UIKit
import LCSKit

class LCUseFanShapedViewController: LCBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        useLCSFanShapedView()
    }
    // MARK: -
    func useLCSFanShapedView() {//扇
        let width: CGFloat = 100
        
        let fanShapedView = LCSFanShapedView(width: width)
//        fanShapedView.backgroundColor = .yellow
//        fanShapedView.line.shapeLayer().lineCap = .round
        fanShapedView.line.shapeLayer().strokeEnd = 0.3//扇形结束位置
        view.addSubview(fanShapedView)
        fanShapedView.snp_makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(100)
            make.width.height.equalTo(width)
        }
    }
}
