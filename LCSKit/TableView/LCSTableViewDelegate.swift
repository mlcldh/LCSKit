//
//  LCSTableViewDelegate.swift
//  LCSKit
//
//  Created by menglingchao on 2021/3/22.
//  Copyright © 2021 MengLingChao. All rights reserved.
//

import UIKit

/// UITableView代理实现
public class LCSTableViewDelegate: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    public let tableView: UITableView
    public var sections: [LCSTableViewSection] = []
    /// 空白页回调
    public var emptyViewHandler:(() -> UIView)?
    /// 错误页回调
    public var errorViewHandler:((NSError) -> UIView)?
    /// 是否在数据为空时显示空白页，默认是false，即不显示
    public var canShowEmptyView = false
    /// 网络请求错误
    public var error: NSError?
    
    deinit {
        print("menglc LCSTableViewDelegate deinit")
    }
    public init(tableView aTableView: UITableView, cellClasses: [UITableViewCell.Type]) {
        tableView = aTableView
        tableView.lcs_register(cellClasses: cellClasses)
        
        super.init()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    // MARK: - UITableViewDelegate
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard indexPath.section < sections.count else {
            return 0
        }
        let section = sections[indexPath.section]
        guard let cellHeightHandler = section.cellHeightHandler else {
            return 0
        }
        return cellHeightHandler(indexPath)
    }
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if error != nil {
            return tableView.frame.height
        }
        if sections.isEmpty, canShowEmptyView {
            return tableView.frame.height
        }
        guard section < sections.count else {
            return 0
        }
        let aSection = sections[section]
        if let headerHeightHandler = aSection.headerHeightHandler {
            return headerHeightHandler(section)
        }
        return 0
    }
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        guard section < sections.count else {
            return 0
        }
        let aSection = sections[section]
        if let footerHeightHandler = aSection.footerHeightHandler {
            return footerHeightHandler(section)
        }
        return 0
    }
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let aError = error, let aErrorViewHandler = errorViewHandler {
            return aErrorViewHandler(aError)
        }
        if sections.isEmpty, canShowEmptyView, let aEmptyViewHandler = emptyViewHandler {
            return aEmptyViewHandler()
        }
        guard section < sections.count else {
            return nil
        }
        let aSection = sections[section]
        if let headerViewHandler = aSection.headerViewHandler {
            let headerView = headerViewHandler(section)
            return headerView
        }
        return nil
    }
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard section < sections.count else {
            return nil
        }
        let aSection = sections[section]
        if let footerViewHandler = aSection.footerViewHandler {
            let footerView = footerViewHandler(section)
            return footerView
        }
        return nil
    }
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard indexPath.section < self.sections.count else {
            return
        }
        let section = sections[indexPath.section]
        if let didSelectHandler = section.didSelectHandler {
            didSelectHandler(indexPath)
        }
    }
    // MARK: - UITableViewDataSource
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard section < sections.count else {
            return 0
        }
        let aSection = sections[section]
        return aSection.models.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard indexPath.section < sections.count else {
            return UITableViewCell()
        }
        let section = sections[indexPath.section]
        var cellClass: UITableViewCell.Type
        if let cellClassHandler = section.cellClassHandler {
            cellClass = cellClassHandler(indexPath)
        } else {
            cellClass = UITableViewCell.self
        }
        guard let cell = tableView.lcs_dequeueReusableCell(withCellClass: cellClass) else {
            return UITableViewCell()
        }
        if indexPath.row < section.models.count, let configCellHandler = section.configCellHandler {
            configCellHandler(cell, section.models[indexPath.row], indexPath)
        }
        return cell
    }
    public func numberOfSections(in tableView: UITableView) -> Int {
        sections.isEmpty ? 1 : sections.count
    }
}
