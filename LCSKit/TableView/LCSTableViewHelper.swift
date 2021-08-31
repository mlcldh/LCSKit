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
open class LCSTableViewHelper: NSObject {
    
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
    /// 加载更多回调
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
        print("menglc \(self) deinit")
    }
    public init(tableView aTableView: UITableView, cellClasses aCellClasses: [UITableViewCell.Type], refreshHeaderClass: MJRefreshHeader.Type, refreshFooterClass: MJRefreshFooter.Type) {
        tableViewDelegate =  LCSTableViewDelegate(tableView: aTableView, cellClasses: aCellClasses)
        
        super.init()
        
        aTableView.mj_header = refreshHeaderClass.init(refreshingBlock: { [unowned self] in
            guard let refreshHandler = self.refreshHandler else {
                return
            }
            refreshHandler()
        })
        
        aTableView.mj_footer = refreshFooterClass.init(refreshingBlock: { [unowned self] in
            guard let loadMoreHandler = self.loadMoreHandler else {
                return
            }
            loadMoreHandler()
        })
        aTableView.mj_footer?.isHidden = true
    }
    public func handleRequestSuccess(models: [Any]?, totalCount: Int, isRefresh: Bool) {
        if isRefresh {
            handleRefreshSuccess(models: models, totalCount: totalCount)
        } else {
            handleLoadMoreSuccess(models: models, totalCount: totalCount)
        }
    }
    public func handleRefreshSuccess(models: [Any]?, totalCount: Int) {
        guard totalCount > 0 else {
            handleEmpty()
            return
        }
        tableViewDelegate.canShowEmptyView = true
        tableViewDelegate.tableView.mj_header?.endRefreshing()
        tableViewDelegate.tableView.mj_footer?.isHidden = true
        
        tableViewDelegate.sections.removeAll()
        tableViewDelegate.error = nil
        
        let section = LCSTableViewSection()
        if let aConfigSectionHandler = configSectionHandler {
            aConfigSectionHandler(section)
        }
        if let aModels = models {
            section.models += aModels
        }
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
    public func handleLoadMoreSuccess(models: [Any]?, totalCount: Int) {
        tableViewDelegate.error = nil
        tableViewDelegate.canShowEmptyView = true
        
        if let section = tableViewDelegate.sections.first {
            if let aModels = models {
                section.models += aModels
            }
            if section.models.count >= totalCount {
                tableViewDelegate.tableView.mj_footer?.endRefreshingWithNoMoreData()
            } else {
                tableViewDelegate.tableView.mj_footer?.endRefreshing()
            }
        }
        
        tableViewDelegate.tableView.reloadData()
    }
    public func makeHeaderEndRefreshing() {
        tableViewDelegate.tableView.mj_header?.endRefreshing()
    }
    public func makeFooterEndRefreshing() {
        tableViewDelegate.tableView.mj_footer?.endRefreshing()
    }
    public func handleLoadError(_ error: NSError, isRefresh: Bool) {
        guard isRefresh else {
            makeFooterEndRefreshing()
            return
        }
        guard models.count == 0 else {
            makeHeaderEndRefreshing()
            return
        }
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
            tableViewDelegate.tableView.lcs_performBatchUpdates {
                self.tableViewDelegate.tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
                if self.models.count == 0 {
                    self.tableViewDelegate.canShowEmptyView = false
                    self.tableViewDelegate.tableView.mj_footer?.beginRefreshing()
                }
            }
        }
    }
    public func insertRow(model: Any ,at index: Int) {
//        tableViewDelegate.tableView.beginUpdates()
        tableViewDelegate.sections.first?.models.insert(model, at: index)
        tableViewDelegate.tableView.reloadData()
//        tableViewDelegate.tableView.insertRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
//        tableViewDelegate.tableView.endUpdates()
    }
    public func clearAllModels() {
        tableViewDelegate.canShowEmptyView = false
        tableViewDelegate.sections.removeAll()
        tableViewDelegate.tableView.reloadData()
    }
}
