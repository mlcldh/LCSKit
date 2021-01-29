//
//  LCSShapeLayerView.swift
//  LCSKit
//
//  Created by menglingchao on 2020/8/10.
//  Copyright © 2020 MengLingChao. All rights reserved.
//

import UIKit

/***/
public class LCSShapeLayerView: UIView {
    
    public override class var layerClass: AnyClass {
        CAShapeLayer.self
    }
    public func shapeLayer() -> CAShapeLayer {
        guard let aLayer = layer as? CAShapeLayer else {
            return CAShapeLayer()
        }
        return aLayer
    }
}
