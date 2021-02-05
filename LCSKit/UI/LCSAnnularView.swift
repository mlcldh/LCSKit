//
//  LCSAnnularView.swift
//  LCSKit
//
//  Created by menglingchao on 2021/1/29.
//  Copyright © 2021 MengLingChao. All rights reserved.
//

import UIKit

/**环形/饼形视图*/
public class LCSAnnularView: UIView {
    
    /// 环背景
    public let lineBackground = LCSShapeLayerView()
    /// 环
    public let line = LCSShapeLayerView()
    
    /// 便利构造器
    /// - Parameters:
    ///   - strokeThickness: 环宽度
    ///   - width: 宽度，height也使用width
    ///   - rounded: 是否是圆角，针对width、height不相等时
    public convenience init(strokeThickness: CGFloat, width: CGFloat, rounded: Bool = true) {
        self.init(strokeThickness: strokeThickness, width: width, height: width, rounded: rounded)
    }
    
    /// 指定构造器
    /// - Parameters:
    ///   - strokeThickness: 环宽度
    ///   - width: 宽度
    ///   - height: 高度
    ///   - rounded: 是否是圆角，针对width、height不相等时
    public init(strokeThickness: CGFloat, width: CGFloat, height: CGFloat, rounded: Bool = true) {
        super.init(frame: CGRect(x: 0, y: 0, width: width, height: height))
        
        lineBackground.shapeLayer().lineWidth = strokeThickness
        lineBackground.shapeLayer().fillColor = UIColor.clear.cgColor
        lineBackground.shapeLayer().strokeColor = UIColor.lightGray.cgColor
        let path: UIBezierPath
        if rounded {
            path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: width - strokeThickness, height: height - strokeThickness), cornerRadius: (min(width, height) - strokeThickness) / 2)
        } else {
            path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: width - strokeThickness, height: height - strokeThickness))
        }
        lineBackground.shapeLayer().path = path.cgPath
        addSubview(lineBackground)
        lineBackground.snp_makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.height.equalToSuperview().offset(-strokeThickness)
        }
        
        line.shapeLayer().lineWidth = strokeThickness
        line.shapeLayer().fillColor = UIColor.clear.cgColor
        line.shapeLayer().strokeColor = UIColor.systemBlue.cgColor
        line.shapeLayer().path = path.cgPath
        line.shapeLayer().strokeEnd = 0
        addSubview(line)
        line.snp_makeConstraints { (make) in
            make.edges.equalTo(lineBackground)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
