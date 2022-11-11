//  
//  HomeViewModelTests.swift
//

import XCTest
@testable import SurveyQuestions

class HomeViewModelTests: XCTestCase {
    
    func testTitle() {
        let vm = HomeViewModel()
        
        let expectation = self.expectation(description: "testTitle")
        vm.output.title = { title in
            XCTAssertEqual(title, "Welcome")
            expectation.fulfill()
        }
        vm.input.ready?()
        self.waitForExpectations(timeout: 1)
    }
    
    func testSurveyButtonTitle() {
        let vm = HomeViewModel()
        
        let expectation = self.expectation(description: "testSurveyButtonTitle")
        vm.output.surveyButtonTitle = { title in
            XCTAssertEqual(title, "Start Survey")
            expectation.fulfill()
        }
        vm.input.ready?()
        self.waitForExpectations(timeout: 1)
    }
    
    func testStartSurvey() {
        let vm = HomeViewModel()
        
        let expectation = self.expectation(description: "testStartSurvey")
        vm.output.startSurvey = {
            XCTAssertTrue(true)
            expectation.fulfill()
        }
        vm.input.ready?()
        vm.input.startSurvey?()
        self.waitForExpectations(timeout: 1)
    }
}
