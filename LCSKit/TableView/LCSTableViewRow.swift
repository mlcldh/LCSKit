//
//  LCSTableViewRow.swift
//  LCSKit
//
//  Created by menglingchao on 2021/3/22.
//  Copyright © 2021 MengLingChao. All rights reserved.
//

import UIKit

public class LCSTableViewRow: NSObject {
    
    /// cell类回调
    public var cellClassHandler:((IndexPath) -> UITableViewCell.Type)?
    
    /// 配置cell回调
    public var configCellHandler:((UITableViewCell, IndexPath) -> Void)?
    
    /// cell高度回调
    public var cellHeightHandler:((IndexPath) -> CGFloat)?
    
    /// 点击cell回调
    public var didSelectHandler:((IndexPath) -> Void)?
}
