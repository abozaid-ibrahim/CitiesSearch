//
//  UITableView+Cell.swift
//  CopyPasteSwift
//
//  Created by abuzeid on 22.09.20.
//  Copyright © 2020 abuzeid. All rights reserved.
//

import Foundation
import UIKit

public extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}

public extension UITableView {
    func dequeue<T: UITableViewCell>(cell: T.Type, for indexPath: IndexPath) -> T {
        let tableView = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath)
        guard let cell = tableView as? T else {
            fatalError("Failed to cast cell to \(T.identifier)")
        }
        return cell
    }
}
