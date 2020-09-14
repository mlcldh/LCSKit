//
//  UIView+LCSKit.swift
//  LCSKit
//
//  Created by menglingchao on 2020/9/14.
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
    func lcs_removeGestureRecognizers(type: LCSGestureRecognizerType) {
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
    func lcs_removeAllGestureRecognizers() {
        let viewTargets = lcs_viewTargets()
        viewTargets.forEach { obj in
            guard let controlTarget = obj as? LCSViewTarget, let gestureRecognizer = controlTarget.gestureRecognizer else {
                return
            }
            removeGestureRecognizer(gestureRecognizer)
        }
        viewTargets.removeAllObjects()
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
