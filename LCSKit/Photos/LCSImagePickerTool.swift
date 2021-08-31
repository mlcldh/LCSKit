//
//  LCSImagePickerTool.swift
//  LCSKit
//
//  Created by menglingchao on 2020/12/18.
//  Copyright © 2020 ximalaya. All rights reserved.
//

import UIKit
import PhotosUI

/**相册选择*/
public class LCSImagePickerTool: NSObject {
    
    public class func pickSingleImage(inViewController viewController: UIViewController, didFinishPickingHandler:((UIImage) -> Void)?) {
        guard #available(iOS 14, *) else {
            useUIImagePickerControllerToPickSingleImage(inViewController: viewController, didFinishPickingHandler: didFinishPickingHandler)
            return
        }
        #if targetEnvironment(macCatalyst)
        useUIImagePickerControllerToPickSingleImage(inViewController: viewController, didFinishPickingHandler: didFinishPickingHandler)
        #else
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        
        let pickerVC = PHPickerViewController(configuration: configuration)
        pickerVC.modalPresentationStyle = .fullScreen
        let pickerVCManager = LCSPHPickerViewControllerManager(pickerViewController: pickerVC)
        pickerVCManager.didFinishPickingHandler = {[unowned pickerVC] results in
            pickerVC.dismiss(animated: true, completion: nil)
            guard results.count > 0, let result = results.first, result.itemProvider.canLoadObject(ofClass: UIImage.self) else {
                return
            }
            result.itemProvider.loadObject(ofClass: UIImage.self) { (object, error) in
                guard let image = object as? UIImage else {
                    return
                }
                DispatchQueue.main.async {
                    if let aDidFinishPickingHandler = didFinishPickingHandler {
                        aDidFinishPickingHandler(image)
                    }
                }
            }
        }
        viewController.present(pickerVC, animated: true, completion: nil)
        #endif
    }
    private class func useUIImagePickerControllerToPickSingleImage(inViewController viewController: UIViewController, didFinishPickingHandler:((UIImage) -> Void)?) {
        let pickerController = UIImagePickerController()
        pickerController.sourceType = .photoLibrary
        if let availableMediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary) {
            pickerController.mediaTypes = availableMediaTypes
        }
        pickerController.mediaTypes = ["public.image"]
        pickerController.modalPresentationStyle = .fullScreen
        let pickerVCManager = LCSImagePickerControllerManager(pickerViewController: pickerController)
        pickerVCManager.didFinishPickingMediaHandler = {[unowned pickerController] info in
            pickerController.dismiss(animated: true, completion: nil)
            if let image = info[.originalImage] as? UIImage, let aDidFinishPickingHandler = didFinishPickingHandler {
                aDidFinishPickingHandler(image)
            }
        }
        viewController.present(pickerController, animated: true, completion: nil)
    }
}
