//
//  LCSTableViewHelper.swift
//  LCSKit
//
//  Created by menglingchao on 2021/3/23.
//  Copyright © 2021 ximalaya. All rights reserved.
//

import UIKit
import MJRefresh

/// TableView助手
public class LCSTableViewHelper: NSObject {
    
    private let tableViewDelegate: LCSTableViewDelegate
    /// model数组
    public var models: [Any] {
        guard let section = tableViewDelegate.sections.first else {
            return []
        }
        return section.models
    }
    /// 下拉刷新回调
    public var refreshHandler:(() -> Void)?
    /// 下载更多回调
    public var loadMoreHandler:(() -> Void)?
    /// 配置Section回调
    public var configSectionHandler:((LCSTableViewSection) -> Void)?
    /// 空白页回调
    public var emptyViewHandler:(() -> UIView)? {
        get {
            tableViewDelegate.emptyViewHandler
        }
        set {
            tableViewDelegate.emptyViewHandler = newValue
        }
    }
    /// 错误页回调
    public var errorViewHandler:((NSError) -> UIView)? {
        get {
            tableViewDelegate.errorViewHandler
        }
        set {
            tableViewDelegate.errorViewHandler = newValue
        }
    }
    
    deinit {
        print("menglc LCSTableViewHelper deinit")
    }
    public init(tableView aTableView: UITableView, cellClasses aCellClasses: [UITableViewCell.Type], refreshHeaderClass: MJRefreshHeader.Type, refreshFooterClass: MJRefreshFooter.Type) {
        tableViewDelegate =  LCSTableViewDelegate(tableView: aTableView, cellClasses: aCellClasses)
        
        super.init()
        
        let header = refreshHeaderClass.init(refreshingBlock: { [weak self] in
            guard let weakSelf = self, let refreshHandler = weakSelf.refreshHandler else {
                return
            }
            refreshHandler()
        })
        aTableView.mj_header = header
        
        aTableView.mj_footer = refreshFooterClass.init(refreshingBlock: { [weak self] in
            guard let weakSelf = self, let loadMoreHandler = weakSelf.loadMoreHandler else {
                return
            }
            loadMoreHandler()
        })
        aTableView.mj_footer?.isHidden = true
    }
    
    public func handleRefreshSuccess(models: [Any], totalCount: Int) {
        guard totalCount > 0 else {
            handleEmpty()
            return
        }
        tableViewDelegate.tableView.mj_header?.endRefreshing()
        tableViewDelegate.tableView.mj_footer?.isHidden = true
        
        tableViewDelegate.sections.removeAll()
        tableViewDelegate.error = nil
        
        let section = LCSTableViewSection()
        if let aConfigSectionHandler = configSectionHandler {
            aConfigSectionHandler(section)
        }
        section.models += models
        if section.models.count >= totalCount {
            tableViewDelegate.tableView.mj_footer?.endRefreshingWithNoMoreData()
        } else {
            tableViewDelegate.tableView.mj_footer?.endRefreshing()
        }
        tableViewDelegate.tableView.mj_footer?.isHidden = false
        tableViewDelegate.sections.append(section)
        tableViewDelegate.tableView.reloadData()
    }
    public func handleEmpty() {
        tableViewDelegate.tableView.mj_header?.endRefreshing()
        tableViewDelegate.tableView.mj_footer?.isHidden = true
        
        tableViewDelegate.canShowEmptyView = true
        tableViewDelegate.sections.removeAll()
        tableViewDelegate.error = nil
        tableViewDelegate.tableView.reloadData()
    }
    public func handleLoadMoreSuccess(models: [Any], totalCount: Int) {
        tableViewDelegate.error = nil
        
        let section = tableViewDelegate.sections[0]
        section.models += models
        if section.models.count >= totalCount {
            tableViewDelegate.tableView.mj_footer?.endRefreshingWithNoMoreData()
        } else {
            tableViewDelegate.tableView.mj_footer?.endRefreshing()
        }
        tableViewDelegate.tableView.reloadData()
    }
    public func handleLoadError(_ error: NSError) {
        tableViewDelegate.tableView.mj_header?.endRefreshing()
        tableViewDelegate.tableView.mj_footer?.isHidden = true
        
        tableViewDelegate.sections.removeAll()
        tableViewDelegate.error = error
        tableViewDelegate.tableView.reloadData()
    }
    public func removeModel(at index:Int) {
        tableViewDelegate.sections.first?.models.remove(at: index)
    }
    public func deleteRow(at index: Int, totalCount: Int) {
        removeModel(at: index)
        if totalCount <= 0 {
            tableViewDelegate.tableView.reloadData()
        } else {
            tableViewDelegate.tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        }
    }
}
