//
//  LCSBaseTableListView.swift
//  LCSKit
//
//  Created by menglingchao on 2021/3/24.
//

import UIKit
import MJRefresh
import SnapKit

open class LCSBaseTableListView: UIView {
    
    public let tableView = UITableView()
    public let helper: LCSTableViewHelper
    
    public weak var viewController: UIViewController?
    public var totalCount = 0
    public var isLoading = false
    public var requestHandler:((Bool) -> Void)?
    
    deinit {
        print("menglc \(self) deinit")
    }
    public init(refreshHeaderClass: MJRefreshHeader.Type, refreshFooterClass: MJRefreshFooter.Type, cellClasses: [UITableViewCell.Type]) {
        helper = LCSTableViewHelper(tableView: tableView, cellClasses: cellClasses, refreshHeaderClass: refreshHeaderClass, refreshFooterClass: refreshFooterClass)
        super.init(frame: .zero)
        
        addTableView()
        configHelper()
    }
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: -
    private func addTableView() {
        tableView.backgroundColor = .white
//        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0
        tableView.estimatedRowHeight = 44
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        if #available(iOS 11, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        }
        if #available(iOS 15, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        tableView.tableFooterView = UIView()
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    open func configHelper() {
        helper.refreshHandler = { [unowned self] in
            self.refresh()
        }
        helper.loadMoreHandler = { [unowned self] in
            self.loadMore()
        }
//        helper.errorViewHandler = { [unowned self] error in
//            let emptyTipView = KKGEmptyTipView(frame: self.frame)
//            emptyTipView.errorCode(error, bounds: self.frame)
//            emptyTipView.tapBlock = { [unowned self] in
//                self.refresh(isShowLoading: true)
//            }
//            return emptyTipView
//        }
    }
    // MARK: -
    open func show() {
    }
    open func beginRefreshing() {
        tableView.mj_header?.beginRefreshing()
    }
    open func refresh(isShowLoading: Bool = false) {
        if isShowLoading {
            lcs_showLoadingHud()
        }
        request(isRefresh: true)
    }
    open func loadMore() {
        request(isRefresh: false)
    }
    open func request(isRefresh: Bool) {
        if let aRequestHandler = requestHandler {
            aRequestHandler(isRefresh)
        }
    }
    open func isScrolledToBottom()-> Bool {
        guard helper.models.count > 0 else {
            return true
        }
        guard let _ = tableView.cellForRow(at: IndexPath(row: helper.models.count - 1, section: 0)) else {
            return false
        }
        return true
    }
}
