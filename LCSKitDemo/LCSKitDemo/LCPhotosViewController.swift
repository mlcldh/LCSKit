//
//  LCPhotosViewController.swift
//  LCSKitDemo
//
//  Created by menglingchao on 2020/9/15.
//  Copyright © 2020 MengLingChao. All rights reserved.
//

import UIKit
import LCSKit

class LCPhotosViewController: LCBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        addRequestAlbumPermissionButton()
        addRequestAlbumPermissionAndShowUIButton()
        addUseRequestCameraPermissionButton()
        addUseRequestCameraPermissionAndShowUIButton()
        addOpenSettingsButton()
        addPickButton()
    }
    // MARK: -
    private func addRequestAlbumPermissionButton() {
        let button = UIButton(type: .system)
        button.backgroundColor = .purple
        button.setTitleColor(.white, for: .normal)
        button.setTitle("请求相册权限", for: .normal)
        button.lcs_addActionForControlEvents(controlEvents: .touchUpInside) { sender in
            LCSPhotoPermissionManager.requestPermissionWithSourceType(souceType: .photoLibrary) { (isSourceTypeAvailable, success, isLimited, isNotDetermined) in
                if (!isSourceTypeAvailable) {
                    print("当前设备没有相册功能")
                    return
                }
                if (isNotDetermined) {
                    print("相册权限之前还未处理")
                }
                if (success) {
                    print("已经获得相册权限")
                    if (isLimited) {
                        print("读取相册受限")
                    }
                } else {
                    print("相册权限被拒绝")
                }
            }
        }
        view.addSubview(button)
        button.snp_makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(100)
        }
    }
    private func addRequestAlbumPermissionAndShowUIButton() {
        let button = UIButton(type: .system)
        button.backgroundColor = .purple
        button.setTitleColor(.white, for: .normal)
        button.setTitle("请求相册权限并且显示UI", for: .normal)
        button.lcs_addActionForControlEvents(controlEvents: .touchUpInside) { [unowned self] sender in
//            LCSPhotoPermissionManager.req
        }
        view.addSubview(button)
        button.snp_makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(150)
        }
    }
    private func addUseRequestCameraPermissionButton() {
        let button = UIButton(type: .system)
        button.backgroundColor = .purple
        button.setTitleColor(.white, for: .normal)
        button.setTitle("请求相机权限", for: .normal)
        button.lcs_addActionForControlEvents(controlEvents: .touchUpInside) { sender in
            LCSPhotoPermissionManager.requestPermissionWithSourceType(souceType: .camera) { (isSourceTypeAvailable, success, isLimited, isNotDetermined) in
                if (!isSourceTypeAvailable) {
                    print("当前设备没有相机功能")
                    return
                }
                if (isNotDetermined) {
                    print("相机权限之前还未处理")
                }
                if (success) {
                    print("已经获得相机权限")
                    if (isLimited) {
                        print("读取受限")
                    }
                } else {
                    print("相机权限被拒绝")
                }
            }
        }
        view.addSubview(button)
        button.snp_makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(200)
        }
    }
    private func addUseRequestCameraPermissionAndShowUIButton() {
        let button = UIButton(type: .system)
        button.backgroundColor = .purple
        button.setTitleColor(.white, for: .normal)
        button.setTitle("请求相机权限并且显示UI", for: .normal)
        button.lcs_addActionForControlEvents(controlEvents: .touchUpInside) { [unowned self] sender in
//            LCSPhotoPermissionManager.req
        }
        view.addSubview(button)
        button.snp_makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(250)
        }
    }
    private func addOpenSettingsButton() {
        let button = UIButton(type: .system)
        button.backgroundColor = .purple
        button.setTitleColor(.white, for: .normal)
        button.setTitle("跳转到app设置页面", for: .normal)
        button.lcs_addActionForControlEvents(controlEvents: .touchUpInside) { sender in
            LCSOpenUtility.openSettings()
        }
        view.addSubview(button)
        button.snp_makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(300)
        }
    }
    private func addPickButton() {
        let button = UIButton(type: .system)
        button.backgroundColor = .purple
        button.setTitleColor(.white, for: .normal)
        button.setTitle("选择照片", for: .normal)
        button.lcs_addActionForControlEvents(controlEvents: .touchUpInside) { [unowned self] sender in
            LCSImagePickerTool.pickSingleImage(inViewController: self) { image in
                print("menglc LCSImagePickerTool.pickSingleImage \(image)")
            }
        }
        view.addSubview(button)
        button.snp_makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(350)
        }
    }
    
}
