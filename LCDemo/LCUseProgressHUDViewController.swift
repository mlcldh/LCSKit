//
//  LCUseProgressHUDViewController.swift
//  LCSKitDemo
//
//  Created by menglingchao on 2021/8/27.
//  Copyright © 2021 MengLingChao. All rights reserved.
//

import UIKit
import LCSKit

class LCUseProgressHUDViewController: LCBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        addUseToastHudButton()
        addUseLoadingHudButton()
        addUseCustomHudButton()
    }
    // MARK: -
    private func addUseToastHudButton() {
        let button = UIButton(type: .system)
        button.backgroundColor = .purple
        button.setTitleColor(.white, for: .normal)
        button.setTitle("使用Toast", for: .normal)
        button.lcs_addActionForControlEvents(controlEvents: .touchUpInside) { [unowned self] sender in
//            self.view.lcs_showToastHud(title: "操作成功", hideAfterDelay: 2)
            self.view.lcs_showToastHud(title: "这个文案很长。这个文案很长。这个文案很长。这个文案很长。这个文案很长。这个文案很长。这个文案很长。这个文案很长。这个文案很长。这个文案很长。这个文案很长。", hideAfterDelay: 2)
        }
        view.addSubview(button)
        button.snp_makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(100)
//            make.width.height.equalTo(200)
        }
    }
    private func addUseLoadingHudButton() {
        let button = UIButton(type: .system)
        button.backgroundColor = .purple
        button.setTitleColor(.white, for: .normal)
        button.setTitle("使用loadingHud", for: .normal)
        button.lcs_addActionForControlEvents(controlEvents: .touchUpInside) { [unowned self] sender in
            self.view.lcs_showLoadingHud()
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) { [weak self] in
                guard let weakSelf = self else {
                    return
                }
                weakSelf.view.lcs_removeHud()
            }
        }
        view.addSubview(button)
        button.snp_makeConstraints { (make) in
            make.left.equalToSuperview().offset(150)
            make.top.equalToSuperview().offset(100)
        }
    }
    private func addUseCustomHudButton() {
        let button = UIButton(type: .system)
        button.backgroundColor = .purple
        button.setTitleColor(.white, for: .normal)
        button.setTitle("使用自定义Hud", for: .normal)
        button.lcs_addActionForControlEvents(controlEvents: .touchUpInside) { [unowned self] sender in
            let hud = LCSProgressHUD(forView: self.view, type: .custom)
            hud.bezelView.backgroundColor = .lcs_color(hexString: "000000", alpha: 0.7)
            hud.bezelView.layer.cornerRadius = 5
            
            let titleLabel = UILabel()
            titleLabel.textColor = .white
            titleLabel.font = .systemFont(ofSize: 13)
            titleLabel.text = "自定义"
            
            hud.customView = titleLabel
            hud.customViewEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
            hud.hideAfterDelay(2)
        }
        view.addSubview(button)
        button.snp_makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(150)
        }
    }
}
