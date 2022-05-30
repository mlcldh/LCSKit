//
//  LCSProgressHUD.swift
//  LCSKit
//
//  Created by menglingchao on 2021/8/26.
//  Copyright © 2021 MengLingChao. All rights reserved.
//

import UIKit

public class LCSProgressHUD: UIView {//@objcMembers
    
    public enum HudType {
        case toast
        case loading
        case custom
    }
    public let type: HudType
    public var rotateDuration: Double = 0 {
        didSet {
            annularView.layer.removeAnimation(forKey: "rotate")
            
            let animation = CABasicAnimation(keyPath: "transform.rotation")
            animation.fromValue = 0
            animation.toValue = Double.pi * 2
            animation.duration = rotateDuration
            animation.isRemovedOnCompletion = false
            animation.repeatCount = HUGE
            animation.fillMode = .forwards
            animation.autoreverses = false
            annularView.layer.add(animation, forKey: "rotate")
        }
    }
    public let backgroundView = UIView()
    public let bezelView = UIView()
    public var bezelViewMaxWidthRate: CGFloat = 1 {
        didSet {
            lcs_removeConstraints(firstItem: bezelView, firstAttribute: .width)
//            bezelView.lcs_removeConstraints(firstAttribute: .width, secondItem: self)
            bezelView.snp.makeConstraints { make in
                make.width.lessThanOrEqualToSuperview().multipliedBy(bezelViewMaxWidthRate)
            }
        }
    }
    public let annularView: LCSAnnularView
    public let annularWidth: CGFloat
    public var annularViewTopMargin = 0 {
        didSet {
            guard type == .loading else {
                return
            }
            annularView.snp_updateConstraints { make in
                make.top.equalToSuperview().offset(annularViewTopMargin)
            }
        }
    }
    public let titleLabel = UILabel()
    public var titleLabelEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) {
        didSet {
            switch type {
            case .toast:
                titleLabel.snp_updateConstraints { make in
                    make.edges.equalToSuperview().inset(titleLabelEdgeInsets)
                }
            case .loading:
                titleLabel.snp_updateConstraints { make in
                    make.left.equalToSuperview().offset(titleLabelEdgeInsets.left)
                    make.right.equalToSuperview().offset(-titleLabelEdgeInsets.right)
                    make.top.equalTo(annularView.snp_bottom).offset(titleLabelEdgeInsets.top)
                    make.bottom.equalToSuperview().offset(-titleLabelEdgeInsets.bottom)
                }
            case .custom:
                break
            }
        }
    }
    public var customView: UIView? {
        didSet {
            guard type == .custom else {
                return
            }
            customView?.removeFromSuperview()
            guard let aCustomView = customView else {
                return
            }
            bezelView.addSubview(aCustomView)
            aCustomView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
    }
    public var customViewEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) {
        didSet {
            guard type == .custom, let aCustomView = customView else {
                return
            }
            aCustomView.snp_updateConstraints { make in
                make.edges.equalToSuperview().inset(customViewEdgeInsets)
            }
        }
    }
    private var hideDelayTimer: Timer?
    
    public init(forView view: UIView, type aType: HudType = .toast, annularWidth aAnularWidth: CGFloat = 22) {
        type = aType
        annularWidth = aAnularWidth
        annularView = LCSAnnularView(strokeThickness: 2, width: annularWidth)
        
        super.init(frame: .zero)
        
        addBackgroundView()
        addBezelView()
        
        switch aType {
        case .toast:
            addTitleLabel()
            titleLabel.snp.makeConstraints { make in
                make.top.equalToSuperview()
            }
        case .loading:
            addAnnularView()
            
            addTitleLabel()
            titleLabel.snp.makeConstraints { make in
                make.top.equalTo(annularView.snp_bottom).offset(5)
            }
        case .custom:
            break
        }
        
        view.addSubview(self)
        snp_makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: -
    private func addBackgroundView() {
        addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    private func addBezelView() {
        addSubview(bezelView)
        bezelView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.lessThanOrEqualToSuperview()
            make.height.lessThanOrEqualToSuperview()
        }
    }
    private func addAnnularView() {
        bezelView.addSubview(annularView)
        annularView.snp.makeConstraints { make in
            make.centerX.top.equalToSuperview()
            make.width.height.equalTo(annularWidth)
        }
    }
    private func addTitleLabel() {
        bezelView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
        }
    }
    public class func HUDForView(_ view: UIView) -> LCSProgressHUD? {
        for subview in view.subviews {
            if let hud = subview as? LCSProgressHUD {
                return hud
            }
        }
        return nil
    }
    public class func hideHUDForView(_ view: UIView) {
        for subview in view.subviews {
            guard let hud = subview as? LCSProgressHUD else {
                continue
            }
            hud.removeFromSuperview()
        }
    }
    public func hideAfterDelay(_ delay: Double) {
        hideDelayTimer = Timer(timeInterval: delay, target: self, selector: #selector(hideAfterDelayAction), userInfo: nil, repeats: false)
        RunLoop.current.add(hideDelayTimer!, forMode: .common)
    }
    @objc private func hideAfterDelayAction() {
        hideDelayTimer = nil
        removeFromSuperview()
    }
}
