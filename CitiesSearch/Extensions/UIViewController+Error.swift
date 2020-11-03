//
//  UIViewController+Error.swift
//  CopyPasteSwift
//
//  Created by abuzeid on 22.09.20.
//  Copyright © 2020 abuzeid. All rights reserved.
//

import UIKit
public typealias AnyAction = () -> Void
public typealias AlertAction = (title: String, action: AnyAction)
public extension UIViewController {
    func show(error: String) {
        let alert = UIAlertController(title: nil, message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Str.cancel, style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    func show(title: String? = nil, error: String?, actions: [AlertAction] = []) {
        let alertController = UIAlertController(title: title,
                                                message: error,
                                                preferredStyle: .alert)

        for action in actions {
            let settingsAction = UIAlertAction(title: action.title, style: .default) { _ in action.action() }
            alertController.addAction(settingsAction)
        }
        let cancelAction = UIAlertAction(title: Str.cancel, style: .default, handler: nil)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }
}
