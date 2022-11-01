//
//  LCSProxy.swift
//  LCSKit
//
//  Created by menglingchao on 2022/10/26.
//  Copyright © 2022 MengLingChao. All rights reserved.
//

import UIKit

/// 用来去除循环引用
public class LCSProxy<T> {
    
    private let actionHandler:((T) -> Void)?
    
    public init(actionHandler aActionHandler:((T) -> Void)?) {
        actionHandler = aActionHandler
    }
    // MARK: -
    @objc public func proxyAction(sender: Any) {
        guard let aActionHandler = actionHandler, let aSender = sender as? T else {
            return
        }
        aActionHandler(aSender)
    }
}
