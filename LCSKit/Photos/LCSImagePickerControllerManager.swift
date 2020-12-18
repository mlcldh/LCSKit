//
//  LCSImagePickerControllerManager.swift
//  LCSKit
//
//  Created by menglingchao on 2020/12/18.
//  Copyright © 2020 ximalaya. All rights reserved.
//

import UIKit

public class LCSImagePickerControllerManager: NSObject, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    weak var pickerViewController: UIImagePickerController?
    private let managerKey = "LCSImagePickerControllerManagerKey"
    
    var didFinishPickingMediaHandler:(([UIImagePickerController.InfoKey : Any]) -> Void)?
    var didCancelHandler:(() -> Void)?
    
    deinit {
        print("menglc LCSImagePickerControllerManager deinit")
    }
    init(pickerViewController aPickerViewController: UIImagePickerController) {
        pickerViewController = aPickerViewController
        super.init()
        
        aPickerViewController.delegate = self
        
        objc_setAssociatedObject(aPickerViewController, managerKey, self, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)//防止自己被释放
    }
    // MARK: -
    func clearSelfFromPickerViewController() {//防止自己被释放
        objc_setAssociatedObject(pickerViewController as Any, managerKey, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    // MARK: - UIImagePickerControllerDelegate
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let aDidFinishPickingMediaHandler = didFinishPickingMediaHandler {
            aDidFinishPickingMediaHandler(info)
        }
        clearSelfFromPickerViewController()
    }
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        if let aDidCancelHandler = didCancelHandler {
            aDidCancelHandler()
            return
        }
        clearSelfFromPickerViewController()
        guard let _ = didCancelHandler else {
            picker.dismiss(animated: true, completion: nil)
            return
        }
    }
}
