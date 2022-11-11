//  
//  UIBarButtonItem+Action.swift
//

import Foundation
import UIKit

extension UIBarButtonItem {
    func addAction(_ closure: @escaping()->()) {
        primaryAction = UIAction { (action: UIAction) in closure() }
    }
}
