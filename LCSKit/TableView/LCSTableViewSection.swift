//
//  LCSTableViewSection.swift
//  LCSKit
//
//  Created by menglingchao on 2021/3/22.
//  Copyright © 2021 MengLingChao. All rights reserved.
//

import UIKit


public class LCSTableViewSection: NSObject {
    
    /// row数组
    public var rows: [LCSTableViewRow] = []
    /// section头部高度回调
    public var headerHeightHandler:((Int) -> CGFloat)?
    /// section头部视图回调
    public var headerViewHandler:((Int) -> UIView)?
    /// section底部高度回调
    public var footerHeightHandler:((Int) -> CGFloat)?
    /// section底部视图回调
    public var footerViewHandler:((Int) -> UIView)?
    
}
