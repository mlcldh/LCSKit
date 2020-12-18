//
//  LCSOpenUtility.swift
//  LCSKit
//
//  Created by menglingchao on 2020/12/18.
//

import UIKit

/**打开相关工具类*/
public class LCSOpenUtility: NSObject {
    
    /**让UIApplication打开链接*/
    public static func open(url: URL, completionHandler: ((Bool) -> Void)?) {
        let app = UIApplication.shared
        guard app.canOpenURL(url) else {
            if let aCompletionHandler = completionHandler {
                aCompletionHandler(false)
            }
            return
        }
        guard #available(iOS 10, *) else {
            let ok = app.openURL(url)
            if let aCompletionHandler = completionHandler {
                aCompletionHandler(ok)
            }
            return
        }
        app.open(url, options: [:], completionHandler: completionHandler)
    }
    /**打电话*/
    public static func call(telephoneNumber: String) {
        if let url = URL(string: "tel://\(telephoneNumber)"){
            self.open(url: url, completionHandler: nil)
        }
    }
    /**发邮件*/
    public static func sendEmail(email: String) {
        if let url = URL(string: "mailto://\(email)"){
            self.open(url: url, completionHandler: nil)
        }
    }
    /**发短信*/
    public static func sendShortMessage(shortMessage: String) {
        if let url = URL(string: "sms://\(shortMessage)"){
            self.open(url: url, completionHandler: nil)
        }
    }
    /**跳转到app设置页面*/
    public static func openSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString){
            self.open(url: url, completionHandler: nil)
        }
    }
}
