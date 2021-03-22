//
//  LCSTableViewHelper.swift
//  LCSKit
//
//  Created by menglingchao on 2021/3/22.
//  Copyright © 2021 MengLingChao. All rights reserved.
//

import UIKit


/// UITableView代理助手
public class LCSTableViewHelper: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    public let tableView: UITableView
    public var sections: [LCSTableViewSection] = []
    /// 空白页回调
    public var emptyViewHandler:(() -> UIView)?
    /// 错误页回调
    public var errorViewHandler:((Error) -> UIView)?
    /// 是否在数据为空时显示空白页，默认是false，即不显示
    public var canShowEmptyView = false
    /// 网络请求错误
    public var error: Error?
    
    deinit {
        print("menglc LCSTableViewHelper deinit")
    }
    public init(tableView aTableView: UITableView) {
        tableView = aTableView
        
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
        guard indexPath.row < section.rows.count else {
            return 0
        }
        let row = section.rows[indexPath.row]
        guard let cellHeightHandler = row.cellHeightHandler else {
            return 0
        }
        let cellHeight = cellHeightHandler(indexPath)
        return cellHeight
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
        if indexPath.row < section.rows.count {
            return
        }
        let row = section.rows[indexPath.row]
        if let didSelectHandler = row.didSelectHandler {
            didSelectHandler(indexPath)
        }
    }
    // MARK: - UITableViewDataSource
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard section < sections.count else {
            return 0
        }
        let aSection = sections[section]
        return aSection.rows.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard indexPath.section < sections.count else {
            return UITableViewCell()
        }
        let section = sections[indexPath.section]
        guard indexPath.row < section.rows.count else {
            return UITableViewCell()
        }
        let row = section.rows[indexPath.row]
        guard let cellClassHandler = row.cellClassHandler else {
            return UITableViewCell()
        }
        let cellClass = cellClassHandler(indexPath)
        let reuseIdentifier = NSStringFromClass(cellClass)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) else {
            let cell = cellClass.init()
            if let configCellHandler = row.configCellHandler {
                configCellHandler(cell, indexPath)
            }
            
            return cell
        }
        if let configCellHandler = row.configCellHandler {
            configCellHandler(cell, indexPath)
        }
        
        return cell
    }
    public func numberOfSections(in tableView: UITableView) -> Int {
        sections.isEmpty ? 1 : sections.count
    }
}
