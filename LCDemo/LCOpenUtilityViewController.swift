//
//  LCOpenUtilityViewController.swift
//  LCSKitDemo
//
//  Created by menglingchao on 2021/6/1.
//  Copyright © 2021 MengLingChao. All rights reserved.
//

import UIKit
import LCSKit

class LCOpenUtilityViewController: LCBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        addCallButton()
        addSendShortMessagingButton()
        addSendEmailButton()
        addOpenSettingsButton()
    }
    // MARK: -
    func addCallButton() {
        let button = UIButton(type: .system)
        button.backgroundColor = .purple
        button.setTitleColor(.white, for: .normal)
        button.setTitle("打电话", for: .normal)
        button.lcs_addActionForControlEvents(controlEvents: .touchUpInside) { sender in
            LCSOpenUtility.call(telephoneNumber: "13813813813")
        }
        view.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(100)
        }
    }
    func addSendShortMessagingButton() {
        let button = UIButton(type: .system)
        button.backgroundColor = .purple
        button.setTitleColor(.white, for: .normal)
        button.setTitle("发短信", for: .normal)
        button.lcs_addActionForControlEvents(controlEvents: .touchUpInside) { sender in
            guard let msg = "13813813813&body=短信内容".lcs_urlEncode() else {
                return
            }
            LCSOpenUtility.sendShortMessage(shortMessage: msg)
        }
        view.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(80)
            make.top.equalToSuperview().offset(100)
        }
    }
    func addSendEmailButton() {
        let button = UIButton(type: .system)
        button.backgroundColor = .purple
        button.setTitleColor(.white, for: .normal)
        button.setTitle("发邮件", for: .normal)
        button.lcs_addActionForControlEvents(controlEvents: .touchUpInside) { sender in
            LCSOpenUtility.sendEmail(email: "13813813813@qq.com")
        }
        view.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(140)
            make.top.equalToSuperview().offset(100)
        }
    }
    func addOpenSettingsButton() {
        let button = UIButton(type: .system)
        button.backgroundColor = .purple
        button.setTitleColor(.white, for: .normal)
        button.setTitle("跳转到app设置页面", for: .normal)
        button.lcs_addActionForControlEvents(controlEvents: .touchUpInside) { sender in
            LCSOpenUtility.openSettings()
        }
        view.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(200)
            make.top.equalToSuperview().offset(100)
        }
    }
}
