//
//  LCSeeLocalFileViewController.swift
//  LCSKitDemo
//
//  Created by menglingchao on 2020/9/15.
//  Copyright © 2020 MengLingChao. All rights reserved.
//

import UIKit
import LCSKit

class LCSeeLocalFileViewController: LCBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
                
        seeLocalFile()
    }
    // MARK: -
    private func seeLocalFile() {
        let seeLocalFileButton = UIButton(type: .system)
        seeLocalFileButton.backgroundColor = .purple
        seeLocalFileButton.setTitleColor(.white, for: .normal)
        seeLocalFileButton.setTitle("查看本地沙盒文件", for: .normal)
        seeLocalFileButton.lcs_addActionForControlEvents(controlEvents: .touchUpInside) { [weak self] sender in
            let folderPath = NSHomeDirectory()
            let localFolderVC = LCSLocalFolderViewController(folderPath: folderPath)
            self?.navigationController?.pushViewController(localFolderVC, animated: true)
        }
        view.addSubview(seeLocalFileButton)
        seeLocalFileButton.snp_makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(100)
        }
    }
}
