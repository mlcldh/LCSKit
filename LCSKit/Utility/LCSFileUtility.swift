//
//  LCSFileUtility.swift
//  LCSKit
//
//  Created by menglingchao on 2021/4/2.
//

import UIKit

/// 文件相关工具类
public class LCSFileUtility: NSObject {
    
    /// 获取Document文件目录
    func documentDirectoryPath() -> String? {
        NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
    }
    /// 获取Temp文件目录
    func temporaryDirectoryPath() -> String? {
        NSTemporaryDirectory()
    }
    /// 获取Home文件目录
    func homeDirectoryPath() -> String? {
        NSHomeDirectory()
    }
    /// 获取Cache文件目录
    func cachesDirectoryPath() -> String? {
        NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first
    }
    /// 创建文件夹
    func creatDirectory(atPath path: String) throws {
        let fileManager = FileManager.default
        var isDirectory: ObjCBool = false
        let fileExists = fileManager.fileExists(atPath: path, isDirectory: &isDirectory)
        guard isDirectory.boolValue == true, fileExists == true else {
            return
        }
        try fileManager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
    }
    /// 删除目录或文件
    func removeItem(atPath path: String) throws {
        let fileManager = FileManager.default
        let fileExists = fileManager.fileExists(atPath: path)
        guard fileExists == true else {
            return
        }
        try fileManager.removeItem(atPath: path)
    }
    /// 移动文件
    func moveItem(atPath srcPath: String, toPath dstPath: String) throws {
        let fileManager = FileManager.default
        let fileExists = fileManager.fileExists(atPath: srcPath, isDirectory: nil)
        guard fileExists == true else {
            return
        }
        if let dstPathNS = dstPath as NSString? {
            try creatDirectory(atPath: dstPathNS.deletingLastPathComponent)
        }
        try fileManager.moveItem(atPath: srcPath, toPath: dstPath)
    }
    /// 拷贝文件
    func copyItem(atPath srcPath: String, toPath dstPath: String) throws {
        let fileManager = FileManager.default
        let fileExists = fileManager.fileExists(atPath: srcPath, isDirectory: nil)
        guard fileExists == true else {
            return
        }
        if let dstPathNS = dstPath as NSString? {
            try creatDirectory(atPath: dstPathNS.deletingLastPathComponent)
        }
        try fileManager.copyItem(atPath: srcPath, toPath: dstPath)
    }
    /// 获取文件或者文件夹大小(单位：B)
    func size(atPath path: String) throws -> UInt64 {
        let fileManager = FileManager.default
        var isDirectory: ObjCBool = false
        guard fileManager.fileExists(atPath: path, isDirectory: &isDirectory) else {
            return 0
        }
        guard isDirectory.boolValue else {
            guard let attributesNS = try fileManager.attributesOfItem(atPath: path) as NSDictionary? else {
                return 0
            }
            return attributesNS.fileSize()
        }
        var fileSize: UInt64 = 0
        let enumerator = fileManager.enumerator(atPath: path)
        
        while enumerator != nil {
            if let fileAttributesNS = enumerator?.fileAttributes as NSDictionary? {
                fileSize += fileAttributesNS.fileSize()
            }
        }
        return fileSize
    }
}
