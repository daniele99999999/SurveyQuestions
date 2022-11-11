//
//  ApiServiceMock.swift
//

import Foundation
@testable import SurveyQuestions

class ApiServiceMock: APIProtocol {
    var _getQuestions: ((@escaping (Result<[SurveyQuestions.QuestionList.Item], Error>) -> Void) -> VoidClosure)?
    func getQuestions(completion: @escaping (Result<[SurveyQuestions.QuestionList.Item], Error>) -> Void) -> VoidClosure {
        return self._getQuestions!(completion)
    }
    
    var _submitQuestion: ((Int, String, @escaping (Result<Void, Error>) -> Void) -> VoidClosure)?
    func submitQuestion(questionId: Int, questionValue: String, completion: @escaping (Result<Void, Error>) -> Void) -> VoidClosure {
        return self._submitQuestion!(questionId, questionValue, completion)
    }
}
