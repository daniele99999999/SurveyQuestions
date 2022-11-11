//
//  UIViewController+BackArrowOnly.swift
//

import Foundation
import UIKit

extension UIViewController {
    func showBackArrowOnly() {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}
