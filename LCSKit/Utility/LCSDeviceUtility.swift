//
//  LCSDeviceUtility.swift
//  LCSKit
//
//  Created by menglingchao on 2020/9/15.
//  Copyright © 2020 MengLingChao. All rights reserved.
//

import UIKit

/**工具类*/
public class LCSDeviceUtility: NSObject {
    
    /**app版本号*/
    public class func appVersion() -> String {
        
        struct Temp {
            static var appVersion: String = ""
        }
        
        guard Temp.appVersion.count > 0 else {
            guard let string = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String else {
                return ""
            }
            Temp.appVersion = string
            return string
        }
        return Temp.appVersion
    }
    /**app构建版本号*/
    public class func appBuildVersion() -> String {
        ""
    }
    /// 系统版本号
    public class func systemVersion() -> String {
        UIDevice.current.systemVersion
    }
    /**app名字*/
    public class func appName() -> String {
        ""
    }
    /**app的bundle ID*/
    public class func bundleIdentifier() -> String {
        ""
    }
    /**IDFA，广告标示符*/
    public class func idfa() -> String {
        ""
    }
    /**广告跟踪是否开启*/
    public class func advertisingTrackingEnabled() -> Bool {
        true
    }
    /**IDFV*/
    public class func identifierForVendor() -> String {
        ""
    }
    /**运营商名字*/
    public class func carrierName() -> String {
        ""
    }
    /**蜂窝网络类型*/
    public class func currentRadioAccessTechnology() -> String {
        ""
    }
    /// 电池状态
    func batteryStauts() -> UIDevice.BatteryState {
        UIDevice.current.batteryState
    }
    /// 电池电量
    func batteryLevel() -> Float {
        UIDevice.current.batteryLevel
    }
    /// 总内存大小
    func totalMemorySize() -> UInt64 {
        ProcessInfo.processInfo.physicalMemory
    }
    /**安全区域，iOS 11以下的返回UIEdgeInsetsMake(20, 0, 0, 0)*/
    public class func safeAreaInsets() -> UIEdgeInsets {
        guard #available(iOS 11, *), let window = UIApplication.shared.delegate?.window as? UIWindow else {
            return UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        }
        let insets = window.safeAreaInsets
        guard insets.top > 20 else {
            return UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        }
        return insets
    }
}
