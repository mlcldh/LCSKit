//
//  LCSPhotosManager.swift
//  LCSKit
//
//  Created by menglingchao on 2020/9/15.
//

import Foundation
import UIKit
import AVFoundation
import Photos

/**相册/相机权限*/
public class LCSPhotoPermissionManager: NSObject {
    
    
    public class func requestPermissionWithSourceType(souceType: UIImagePickerController.SourceType, handler:((Bool, Bool, Bool, Bool) -> Void)?) {
        guard UIImagePickerController.isSourceTypeAvailable(souceType) else {
            guard let aCallback = handler else {
                return
            }
            aCallback(false, false, false, false)
            return
        }
        if souceType == .camera {
            let authorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
            switch authorizationStatus {
            case .authorized:
                if let aHandler = handler {
                    aHandler(true, true, false, false)
                }
            case .denied, .restricted:
                if let aHandler = handler {
                    aHandler(true, false, false, false)
                }
            case .notDetermined:
                AVCaptureDevice.requestAccess(for: .video) { granted in
                    DispatchQueue.main.async {
                        if let aHandler = handler {
                            aHandler(true, granted, false, true)
                        }
                    }
                }
            default:
                break
            }
            return
        }
        if #available(iOS 14, *) {
            let authorizationStatus = PHPhotoLibrary.authorizationStatus(for: .readWrite)
            switch authorizationStatus {
            case .notDetermined:
                PHPhotoLibrary.requestAuthorization(for: .readWrite) { status2 in
                    handle(status: status2, isNotDetermined: true, handler: handler)
                }
            default:
                handle(status: authorizationStatus, isNotDetermined: false, handler: handler)
            }
            return
        }
        let authorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch authorizationStatus {
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { status2 in
                DispatchQueue.main.async {
                    if let aHandler = handler {
                        aHandler(true, status2 == .authorized, false, true)
                    }
                }
            }
        default:
            handle(status: authorizationStatus, isNotDetermined: false, handler: handler)
        }
    }
    static func handle(status: PHAuthorizationStatus, isNotDetermined: Bool, handler:((Bool, Bool, Bool, Bool) -> Void)? ) {
        guard Thread.isMainThread else {
            DispatchQueue.main.async {
                handle(status: status, isNotDetermined: isNotDetermined, handler: handler)
            }
            return
        }
        switch status {
        case .authorized:
            if let aHandler = handler {
                aHandler(true, true, false, isNotDetermined)
            }
        case .limited:
            if let aHandler = handler {
                aHandler(true, true, true, isNotDetermined)
            }
        case .restricted:
            if let aHandler = handler {
                aHandler(true, false, false, isNotDetermined)
            }
        case .denied:
            if let aHandler = handler {
                aHandler(true, false, false, isNotDetermined)
            }
        default:
            break
        }
    }
}
