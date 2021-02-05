//
//  UIView+LCSKit.swift
//  LCSKit
//
//  Created by menglingchao on 2020/9/14.
//  Copyright © 2020 MengLingChao. All rights reserved.
//

import UIKit

extension UIView {
    
    /**手势类型枚举 */
    public enum LCSGestureRecognizerType {
        case tap
        case longPress
        case pan
        case swipe
        case rotation
        case pinch
    }
    
    /**添加手势及其回调*/
    public func lcs_addGestureRecognizer(type: LCSGestureRecognizerType, callback:((_: UIGestureRecognizer) -> Void)?) -> UIGestureRecognizer {
        let viewTarget = LCSViewTarget(type: type, actionCallback: callback)
        let gestureRecognizer: UIGestureRecognizer
        switch type {
        case .tap:
            gestureRecognizer = UITapGestureRecognizer(target: viewTarget, action: #selector(LCSViewTarget.senderAction(sender:)))
        case .longPress:
            gestureRecognizer = UILongPressGestureRecognizer(target: viewTarget, action: #selector(LCSViewTarget.senderAction(sender:)))
        case .pan:
            gestureRecognizer = UIPanGestureRecognizer(target: viewTarget, action: #selector(LCSViewTarget.senderAction(sender:)))
        case .swipe:
            gestureRecognizer = UISwipeGestureRecognizer(target: viewTarget, action: #selector(LCSViewTarget.senderAction(sender:)))
        case .rotation:
            gestureRecognizer = UIRotationGestureRecognizer(target: viewTarget, action: #selector(LCSViewTarget.senderAction(sender:)))
        case .pinch:
            gestureRecognizer = UIPinchGestureRecognizer(target: viewTarget, action: #selector(LCSViewTarget.senderAction(sender:)))
        }
        
        addGestureRecognizer(gestureRecognizer)
        isUserInteractionEnabled = true
        
        viewTarget.gestureRecognizer = gestureRecognizer
        let viewTargets = lcs_viewTargets()
        viewTargets.add(viewTarget)
        
        return gestureRecognizer
    }
    /**移除某些类型手势及其回调*/
    public func lcs_removeGestureRecognizers(type: LCSGestureRecognizerType) {
        let viewTargets = lcs_viewTargets()
        let removedViewTargets = NSMutableArray()
        viewTargets.forEach { obj in
            guard let viewTarget = obj as? LCSViewTarget, viewTarget.type == type else {
                return
            }
            removedViewTargets.add(obj)
        }
        removedViewTargets.forEach { obj in
            guard let viewTarget = obj as? LCSViewTarget, let gestureRecognizer = viewTarget.gestureRecognizer else {
                return
            }
            removeGestureRecognizer(gestureRecognizer)
            viewTargets.remove(obj)
        }
    }
    /**移除所有手势及其回调*/
    public func lcs_removeAllGestureRecognizers() {
        let viewTargets = lcs_viewTargets()
        viewTargets.forEach { obj in
            guard let controlTarget = obj as? LCSViewTarget, let gestureRecognizer = controlTarget.gestureRecognizer else {
                return
            }
            removeGestureRecognizer(gestureRecognizer)
        }
        viewTargets.removeAllObjects()
    }
    /**移除自己的某一些约束*/
    public func lcs_removeConstraints(firstItem: AnyObject?, firstAttribute: NSLayoutConstraint.Attribute) {
        constraints.forEach { constraint in
            guard constraint.firstItem === firstItem, constraint.firstAttribute == firstAttribute else {
                return
            }
            if #available(iOS 8, *) {
                constraint.isActive = false
            } else {
                removeConstraint(constraint)
            }
        }
    }
    /**移除firstItem是自己的某一些约束*/
    public func lcs_removeConstraints(firstAttribute: NSLayoutConstraint.Attribute, secondItem: Any) {
        
    }
    /**添加约束*/
    public func lcs_addConstraint(firstAttribute: NSLayoutConstraint.Attribute, relation: NSLayoutConstraint.Relation, secondItem: AnyObject?, secondAttribute: NSLayoutConstraint.Attribute, multiplier: CGFloat, constant: CGFloat) {
        let constraint = NSLayoutConstraint(item: self, attribute: firstAttribute, relatedBy: relation, toItem: secondItem, attribute: secondAttribute, multiplier: multiplier, constant: constant)
        if #available(iOS 8, *) {
            constraint.isActive = true
        } else {
            var superview = self
            
            if let secondView = secondItem as? UIView {
                superview = lcs_closestCommonSuperview(secondView: secondView)
            }
            superview.addConstraint(constraint)
        }
    }
    /**返回离两个view最近的父视图*/
    public func lcs_closestCommonSuperview(secondView: UIView?) -> UIView {
        UIView()
    }
    
    private class LCSViewTarget: NSObject {
        
        let type: LCSGestureRecognizerType
        var gestureRecognizer: UIGestureRecognizer?//
        let actionCallback:((_: UIGestureRecognizer) -> Void)?//
        
        init(type aType: LCSGestureRecognizerType, actionCallback aActionCallback:((_: UIGestureRecognizer) -> Void)?) {
            type = aType
            actionCallback = aActionCallback
        }
        // MARK: -
        @objc func senderAction(sender: UIGestureRecognizer) {
            guard let aActionCallback = actionCallback else {
                return
            }
            aActionCallback(sender)
        }
    }
    
    /***/
    private func lcs_viewTargets() -> NSMutableArray {
        guard let controlTargets = objc_getAssociatedObject(self, &lcs_viewTargetsKey) as? NSMutableArray else {
            let controlTargets = NSMutableArray()
            objc_setAssociatedObject(self, &lcs_viewTargetsKey, controlTargets, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return controlTargets
        }
        return controlTargets
    }
}
private var lcs_viewTargetsKey: UInt8 = 0
