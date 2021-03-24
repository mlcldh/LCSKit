//
//  LCSTableViewSection.swift
//  LCSKit
//
//  Created by menglingchao on 2021/3/22.
//  Copyright © 2021 MengLingChao. All rights reserved.
//

import UIKit


public class LCSTableViewSection: NSObject {
    
    /// model数组
    var models: [Any] = []
    /// section头部高度回调
    public var headerHeightHandler:((Int) -> CGFloat)?
    /// section头部视图回调
    public var headerViewHandler:((Int) -> UIView)?
    /// section底部高度回调
    public var footerHeightHandler:((Int) -> CGFloat)?
    /// section底部视图回调
    public var footerViewHandler:((Int) -> UIView)?
    
    /// cell类回调
    public var cellClassHandler:((IndexPath) -> UITableViewCell.Type)?
    /// 配置cell回调
    public var configCellHandler:((UITableViewCell, Any, IndexPath) -> Void)?
    /// cell高度回调
    public var cellHeightHandler:((IndexPath) -> CGFloat)?
    /// 点击cell回调
    public var didSelectHandler:((IndexPath) -> Void)?
    
}
