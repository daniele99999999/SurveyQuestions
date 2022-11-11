//
//  NetworkProtocol.swift
//

import Foundation

public protocol NetworkProtocol {
    func fetchData(request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) -> VoidClosure
}
