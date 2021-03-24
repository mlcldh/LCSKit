//
//  UITableView+LCSKit.swift
//  LCSKit
//
//  Created by menglingchao on 2021/3/23.
//

import UIKit

extension UITableView {
    
    public func lcs_register(cellClass: UITableViewCell.Type) {
        register(cellClass, forCellReuseIdentifier: NSStringFromClass(cellClass))
    }
    public func lcs_register(cellClasses: [UITableViewCell.Type]) {
        for cellClass in cellClasses {
            register(cellClass, forCellReuseIdentifier: NSStringFromClass(cellClass))
        }
    }
    public func lcs_register(headerFooterViewClass: UIView.Type) {
        register(headerFooterViewClass, forHeaderFooterViewReuseIdentifier: NSStringFromClass(headerFooterViewClass))
    }
    public func lcs_dequeueReusableCell(withCellClass cellClass: UITableViewCell.Type) -> UITableViewCell? {
        guard let cell = dequeueReusableCell(withIdentifier: NSStringFromClass(cellClass)) else {
            return nil
        }
        return cell
    }
    public func lcs_dequeueReusableHeaderFooterView(withClass aClass: UIView.Type) -> UITableViewHeaderFooterView? {
        guard let view = dequeueReusableHeaderFooterView(withIdentifier: NSStringFromClass(aClass)) else {
            return nil
        }
        return view
    }
}