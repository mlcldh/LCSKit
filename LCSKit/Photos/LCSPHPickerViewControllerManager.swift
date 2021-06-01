//
//  LCSPHPickerViewControllerManager.swift
//  LCSKit
//
//  Created by menglingchao on 2020/12/18.
//  Copyright © 2020 ximalaya. All rights reserved.
//

import UIKit
import PhotosUI

#if !targetEnvironment(macCatalyst)
@available(iOS 14, *)
public class LCSPHPickerViewControllerManager: NSObject, PHPickerViewControllerDelegate {
    
    unowned var pickerViewController: PHPickerViewController
    private let managerKey = "LCSPHPickerViewControllerManagerKey"
    var didFinishPickingHandler:(([PHPickerResult]) -> Void)?
    
    deinit {
        print("menglc LCSPHPickerViewControllerManager deinit")
    }
    init(pickerViewController aPickerViewController: PHPickerViewController) {
        pickerViewController = aPickerViewController
        
        super.init()
        
        aPickerViewController.delegate = self
        
        objc_setAssociatedObject(aPickerViewController, managerKey, self, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)//防止自己被释放
    }
    // MARK: - PHPickerViewControllerDelegate
    public func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        if let aDidFinishPickingHandler = didFinishPickingHandler {
            aDidFinishPickingHandler(results)
        }
        objc_setAssociatedObject(pickerViewController as Any, managerKey, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}
#endif
