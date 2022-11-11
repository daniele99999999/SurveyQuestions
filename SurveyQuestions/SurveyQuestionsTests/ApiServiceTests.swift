//
//  ApiServiceTests.swift
//

import XCTest
@testable import SurveyQuestions

class ApiServiceTests: XCTestCase {
    
    func testDecodingApiList() {
        let url = URL(string: "https://www.google.com")!
        let questionListMock = HelperTests.loadJSON(name: "QuestionListDataMock")
        
        let expectation = self.expectation(description: "testDecodingApiList")
        let networkServiceMock = NetworkServiceMock()
        networkServiceMock._fetchData = { _, completion in
            completion(.success(questionListMock))
            return {}
        }
        
        let apiService: ApiService = ApiService(baseURL: url, networkService: networkServiceMock)
        _ = apiService.getQuestions() { result in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.count, 10)
                XCTAssertEqual(response.first!.id, 1)
                XCTAssertEqual(response.first!.question, "What is your favourite colour?")
                XCTAssertEqual(response.last!.id, 10)
                XCTAssertEqual(response.last!.question, "What is your favourite brand?")
            case .failure(let error):
                XCTFail("error: \(error)")
            }
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 1)
    }
    
    func testDecodingApiSubmit() {
        let url = URL(string: "https://www.google.com")!
        let questionId = 1
        let questionValue = "red"
        
        let expectation = self.expectation(description: "testDecodingApiSubmit")
        let networkServiceMock = NetworkServiceMock()
        networkServiceMock._fetchData = { _, completion in
            completion(.success(Data()))
            return {}
        }
        
        let apiService: ApiService = ApiService(baseURL: url, networkService: networkServiceMock)
        _ = apiService.submitQuestion(questionId: questionId, questionValue: questionValue) { result in
            switch result {
            case .success(_):
                XCTAssertTrue(true)
            case .failure(let error):
                XCTFail("error: \(error)")
            }
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 1)
    }
}
