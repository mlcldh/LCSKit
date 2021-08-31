//
//  LCSDemoTableListViewController.swift
//  LCSKitDemo
//
//  Created by menglingchao on 2021/3/22.
//  Copyright © 2021 MengLingChao. All rights reserved.
//

import UIKit
import MJRefresh
import LCSKit

/// 讲解继承LCSBaseTableListViewController
class LCSDemoTableListViewController: LCSBaseTableListViewController {
    
    enum RefreshType {
        case empty
        case success
        case error
    }
    
    private let refreshSuccessButton = UIButton()
    private let refreshErrorButton = UIButton()
    private let refreshEmptyButton = UIButton()
    private var refreshType = RefreshType.empty
    
    deinit {
        print("menglc deinit \(self)")
    }
    init() {
        super.init(refreshHeaderClass: MJRefreshGifHeader.self, refreshFooterClass: MJRefreshAutoGifFooter.self, cellClasses: [LCATableViewCell.self])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .cyan
        
        title = "\(self.classForCoder)"
        
        tableView.snp_updateConstraints { make in
            make.top.equalToSuperview().offset(200)
        }
        
        addRefreshSuccessButton()
        addRefreshErrorButton()
        addRefreshEmptyButton()
        
        refresh(isShowLoading: true)
        
//        let cellClass: UITableViewCell.Type = LCATableViewCell.self
//        let cell = cellClass.init()
//        print("menglc cell = \(cell)")
    }
    // MARK: -
    func addRefreshSuccessButton() {
        refreshSuccessButton.backgroundColor = .purple
        refreshSuccessButton.setTitle("刷新成功", for: .normal)
        refreshSuccessButton.lcs_addActionForControlEvents(controlEvents: .touchUpInside) { [unowned self] _ in
            self.refreshType = .success
            self.refresh(isShowLoading: true)
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
        refreshErrorButton.lcs_addActionForControlEvents(controlEvents: .touchUpInside) { [unowned self] _ in
            self.refreshType = .error
            self.refresh(isShowLoading: true)
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
        refreshEmptyButton.lcs_addActionForControlEvents(controlEvents: .touchUpInside) { [unowned self] _ in
            self.refreshType = .empty
            self.refresh(isShowLoading: true)
        }
        view.addSubview(refreshEmptyButton)
        refreshEmptyButton.snp_makeConstraints { (make) in
            make.left.equalToSuperview().offset(220)
            make.top.equalToSuperview().offset(100)
        }
    }
    // MARK: -
    override func configHelper() {
        super.configHelper()
        helper.configSectionHandler = { [unowned self] section in
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
            section.titleForDeleteConfirmationButtonHandler = { indexPath, model in
                "删除"
            }
            section.editActionsHandler = { indexPath, model in
                var editActions:[UITableViewRowAction] = []
                
                let unreadAction = UITableViewRowAction(style: .default, title: "标位未读") { (tableViewRowAction, indexPath2) in
                    print("menglc 标位未读")
                }
                unreadAction.backgroundColor = .darkGray
                editActions.append(unreadAction)
                
                let notShowAction = UITableViewRowAction(style: .default, title: "不显示") { (tableViewRowAction, indexPath2) in
                    print("menglc 不显示")
                }
                notShowAction.backgroundColor = .systemOrange
                editActions.insert(notShowAction, at: 0)
                
                let deleteAction = UITableViewRowAction(style: .destructive, title: "删除") { (tableViewRowAction, indexPath2) in
                    self.totalCount -= 1
                    self.helper.deleteRow(at: indexPath.row, totalCount: self.totalCount)
                }
                editActions.insert(deleteAction, at: 0)
                
                return editActions
            }
            section.editingStyleHandler = { indexPath, model in
                .delete
            }
            section.commitEditingStyleHandler = { editingStyle, indexPath, model in
                self.totalCount -= 1
                self.helper.deleteRow(at: indexPath.row, totalCount: self.totalCount)
            }
        }
        helper.emptyViewHandler = {
            let label = UILabel()
            label.textAlignment = .center
            label.text = "空页面"
            return label
        }
        helper.errorViewHandler = { [unowned self] error in
            let errorButton = UIButton()
            errorButton.setTitleColor(.systemBlue, for: .normal)
            errorButton.setTitle(error.localizedFailureReason, for: .normal)
            errorButton.lcs_addActionForControlEvents(controlEvents: .touchUpInside) { sender in
                self.refresh(isShowLoading: true)
            }
//            errorButton.isEnabled = false
            return errorButton
        }
    }
    override func refresh(isShowLoading: Bool = false) {
        if isShowLoading {
            view.lcs_showLoadingHud()
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) { [unowned self] in
            self.view.lcs_removeHud()
            switch self.refreshType {
            case .empty:
                self.helper.handleRefreshSuccess(models: [], totalCount: 0)
            case .success:
                self.refreshSuccess()
            case .error:
                self.refreshError()
            }
        }
    }
    func refreshSuccess() {
        
        var models: [Any] = []
        
        for _ in 0..<10 {
            let model = LCLearnRecordModel()
            model.title = "文字\(models.count)"
            models.append(model)
        }
        
        totalCount = 12
        
        helper.handleRefreshSuccess(models: models, totalCount: totalCount)
    }
    func refreshError() {
        helper.handleLoadError(NSError(domain: "com.mlc.networkError", code: -1, userInfo: [NSLocalizedFailureReasonErrorKey: "网络错误，请稍后重试."]), isRefresh: true)
    }
    override func loadMore() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) { [unowned self] in
            var models: [Any] = []
            
            let count = min(10, self.totalCount - self.helper.models.count)
            
            for _ in 0..<count {
                let model = LCLearnRecordModel()
                model.title = "文字\(models.count)"
                models.append(model)
            }
            self.helper.handleLoadMoreSuccess(models: models, totalCount: self.totalCount)
        }
    }
    
}
