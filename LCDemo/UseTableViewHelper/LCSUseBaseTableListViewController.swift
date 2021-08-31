//
//  LCSUseBaseTableListViewController.swift
//  LCDemo
//
//  Created by menglingchao on 2021/8/31.
//  Copyright © 2021 MengLingChao. All rights reserved.
//

import UIKit

class LCSUseBaseTableListViewController: LCBaseViewController {
    
    private let tableListView = LCDemoTableListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        addTableListView()
    }
    // MARK: -
    private func addTableListView() {
        view.addSubview(tableListView)
        tableListView.snp_makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tableListView.refresh(isShowLoading: true)
    }
}
