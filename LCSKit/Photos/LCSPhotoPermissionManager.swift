//
//  LCSPhotosManager.swift
//  LCSKit
//
//  Created by menglingchao on 2020/9/15.
//  Copyright © 2020 MengLingChao. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import Photos

/**相册/相机权限*/
public class LCSPhotoPermissionManager: NSObject {
    
    /// 请求相册/相机权限
    /// - Parameters:
    ///   - souceType: 类型，是相册还是相机
    ///   - sourceTypeUnavailableHandler: 当前设备没有该功能
    ///   - isNotDeterminedHandler: 请求权限之前还未处理
    ///   - handler: 回调
    public class func requestPermissionWithSourceType(souceType: UIImagePickerController.SourceType, sourceTypeUnavailableHandler:(() -> Void)?, isNotDeterminedHandler:(() -> Void)?, handler:((Bool, Bool) -> Void)?) {
        guard UIImagePickerController.isSourceTypeAvailable(souceType) else {
            guard let aSourceTypeUnavailableHandler = sourceTypeUnavailableHandler else {
                return
            }
            aSourceTypeUnavailableHandler()
            return
        }
        if souceType == .camera, #available(macCatalyst 14.0, *) {
            let authorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
            switch authorizationStatus {
            case .authorized:
                if let aHandler = handler {
                    aHandler(true, false)
                }
            case .denied, .restricted:
                if let aHandler = handler {
                    aHandler(false, false)
                }
            case .notDetermined:
                if let aIsNotDeterminedHandler = isNotDeterminedHandler {
                    aIsNotDeterminedHandler()
                }
                AVCaptureDevice.requestAccess(for: .video) { granted in
                    DispatchQueue.main.async {
                        if let aHandler = handler {
                            aHandler(granted, false)
                        }
                    }
                }
            default:
                break
            }
            return
        }
        #if !targetEnvironment(macCatalyst)
        if #available(iOS 14, *) {
            let authorizationStatus = PHPhotoLibrary.authorizationStatus(for: .readWrite)
            switch authorizationStatus {
            case .notDetermined:
                PHPhotoLibrary.requestAuthorization(for: .readWrite) { status2 in
                    handle(status: status2, isNotDetermined: true, sourceTypeUnavailableHandler: sourceTypeUnavailableHandler, isNotDeterminedHandler: isNotDeterminedHandler, handler: handler)
                }
            default:
                handle(status: authorizationStatus, isNotDetermined: false, sourceTypeUnavailableHandler: sourceTypeUnavailableHandler, isNotDeterminedHandler: isNotDeterminedHandler, handler: handler)
            }
            return
        }
        #endif
        let authorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch authorizationStatus {
        case .notDetermined:
            if let aIsNotDeterminedHandler = isNotDeterminedHandler {
                aIsNotDeterminedHandler()
            }
            PHPhotoLibrary.requestAuthorization { status2 in
                DispatchQueue.main.async {
                    if let aHandler = handler {
                        aHandler(status2 == .authorized, false)
                    }
                }
            }
        default:
            handle(status: authorizationStatus, isNotDetermined: false, sourceTypeUnavailableHandler: sourceTypeUnavailableHandler, isNotDeterminedHandler: isNotDeterminedHandler, handler: handler)
        }
    }
    static func handle(status: PHAuthorizationStatus, isNotDetermined: Bool, sourceTypeUnavailableHandler:(() -> Void)?, isNotDeterminedHandler:(() -> Void)?, handler:((Bool, Bool) -> Void)? ) {
        guard Thread.isMainThread else {
            DispatchQueue.main.async {
                handle(status: status, isNotDetermined: isNotDetermined, sourceTypeUnavailableHandler: sourceTypeUnavailableHandler, isNotDeterminedHandler: isNotDeterminedHandler, handler: handler)
            }
            return
        }
        if isNotDetermined, let aIsNotDeterminedHandler = isNotDeterminedHandler {
            aIsNotDeterminedHandler()
        }
        switch status {
        case .authorized:
            if let aHandler = handler {
                aHandler(true, false)
            }
        #if !targetEnvironment(macCatalyst)
        case .limited:
            if let aHandler = handler {
                aHandler(true, true)
            }
        #endif
        case .restricted:
            if let aHandler = handler {
                aHandler(false, false)
            }
        case .denied:
            if let aHandler = handler {
                aHandler(false, false)
            }
        default:
            break
        }
    }
}
