//
//  DataTaskProtocol.swift
//

import Foundation

public protocol DataTaskProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> VoidClosure
}
