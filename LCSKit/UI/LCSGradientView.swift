//
//  LCSGradientView.swift
//  LCSKit
//
//  Created by menglingchao on 2020/9/15.
//  Copyright © 2020 MengLingChao. All rights reserved.
//

import UIKit

/***/
public class LCSGradientView: UIView {
    
    public override class var layerClass: AnyClass {
        CAGradientLayer.self
    }
    public func gradientLayer() -> CAGradientLayer {
        layer as! CAGradientLayer
    }
}
