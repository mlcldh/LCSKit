//
//  LCSPhotoPermissionManager.swift
//  LCSKit
//
//  Created by menglingchao on 2020/9/15.
//

import Foundation
import UIKit
import AVFoundation
import Photos

/***/
class LCSPhotoPermissionManager: NSObject {
    
    class func requestPermissionWithSourceType(souceType: UIImagePickerController.SourceType, callback:((_: Bool, _: Bool, _: Bool) -> Void)?) {
        guard UIImagePickerController.isSourceTypeAvailable(souceType) else {
            guard let aCallback = callback else {
                return
            }
            aCallback(false, false, false)
            return
        }
        
    }
}
