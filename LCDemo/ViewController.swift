//
//  ViewController.swift
//  LCSKitDemo
//
//  Created by menglingchao on 2020/9/14.
//  Copyright © 2020 MengLingChao. All rights reserved.
//

import UIKit
import SnapKit

public class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private enum Title: String {
        case viewGesture = "UIView、UIControl的手势事件"
        case stringExtension = "String extension"
        case combineViews = "批量连接视图"
        case useConstraintPurely = "直接调用系统方法操作约束"
        case deviceUtility = "工具类MLCDeviceUtility"
        case openUtility = "工具类MLCOpenUtility"
        case photos = "相册/相机相关"
        case seeLocalFile = "查看本地沙盒文件"
        case useProxy = "使用LCSProxy去除循环引用"
        case useArchiver = "归档、反归档"
        case json = "json使用"
        case annularView = "AnnularView使用"
        case fanShaped = "FanShapedView使用"
        case inheritBaseTableListViewController = "继承LCSBaseTableListViewController"
        case inheritBaseTableListView = "继承LCSBaseTableListView"
        case useProgressHUD = "使用LCSProgressHUD"
    }
    private let titles: [Title] = [.viewGesture, .stringExtension, .combineViews, .useConstraintPurely, .deviceUtility, .openUtility, .photos, .seeLocalFile, .useProxy, .useArchiver, .json, .annularView, .fanShaped, .inheritBaseTableListViewController, .inheritBaseTableListView, .useProgressHUD]
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "首页列表"
        
        addTableView()
    }
    // MARK: -
    private func addTableView() {
        let tableView = UITableView()
        tableView.estimatedRowHeight = 44
        tableView.lcs_register(cellClass: UITableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    // MARK: - UITableViewDelegate
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let title = titles[indexPath.row] as Title? else {
            return
        }
        let vc: UIViewController
        
        switch title {
        case .viewGesture:
            vc = LCViewGestureViewController()
        case .stringExtension:
            vc = LCStringExtensionViewController()
        case .combineViews:
            vc = LCCombineViewsViewController()
        case .useConstraintPurely:
            vc = LCUseConstraintPurelyViewController()
        case .deviceUtility:
            vc = LCDeviceUtilityViewController()
        case .openUtility:
            vc = LCOpenUtilityViewController()
        case .photos:
            vc = LCPhotosViewController()
        case .seeLocalFile:
            vc = LCSeeLocalFileViewController()
        case .useProxy:
            vc = UIViewController()
        case .useArchiver:
            vc = UIViewController()
        case .json:
            vc = LCJsonViewController()
        case .annularView:
            vc = LCUseAnnularViewController()
        case .fanShaped:
            vc = LCUseFanShapedViewController()
        case .inheritBaseTableListViewController:
            vc = LCSDemoTableListViewController()
        case .inheritBaseTableListView:
            vc = LCSUseBaseTableListViewController()
        case .useProgressHUD:
            vc = LCUseProgressHUDViewController()
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    // MARK: - UITableViewDataSource
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        titles.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let title = titles[indexPath.row].rawValue as String?, let cell = tableView.lcs_dequeueReusableCell(withCellClass: UITableViewCell.self) else {
            return UITableViewCell()
        }
        cell.textLabel?.text = title
        return cell
    }
}

