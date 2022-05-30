//
//  UIControl+LCSKit.swift
//  LCSKitDemo
//
//  Created by menglingchao on 2020/9/14.
//  Copyright © 2020 MengLingChao. All rights reserved.
//

import UIKit

extension UIControl {
    
    /**添加事件*/
    public func lcs_addActionForControlEvents(controlEvents: UIControl.Event, callback:((_: UIControl) -> Void)?) {
        let controlTarget = LCSControlTarget(controlEvents: controlEvents, actionCallback: callback)
        addTarget(controlTarget, action: #selector(LCSControlTarget.senderAction(sender:)), for: controlEvents)
        let controlTargets = lcs_controlTargets()
        controlTargets.add(controlTarget)
    }
    /**移除某些类型的所有事件*/
    public func lcs_removeAllActions(forControlEvents controlEvents: UIControl.Event) {
        let controlTargets = lcs_controlTargets()
        let removedTargets = NSMutableArray()
        controlTargets.forEach { obj in
            guard let controlTarget = obj as? LCSControlTarget, controlTarget.controlEvents == controlEvents else {
                return
            }
            removedTargets.add(controlTarget)
        }
        removedTargets.forEach { obj in
            guard let controlTarget = obj as? LCSControlTarget else {
                return
            }
            removeTarget(controlTarget, action: #selector(LCSControlTarget.senderAction(sender:)), for: controlTarget.controlEvents)
            controlTargets.remove(obj)
        }
    }
    /**移除所有事件*/
    public func lcs_removeAllActions() {
        let controlTargets = lcs_controlTargets()
        controlTargets.forEach { obj in
            guard let controlTarget = obj as? LCSControlTarget else {
                return
            }
            removeTarget(controlTarget, action: #selector(LCSControlTarget.senderAction(sender:)), for: controlTarget.controlEvents)
        }
        controlTargets.removeAllObjects()
    }
    private class LCSControlTarget: NSObject {
        
        let actionCallback:((_: UIControl) -> Void)?//
        let controlEvents: UIControl.Event//
        
        init(controlEvents aControlEvents: UIControl.Event, actionCallback aActionCallback:((_: UIControl) -> Void)?) {
            controlEvents = aControlEvents
            actionCallback = aActionCallback
        }
        // MARK: -
        @objc func senderAction(sender: UIControl) {
            guard let aActionCallback = actionCallback else {
                return
            }
            aActionCallback(sender)
        }
    }
    
    /***/
    private func lcs_controlTargets() -> NSMutableArray {
        guard let controlTargets = objc_getAssociatedObject(self, &lcs_controlTargetsKey) as? NSMutableArray else {
            let controlTargets = NSMutableArray()
            objc_setAssociatedObject(self, &lcs_controlTargetsKey, controlTargets, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return controlTargets
        }
        return controlTargets
    }
}
private var lcs_controlTargetsKey: UInt8 = 0
