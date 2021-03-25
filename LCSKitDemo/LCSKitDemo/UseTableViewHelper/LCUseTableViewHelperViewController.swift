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
    private var totalCount = 40
    
    init() {
        helper = LCSTableViewHelper(tableView: tableView, cellClasses: [LCATableViewCell.self], refreshHeaderClass: MJRefreshGifHeader.self, refreshFooterClass: MJRefreshAutoGifFooter.self)
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
        
//        let cellClass: UITableViewCell.Type = LCATableViewCell.self
//        let cell = cellClass.init()
//        print("menglc cell = \(cell)")
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
        
        
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(150)
        }
    }
    // MARK: -
    func configHelper() {
        helper.refreshHandler = { [weak self] in
            guard let weakSelf = self else {
                return
            }
            weakSelf.refresh()
        }
        helper.loadMoreHandler = { [weak self] in
            guard let weakSelf = self else {
                return
            }
            weakSelf.loadMore()
        }
        helper.configSectionHandler = { [weak self] section in
            guard let weakSelf = self else {
                return
            }
            section.cellClassHandler = { indexPath, model in
                LCATableViewCell.self
            }
            section.configCellHandler = { cell, indexPath, model in
                if let learnRecordModel = model as? LCLearnRecordModel {
                    cell.textLabel?.text = learnRecordModel.title
                }
            }
            section.cellHeightHandler = { indexPath, model in
                80
            }
            section.didSelectHandler = { indexPath, model in
                print("menglc row DidSelect \(indexPath.section) \(indexPath.row)")
            }
            section.editingStyleHandler = { indexPath, model in
                .delete
            }
            section.commitEditingStyleHandler = { editingStyle, indexPath, model in
                weakSelf.totalCount -= 1
                weakSelf.helper.deleteRow(at: indexPath.row, totalCount: weakSelf.totalCount)
            }
        }
        helper.emptyViewHandler = {
            let label = UILabel()
            label.textAlignment = .center
            label.text = "空页面"
            return label
        }
        helper.errorViewHandler = { [weak self] error in
            let errorButton = UIButton()
            errorButton.setTitle(error.localizedFailureReason, for: .normal)
            errorButton.lcs_addActionForControlEvents(controlEvents: .touchUpInside) { sender in
                guard let weakSelf = self else {
                    return
                }
                weakSelf.tableView.mj_header?.beginRefreshing()
            }
//            errorButton.isEnabled = false
            return errorButton
        }
    }
    func refresh() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) { [weak self] in
            guard let weakSelf = self else {
                return
            }
            switch weakSelf.refreshType {
            case .empty:
                weakSelf.helper.handleRefreshSuccess(models: [], totalCount: 0)
            case .success:
                weakSelf.refreshSuccess()
            case .error:
                weakSelf.refreshError()
            }
        }
    }
    func refreshSuccess() {
        var models: [Any] = []
        
        for _ in 0..<20 {
            let model = LCLearnRecordModel()
            model.title = "文字\(models.count)"
            models.append(model)
        }
        helper.handleRefreshSuccess(models: models, totalCount: totalCount)
    }
    func refreshError() {
        helper.handleLoadError(NSError(domain: "com.mlc.networkError", code: -1, userInfo: [NSLocalizedFailureReasonErrorKey: "网络错误，请稍后重试."]))
    }
    func loadMore() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) { [weak self] in
            guard let weakSelf = self else {
                return
            }
            var models: [Any] = []
            
            for _ in 0..<20 {
                let model = LCLearnRecordModel()
                model.title = "文字\(weakSelf.helper.models.count + models.count)"
                models.append(model)
            }
            weakSelf.helper.handleLoadMoreSuccess(models: models, totalCount: weakSelf.totalCount)
        }
    }
    
}
