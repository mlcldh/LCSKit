//
//  LCViewGestureViewController.swift
//  LCSKitDemo
//
//  Created by menglingchao on 2020/9/14.
//  Copyright © 2020 MengLingChao. All rights reserved.
//

import UIKit
import LCSKit

class LCViewGestureViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .white
        
        useLabelGesture()
        useButtonAddAction()
        useSwitchAddAction()
    }
    // MARK: -
    private func useLabelGesture() {
        let label = UILabel()
        label.backgroundColor = .purple
        label.textColor = .white
        label.textAlignment = .center
        label.text = "轻学堂"
        let _ = label.lcs_addGestureRecognizer(type: .tap) { gestureRecognizer in
            guard let aLabel = gestureRecognizer.view as? UILabel else {
                return
            }
            print("menglc tap \(aLabel.text ?? "nil")")
        }
        let _ = label.lcs_addGestureRecognizer(type: .tap) { gestureRecognizer in
            guard let aLabel = gestureRecognizer.view as? UILabel else {
                return
            }
            print("menglc tap2 \(aLabel.text ?? "nil")")
        }
        let _ = label.lcs_addGestureRecognizer(type: .tap) { gestureRecognizer in
            guard let aLabel = gestureRecognizer.view as? UILabel else {
                return
            }
            print("menglc tap3 \(aLabel.text ?? "nil")")
        }
        let _ = label.lcs_addGestureRecognizer(type: .longPress) { gestureRecognizer in
            guard let longPressGestureRecognizer = gestureRecognizer as? UILongPressGestureRecognizer, longPressGestureRecognizer.state == .began, let aLabel = gestureRecognizer.view as? UILabel else {
                return
            }
            print("menglc longPress \(aLabel.text ?? "nil")")
        }
        let _ = label.lcs_addGestureRecognizer(type: .pan) { gestureRecognizer in
            print("menglc pan")
        }
        let _ = label.lcs_addGestureRecognizer(type: .swipe) { gestureRecognizer in
            print("menglc swipe")
        }
        view.addSubview(label)
        label.snp_makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(100)
            make.size.equalTo(CGSize(width: 80, height: 40))
        }
    }
    private func useButtonAddAction() {
        let button = UIButton(type: .system)
        button.backgroundColor = .purple
        button.setTitle("button", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.lcs_addActionForControlEvents(controlEvents: .touchUpInside) { sender in
            print("menglc button UIControlEventTouchUpInside")
        }
        button.lcs_addActionForControlEvents(controlEvents: .touchUpInside) { sender in
            print("menglc button UIControlEventTouchUpInside2")
        }
//        button.lcs_removeAllActions(forControlEvents: .touchUpInside)
//        button.lcs_removeAllActions()
        button.lcs_addActionForControlEvents(controlEvents: .touchUpInside) { sender in
            print("menglc button UIControlEventTouchUpInside3")
        }
        view.addSubview(button)
        button.snp_makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(150)
        }
    }
    private func useSwitchAddAction() {
        let aSwitch = UISwitch()
        aSwitch.lcs_addActionForControlEvents(controlEvents: .valueChanged) { sender in
            guard let switch2 = sender as? UISwitch else {
                return
            }
            print("menglc aSwitch.isOn \(switch2.isOn)")
        }
        view.addSubview(aSwitch)
        aSwitch.snp_makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(200)
        }
    }
}
