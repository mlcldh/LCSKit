//
//  LCSFanShapedView.swift
//  LCSKit
//
//  Created by menglingchao on 2021/1/29.
//  Copyright © 2021 MengLingChao. All rights reserved.
//

import UIKit

/// 扇形视图
public class LCSFanShapedView: UIView {
    
    /// 圆背景
    public let backgroundView = UIView()
    /// 扇形
    public let line = LCSShapeLayerView()
    
    public init(width: CGFloat) {
        super.init(frame: CGRect(x: 0, y: 0, width: width, height: width))
        
        backgroundView.backgroundColor = .lightGray
        backgroundView.layer.cornerRadius = width / 2
        addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: width / 2, height: width / 2))
        
        line.shapeLayer().lineWidth = width / 2
        line.shapeLayer().fillColor = UIColor.clear.cgColor
        line.shapeLayer().strokeColor = UIColor.systemBlue.cgColor
        line.shapeLayer().path = path.cgPath
        line.shapeLayer().strokeEnd = 0
        addSubview(line)
        line.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalToSuperview().multipliedBy(0.5)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
