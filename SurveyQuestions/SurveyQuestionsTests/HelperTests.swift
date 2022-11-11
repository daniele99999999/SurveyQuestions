//  
//  HelperTests.swift
//

import XCTest
@testable import SurveyQuestions

class HelperTests {
    struct FakeError: Error {}
    static let fakeError = FakeError()
    
    static func loadJSON(name: String) -> Data {
        let bundle = Bundle(for: Self.self)
        let path = bundle.url(forResource: name, withExtension: "json")!
        return try! Data(contentsOf: path)
    }
    
    static func loadList() -> [QuestionList.Item] {
        return try! JSONDecoder().decode([QuestionList.Item].self, from: Self.loadJSON(name: "QuestionListDataMock"))
    }
    
    static func loadListFirt() -> QuestionList.Item {
        return self.loadList().first!
    }
    
    static func loadListLast() -> QuestionList.Item {
        return self.loadList().last!
    }
}

