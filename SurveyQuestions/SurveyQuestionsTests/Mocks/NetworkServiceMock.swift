//
//  NetworkServiceMock.swift
//

import Foundation
@testable import SurveyQuestions

class NetworkServiceMock: NetworkProtocol {
    var _fetchData: ((URLRequest, @escaping (Result<Data, Error>) -> Void) -> VoidClosure)?
    func fetchData(request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) -> VoidClosure {
        return self._fetchData!(request, completion)
    }
}
