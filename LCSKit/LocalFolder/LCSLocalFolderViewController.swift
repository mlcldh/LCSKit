//
//  LCSLocalFolderViewController.swift
//  LCSKit
//
//  Created by menglingchao on 2020/9/15.
//

import UIKit
import SnapKit

public class LCSLocalFolderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIDocumentInteractionControllerDelegate {
    
    public let folderPath: String
    private var subpaths:[String] = []
    private var files:[String] = []
    
    public init(folderPath aFolderPath: String) {
        folderPath = aFolderPath
        super.init(nibName: nil, bundle: nil)
        if let titleNS = title as NSString? {
            title = titleNS.lastPathComponent
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        subpaths.append("..")
        
        do {
            let contents = try FileManager.default.contentsOfDirectory(atPath: folderPath)
            contents.forEach { fileName in
                guard let folderPathNS = folderPath as NSString? else {
                    return
                }
                let fullFileName = folderPathNS.appendingPathComponent(fileName)
                var isDirectory = ObjCBool.init(false)
                
                FileManager.default.fileExists(atPath: fullFileName, isDirectory: &isDirectory)
                if isDirectory.boolValue {
                    subpaths.append(fileName)
                }
                else {
                    files.append(fileName)
                }
            }
        }
        catch {
            print("menglc contentsOfDirectory failed")
        }
        
        addTableView()
    }
    // MARK: -
    private func addTableView() {
        let tableView = UITableView()
        tableView.estimatedRowHeight = 44
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: NSStringFromClass(UITableViewCell.self))
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    // MARK: - UITableViewDelegate
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let folderPathNS = folderPath as NSString? else {
            return
        }
        if indexPath.section == 0 {
            guard let subpath = subpaths[indexPath.row] as String? else {
                return
            }
            let fileName = folderPathNS.appendingPathComponent(subpath)
            let vc = LCSLocalFolderViewController(folderPath: fileName)
            navigationController?.pushViewController(vc, animated: true)
            return
        }
        guard let file = files[indexPath.row] as String?, let fileNameNS = folderPathNS.appendingPathComponent(file) as NSString? else {
            return
        }
        let fileName = fileNameNS.standardizingPath
        let documentIC = UIDocumentInteractionController(url: URL(fileURLWithPath: fileName))
        documentIC.delegate = self
        guard documentIC.presentPreview(animated: true) == false else {
            return
        }
        guard documentIC.presentOpenInMenu(from: view.bounds, in: view, animated: true) == false else {
            return
        }
        print("menglc 沒有程序可以打开选中的文件")
    }
    // MARK: - UITableViewDataSource
    public func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return subpaths.count
        }
        return files.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(UITableViewCell.self)) else {
            return UITableViewCell()
        }
        var fileName = ""
        
        if indexPath.section == 0, let title = subpaths[indexPath.row] as String? {
            fileName = title
//            cell.accessoryType = DisclosureIndicator
            cell.backgroundColor = .yellow
        } else if indexPath.section == 1, let title = files[indexPath.row] as String? {
            fileName = title
            cell.backgroundColor = .lightGray
        }
        cell.textLabel?.text = fileName
        return cell
    }
}
