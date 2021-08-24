//
//  LCSDeviceUtility.swift
//  LCSKit
//
//  Created by menglingchao on 2020/9/15.
//  Copyright © 2020 MengLingChao. All rights reserved.
//

import UIKit
import AdSupport
import CoreTelephony

/// 工具类
public class LCSDeviceUtility: NSObject {
    
    /// app版本号
    public class func appVersion() -> String {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""
    }
    /// app构建版本号
    public class func appBuildVersion() -> String {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? ""
    }
    /// 系统版本号
    public class func systemVersion() -> String {
        UIDevice.current.systemVersion
    }
    /// app名字
    public class func appName() -> String {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ?? ""
    }
    /// app的bundle ID
    public class func bundleIdentifier() -> String {
        Bundle.main.bundleIdentifier ?? ""
    }
    /// IDFA，广告标示符
    public class func idfa() -> String {
        ASIdentifierManager.shared().advertisingIdentifier.uuidString
    }
    /// 广告跟踪是否开启
    public class func advertisingTrackingEnabled() -> Bool {
        ASIdentifierManager.shared().isAdvertisingTrackingEnabled
    }
    /// IDFV
    public class func identifierForVendor() -> String {
        UIDevice.current.identifierForVendor?.uuidString ?? ""
    }
    /// 运营商名字
    public class func machine() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        return machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else {
                return identifier
            }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
    }
    /// 是否越狱
    public class func isJailbroken() -> Bool {
        guard !FileManager.default.fileExists(atPath: "/Applications/Cydia.app") else {
            return true
        }
        guard FileManager.default.fileExists(atPath: "/private/var/lib/apt/") else {
            return false
        }
        return true
    }
    /// 运营商名字
    public class func carrierName() -> String {
        let networkInfo = CTTelephonyNetworkInfo()
        return networkInfo.subscriberCellularProvider?.carrierName ?? ""
    }
    /// 蜂窝网络类型
    public class func currentRadioAccessTechnology() -> String? {
        guard let networkInfo = CTTelephonyNetworkInfo().currentRadioAccessTechnology else {
            return nil
        }
        switch networkInfo {
        case CTRadioAccessTechnologyGPRS:
            return "GPRS"
        case CTRadioAccessTechnologyEdge:
            return "Edge"
        case CTRadioAccessTechnologyCDMA1x:
            return "GPRS"
        case CTRadioAccessTechnologyLTE:
            return "4G"
        default:
            return nil
        }
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
    /// 状态栏高度
    func statusBarHeight() -> CGFloat {
        guard #available(iOS 13.0, *) else {
            return UIApplication.shared.statusBarFrame.size.height
        }
        return UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.size.height ?? 0
    }
    /// 安全区域，iOS 11以下的返回UIEdgeInsetsMake(20, 0, 0, 0)
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
