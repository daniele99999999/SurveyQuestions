//
//  DataTaskServiceMock.swift
//

import Foundation
@testable import SurveyQuestions

class DataTaskServiceMock: DataTaskProtocol {
    var _dataTask: ((URLRequest, @escaping (Data?, URLResponse?, Error?) -> Void) -> VoidClosure)?
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> VoidClosure {
        return self._dataTask!(request, completionHandler)
    }
}
