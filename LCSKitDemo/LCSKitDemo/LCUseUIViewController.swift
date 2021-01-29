//
//  LCUseUIViewController.swift
//  LCSKitDemo
//
//  Created by menglingchao on 2021/1/29.
//  Copyright © 2021 MengLingChao. All rights reserved.
//

import UIKit
import LCSKit

class LCUseUIViewController: LCBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        useLCSAnnularView()
        useLCSAnnularView2()
        useLCSAnnularView3()
        useLCSAnnularView4()
    }
    // MARK: -
    func useLCSAnnularView() {//圆环
        let width: CGFloat = 100
        let height: CGFloat = width
        
        let annularView = LCSAnnularView(width: width, height: height, rounded: true, strokeThickness: 6)
        annularView.line.shapeLayer().lineCap = .round
        annularView.line.shapeLayer().strokeEnd = 0.3//环结束位置
        view.addSubview(annularView)
        annularView.snp_makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(100)
            make.width.equalTo(width)
            make.height.equalTo(height)
        }
    }
    func useLCSAnnularView2() {//四角圆环
        let width: CGFloat = 200
        let height: CGFloat = 100
        
        let annularView = LCSAnnularView(width: width, height: height, rounded: true, strokeThickness: 6)
        annularView.line.shapeLayer().strokeEnd = 0.3
        view.addSubview(annularView)
        annularView.snp_makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(250)
            make.width.equalTo(width)
            make.height.equalTo(height)
        }
    }
    func useLCSAnnularView3() {//椭圆环
        let width: CGFloat = 200
        let height: CGFloat = 100
        
        let annularView = LCSAnnularView(width: width, height: height, rounded: false, strokeThickness: 6)
        annularView.line.shapeLayer().strokeEnd = 0.3
        view.addSubview(annularView)
        annularView.snp_makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(400)
            make.width.equalTo(width)
            make.height.equalTo(height)
        }
    }
    func useLCSAnnularView4() {//饼形图
        let width: CGFloat = 100
        let height: CGFloat = width
        
        let annularView = LCSAnnularView(width: width, height: height, rounded: true, strokeThickness: width/2)
        annularView.line.shapeLayer().strokeEnd = 0.3
        view.addSubview(annularView)
        annularView.snp_makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(550)
            make.width.equalTo(width)
            make.height.equalTo(height)
        }
    }
}
