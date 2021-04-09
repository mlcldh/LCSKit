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
        print("menglc \(self) deinit")
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
            return tableView.rowHeight
        }
        let section = sections[indexPath.section]
        guard let cellHeightHandler = section.cellHeightHandler, indexPath.row < section.models.count else {
            return tableView.rowHeight
        }
        let model = section.models[indexPath.row]
        return cellHeightHandler(indexPath, model)
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
        if aSection.models.isEmpty, canShowEmptyView {
            return tableView.frame.height
        }
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
        if aSection.models.isEmpty, canShowEmptyView, let aEmptyViewHandler = emptyViewHandler {
            return aEmptyViewHandler()
        }
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
        guard let didSelectHandler = section.didSelectHandler, indexPath.row < section.models.count else {
            return
        }
        let model = section.models[indexPath.row]
        didSelectHandler(indexPath, model)
    }
    public func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        guard indexPath.section < sections.count else {
            return .none
        }
        let section = sections[indexPath.section]
        guard let editingStyleHandler = section.editingStyleHandler, indexPath.row < section.models.count else {
            return .none
        }
        let model = section.models[indexPath.row]
        return editingStyleHandler(indexPath, model)
    }
    public func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        guard indexPath.section < sections.count else {
            return nil
        }
        let section = sections[indexPath.section]
        guard let titleForDeleteConfirmationButtonHandler = section.titleForDeleteConfirmationButtonHandler, indexPath.row < section.models.count else {
            return nil
        }
        let model = section.models[indexPath.row]
        return titleForDeleteConfirmationButtonHandler(indexPath, model)
    }
    public func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        guard indexPath.section < sections.count else {
            return nil
        }
        let section = sections[indexPath.section]
        guard let editActionsHandler = section.editActionsHandler, indexPath.row < section.models.count else {
            return nil
        }
        let model = section.models[indexPath.row]
        return editActionsHandler(indexPath, model)
    }
//    @available(iOS 11.0, *)
//    public func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        guard indexPath.section < sections.count else {
//            return nil
//        }
//        let section = sections[indexPath.section]
//        guard let leadingSwipeActionsConfigurationHandler = section.leadingSwipeActionsConfigurationHandler, indexPath.row < section.models.count else {
//            return nil
//        }
//        return nil
//        let model = section.models[indexPath.row]
//        return leadingSwipeActionsConfigurationHandler(indexPath, model)
//    }
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
        guard indexPath.row < section.models.count else {
            return UITableViewCell()
        }
        let model = section.models[indexPath.row]
        
        var cellClass: UITableViewCell.Type
        if let cellClassHandler = section.cellClassHandler {
            cellClass = cellClassHandler(indexPath, model)
        } else {
            cellClass = UITableViewCell.self
        }
        guard let cell = tableView.lcs_dequeueReusableCell(withCellClass: cellClass) else {
            return UITableViewCell()
        }
        if let configCellHandler = section.configCellHandler {
            configCellHandler(cell, indexPath, model)
        }
        return cell
    }
    public func numberOfSections(in tableView: UITableView) -> Int {
        sections.isEmpty ? 1 : sections.count
    }
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard indexPath.section < sections.count else {
            return
        }
        let section = sections[indexPath.section]
        guard let commitEditingStyleHandler = section.commitEditingStyleHandler, indexPath.row < section.models.count else {
            return
        }
        let model = section.models[indexPath.row]
        commitEditingStyleHandler(editingStyle, indexPath, model)
    }
}
