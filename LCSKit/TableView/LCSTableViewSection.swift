//
//  LCSTableViewSection.swift
//  LCSKit
//
//  Created by menglingchao on 2021/3/22.
//  Copyright © 2021 MengLingChao. All rights reserved.
//

import UIKit

@available(iOS 2.0, *)
open class LCSTableViewSection: NSObject {
    
    /// model数组
    var models: [Any] = []
    /// section头部高度回调
    public var headerHeightHandler:((Int) -> CGFloat)?
    /// section头部视图回调
    public var headerViewHandler:((Int) -> UIView?)?
    /// section底部高度回调
    public var footerHeightHandler:((Int) -> CGFloat)?
    /// section底部视图回调
    public var footerViewHandler:((Int) -> UIView?)?
    
    /// cell类回调
    public var cellClassHandler:((IndexPath, Any) -> UITableViewCell.Type)?
    /// 配置cell回调
    public var configCellHandler:((UITableViewCell, IndexPath, Any) -> Void)?
    /// cell高度回调
    public var cellHeightHandler:((IndexPath, Any) -> CGFloat)?
    /// 点击cell回调
    public var didSelectHandler:((IndexPath, Any) -> Void)?
    /// 编辑样式回调
    public var editingStyleHandler:((IndexPath, Any) -> UITableViewCell.EditingStyle)?
    /// 删除样式标题回调
    public var titleForDeleteConfirmationButtonHandler:((IndexPath, Any) -> String?)?
    /// 自定义编辑样式回调
    public var editActionsHandler:((IndexPath, Any) -> [UITableViewRowAction]?)?
//    /// 自定义往右划编辑样式回调
//    @available(iOS 11.0, *)
//    public var leadingSwipeActionsConfigurationHandler:((IndexPath, Any) -> UISwipeActionsConfiguration?)?
    /// 提交编辑回调
    public var commitEditingStyleHandler:((UITableViewCell.EditingStyle, IndexPath, Any) -> Void)?
}
