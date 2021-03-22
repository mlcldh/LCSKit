//
//  LCUseTableViewHelperViewController.swift
//  LCSKitDemo
//
//  Created by menglingchao on 2021/3/22.
//  Copyright © 2021 MengLingChao. All rights reserved.
//

import UIKit
import MJRefresh
import LCSKit

class LCUseTableViewHelperViewController: LCBaseViewController {
    
    enum RefreshType {
        case empty
        case success
        case error
    }
    
    private let refreshSuccessButton = UIButton()
    private let refreshErrorButton = UIButton()
    private let refreshEmptyButton = UIButton()
    private let tableView = UITableView()
    private let helper: LCSTableViewHelper
    private var refreshType = RefreshType.empty
    private let totalCount = 40
    
    init() {
        helper = LCSTableViewHelper(tableView: tableView)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        addRefreshSuccessButton()
        addRefreshErrorButton()
        addRefreshEmptyButton()
        
        addTableView()
        
        configHelper()
        
        tableView.mj_header?.beginRefreshing()
    }
    // MARK: -
    func addRefreshSuccessButton() {
        refreshSuccessButton.backgroundColor = .purple
        refreshSuccessButton.setTitle("刷新成功", for: .normal)
        refreshSuccessButton.lcs_addActionForControlEvents(controlEvents: .touchUpInside) { [weak self] _ in
            guard let weakSelf = self else {
                return
            }
            weakSelf.refreshType = .success
            weakSelf.tableView.mj_header?.beginRefreshing()
        }
        view.addSubview(refreshSuccessButton)
        refreshSuccessButton.snp_makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(100)
        }
    }
    func addRefreshErrorButton() {
        refreshErrorButton.backgroundColor = .purple
        refreshErrorButton.setTitle("刷新失败", for: .normal)
        refreshErrorButton.lcs_addActionForControlEvents(controlEvents: .touchUpInside) { [weak self] _ in
            guard let weakSelf = self else {
                return
            }
            weakSelf.refreshType = .error
            weakSelf.tableView.mj_header?.beginRefreshing()
        }
        view.addSubview(refreshErrorButton)
        refreshErrorButton.snp_makeConstraints { (make) in
            make.left.equalToSuperview().offset(120)
            make.top.equalToSuperview().offset(100)
        }
    }
    func addRefreshEmptyButton() {
        refreshEmptyButton.backgroundColor = .purple
        refreshEmptyButton.setTitle("空列表", for: .normal)
        refreshEmptyButton.lcs_addActionForControlEvents(controlEvents: .touchUpInside) { [weak self] _ in
            guard let weakSelf = self else {
                return
            }
            weakSelf.refreshType = .empty
            weakSelf.tableView.mj_header?.beginRefreshing()
        }
        view.addSubview(refreshEmptyButton)
        refreshEmptyButton.snp_makeConstraints { (make) in
            make.left.equalToSuperview().offset(220)
            make.top.equalToSuperview().offset(100)
        }
    }
    func addTableView() {
        tableView.backgroundColor = .lightGray
        tableView.mj_header = MJRefreshGifHeader(refreshingBlock: { [weak self] in
            guard let weakSelf = self else {
                return
            }
            weakSelf.refresh()
        })
        tableView.mj_footer = MJRefreshAutoGifFooter(refreshingBlock: { [weak self] in
            guard let weakSelf = self else {
                return
            }
            weakSelf.loadMore()
        })
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(150)
        }
    }
    // MARK: -
    func configHelper() {
        helper.emptyViewHandler = {
            let label = UILabel()
            label.textAlignment = .center
            label.text = "空页面"
            return label
        }
        helper.errorViewHandler = { error in
            let errorButton = UIButton()
            errorButton.setTitle("错误页面", for: .normal)
            errorButton.lcs_addActionForControlEvents(controlEvents: .touchUpInside) { [weak self] sender in
                guard let weakSelf = self else {
                    return
                }
                weakSelf.tableView.mj_header?.beginRefreshing()
            }
            return errorButton
        }
    }
    func refresh() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) { [weak self] in
            guard let weakSelf = self else {
                return
            }
            switch weakSelf.refreshType {
            case .empty:
                weakSelf.refreshEmpty()
            case .success:
                weakSelf.refreshSuccess()
            case .error:
                weakSelf.refreshError()
            }
        }
    }
    func refreshEmpty() {
        tableView.mj_header?.endRefreshing()
        tableView.mj_footer?.isHidden = true
        
        helper.canShowEmptyView = true
        helper.sections.removeAll()
        helper.error = nil
        tableView.reloadData()
    }
    func refreshSuccess() {
        tableView.mj_header?.endRefreshing()
        tableView.mj_footer?.isHidden = true
        
        helper.sections.removeAll()
        helper.error = nil
        
        let section = LCSTableViewSection()
        for index in 0..<20 {
            let row = LCSTableViewRow()
            row.cellClassHandler = { indexPath in
                LCATableViewCell.self
            }
            row.configCellHandler = { cell, indexPath in
                cell.textLabel?.text = "文字\(index)"
            }
            row.cellHeightHandler = { indexPath in
                80
            }
            row.didSelectHandler = { indexPath in
                print("menglc row DidSelect \(indexPath.section) \(indexPath.row)")
            }
            section.rows.append(row)
        }
        if section.rows.count >= totalCount {
            tableView.mj_footer?.endRefreshingWithNoMoreData()
        } else {
            tableView.mj_footer?.endRefreshing()
        }
        tableView.mj_footer?.isHidden = false
        helper.sections.append(section)
        tableView.reloadData()
    }
    func refreshError() {
        tableView.mj_header?.endRefreshing()
        tableView.mj_footer?.isHidden = true
        
        helper.sections.removeAll()
        helper.error = NSError(domain: "com.mlc.networkError", code: -1, userInfo: [NSLocalizedFailureReasonErrorKey: "网络错误，请稍后重试."])
        tableView.reloadData()
    }
    func loadMore() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) { [weak self] in
            guard let weakSelf = self else {
                return
            }
            weakSelf.helper.error = nil
            
            let section = weakSelf.helper.sections[0]
            for _ in 20..<40 {
                let row = LCSTableViewRow()
                row.cellClassHandler = { indexPath in
                    LCATableViewCell.self
                }
                let rowIndex = section.rows.count
                row.configCellHandler = { cell, indexPath in
                    cell.textLabel?.text = "文字\(rowIndex)"
                }
                row.cellHeightHandler = { indexPath in
                    50
                }
                row.didSelectHandler = { indexPath in
                    print("menglc row DidSelect \(indexPath.section) \(indexPath.row)")
                }
                section.rows.append(row)
            }
            if section.rows.count >= weakSelf.totalCount {
                weakSelf.tableView.mj_footer?.endRefreshingWithNoMoreData()
            } else {
                weakSelf.tableView.mj_footer?.endRefreshing()
            }
            weakSelf.helper.sections.append(section)
            weakSelf.tableView.reloadData()
        }
    }
}
