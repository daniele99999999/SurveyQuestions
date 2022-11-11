//
//  ApiProtocol.swift
//

import Foundation

public protocol APIHandleResponseProtocol {}

public extension APIHandleResponseProtocol {
    func handleResponse<T: Decodable>(completion: @escaping (Result<T, Error>) -> Void) -> (Result<Data, Error>) -> Void {
        return { result in
            switch result {
            case .success(let data):
                do {
                    let decoded = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decoded))
                } catch let decodeError {
                    completion(.failure(decodeError))
                }
            case .failure(let responseError):
                completion(.failure(responseError))
            }
        }
    }
    
    func handleEmptyResponse(completion: @escaping (Result<Void, Error>) -> Void) -> (Result<Data, Error>) -> Void {
        return { result in
            switch result {
            case .success(_):
                completion(.success(Void()))
            case .failure(let responseError):
                completion(.failure(responseError))
            }
        }
    }
}

public protocol APIProtocol {
    func getQuestions(completion: @escaping (Result<[QuestionList.Item], Error>) -> Void) -> VoidClosure
    func submitQuestion(questionId: Int, questionValue: String, completion: @escaping (Result<Void, Error>) -> Void) -> VoidClosure
}
