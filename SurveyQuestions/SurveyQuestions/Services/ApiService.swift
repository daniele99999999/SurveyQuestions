//
//  ApiService.swift
//

import Foundation

public struct ApiService {
    enum Endpoints {
        enum Question {
            case list
            case submit(questionId: Int, questionValue: String)
            
            private var path: [String] {
                switch self {
                case .list:
                    return ["questions"]
                case .submit(questionId: _, questionValue: _):
                    return ["question", "submit"]
                }
            }
            
            func url(baseURL: URL) -> URL {
                switch self {
                case .list, .submit(questionId: _, questionValue: _):
                    return self.path.reduce(baseURL) { $0.appendingPathComponent($1) }
                }
            }
            
            var method: String {
                switch self {
                case .list:
                    return "GET"
                case .submit(questionId: _, questionValue: _):
                    return "POST"
                }
            }
            
            var body: Data? {
                switch self {
                case .list:
                    return nil
                case .submit(questionId: let questionId, questionValue: let questionValue):
                    return try? JSONEncoder().encode(QuestionSubmitRequest.Body.init(id: questionId, answer: questionValue))
                }
            }
        }
    }
    
    let baseURL: URL
    let networkService: NetworkProtocol
    
    init(baseURL: URL, networkService: NetworkProtocol) {
        self.baseURL = baseURL
        self.networkService = networkService
    }
}

extension ApiService: APIHandleResponseProtocol {}
extension ApiService: APIProtocol {
    public func getQuestions(completion: @escaping (Result<[QuestionList.Item], Error>) -> Void) -> VoidClosure {
        let endpoint = Endpoints.Question.list
        let fullUrl = endpoint.url(baseURL: self.baseURL)
        var request = URLRequest(url: fullUrl)
        request.httpMethod = endpoint.method
        request.httpBody = endpoint.body
        return self.networkService.fetchData(
            request: request,
            completion: self.handleResponse(completion: completion)
        )
    }
    
    public func submitQuestion(questionId: Int, questionValue: String, completion: @escaping (Result<Void, Error>) -> Void) -> VoidClosure {
        let endpoint = Endpoints.Question.submit(questionId: questionId, questionValue: questionValue)
        let fullUrl = endpoint.url(baseURL: self.baseURL)
        var request = URLRequest(url: fullUrl)
        request.httpMethod = endpoint.method
        request.httpBody = endpoint.body
        return self.networkService.fetchData(
            request: request,
            completion: self.handleEmptyResponse(completion: completion)
        )
    }
}
