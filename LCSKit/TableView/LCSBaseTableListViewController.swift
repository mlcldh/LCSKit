//
//  LCSBaseTableListViewController.swift
//  LCSKit
//
//  Created by menglingchao on 2020/3/12.
//  Copyright © 2020 ximalaya. All rights reserved.
//

import UIKit
import MJRefresh

/**tableView列表虚拟基类视图控制器*/
open class LCSBaseTableListViewController: UIViewController {
    
    public let tableView = UITableView(frame: .zero, style: tableViewStyle())
    public let helper: LCSTableViewHelper
    public var totalCount: Int = 0
    
    public init(refreshHeaderClass: MJRefreshHeader.Type, refreshFooterClass: MJRefreshFooter.Type, cellClasses: [UITableViewCell.Type]) {
        helper = LCSTableViewHelper(tableView: tableView, cellClasses: cellClasses, refreshHeaderClass: refreshHeaderClass, refreshFooterClass: refreshFooterClass)
        super.init(nibName: nil, bundle: nil)
    }
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        addTableView()
        configHelper()
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
        tableView.tableFooterView = UIView()
        if #available(iOS 11, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        }
        view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
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
//            let emptyTipView = KKGEmptyTipView(frame: self.view.frame)
//            emptyTipView.errorCode(error, bounds: self.view.frame)
//            emptyTipView.tapBlock = { [unowned self] in
//                self.refresh(isShowLoading: true)
//            }
//            return emptyTipView
//        }
    }
    // MARK: -
    open class func tableViewStyle() -> UITableView.Style {
        .plain
    }
    open func beginRefreshing() {
        tableView.mj_header?.beginRefreshing()
    }
    open func refresh(isShowLoading: Bool = false) {
        if isShowLoading {
            view.lcs_showLoadingHud()
        }
        request(isRefresh: true)
    }
    open func loadMore() {
        request(isRefresh: false)
    }
    open func request(isRefresh: Bool) {
    }
}
