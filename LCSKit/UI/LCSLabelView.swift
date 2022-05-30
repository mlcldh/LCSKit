//
//  LCSLabelView.swift
//  LCSKit
//
//  Created by menglingchao on 2020/9/15.
//  Copyright © 2020 MengLingChao. All rights reserved.
//

import UIKit
import SnapKit

/***/
public class LCSLabelView: UIView {
    
    /***/
    public let label = UILabel()
    /**label离LCSLabelView四周的间距*/
    public var labelContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) {
        didSet {
            label.snp.makeConstraints { (make) in
                make.edges.equalToSuperview().inset(labelContainerInset)
            }
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(label)
        label.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
