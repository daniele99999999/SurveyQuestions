//  
//  UIKit+BindOnMainThread.swift
//

import Foundation
import UIKit

extension UIViewController {
    class func bindOnMain<T>(_ closure: @escaping (T) -> Void) -> (T) -> Void {
        return { input in
            DispatchQueue.main.async { closure(input) }
        }
    }
    
    class func bindOnMain(_ closure: @escaping () -> Void) -> () -> Void {
        return {
            DispatchQueue.main.async { closure() }
        }
    }
}

extension UIView {
    class func bindOnMain<T>(_ closure: @escaping (T) -> Void) -> (T) -> Void {
        return { input in
            DispatchQueue.main.async { closure(input) }
        }
    }
    
    class func bindOnMain(_ closure: @escaping () -> Void) -> () -> Void {
        return {
            DispatchQueue.main.async { closure() }
        }
    }
}
