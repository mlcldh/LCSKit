//
//  UIView+LCSKitUI.swift
//  LCSKit
//
//  Created by menglingchao on 2021/8/27.
//  Copyright © 2021 MengLingChao. All rights reserved.
//

import UIKit

extension UIView {
    
    /// 显示toast
    /// - Parameter title: 显示的文案
    public func lcs_showToastHud(title: String = "", hideAfterDelay delay: Double) {
        let hud = LCSProgressHUD(forView: self, type: .toast, annularWidth: 24)
        hud.bezelView.backgroundColor = .lcs_color(hexString: "000000", alpha: 0.7)
        hud.bezelView.layer.cornerRadius = 5
        hud.bezelViewMaxWidthRate = 0.7
        hud.titleLabel.textColor = .white
        hud.titleLabel.font = .systemFont(ofSize: 13)
        hud.titleLabel.numberOfLines = 0
        hud.titleLabel.text = title.count > 0 ? title : " "
        hud.titleLabelEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        hud.hideAfterDelay(delay)
    }
    /// 显示loading
    /// - Parameter title: 显示的文案
    public func lcs_showLoadingHud(title: String = "") {
        let hud = LCSProgressHUD(forView: self, type: .loading, annularWidth: 24)
        hud.rotateDuration = 0.8
//        hud.bezelView.backgroundColor = .lcs_color(hexString: "000000", alpha: 0.7)
//        hud.bezelView.layer.cornerRadius = 5
        hud.annularView.line.shapeLayer().strokeEnd = 0.1
//        hud.annularViewTopMargin = 12
        hud.titleLabel.textColor = .lcs_color(hexString: "C6C9CC")
        hud.titleLabel.font = .systemFont(ofSize: 14)
        hud.titleLabel.numberOfLines = 0
        hud.titleLabel.text = title.count > 0 ? title : "加载中..."
        hud.titleLabelEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
    }
    /// 移除所有LCSProgressHUD
    public func lcs_removeHud() {
        LCSProgressHUD.hideHUDForView(self)
    }
}
