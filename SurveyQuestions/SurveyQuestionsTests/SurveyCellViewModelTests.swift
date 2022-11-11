//  
//  SurveyCellViewModelTests.swift
//

import XCTest
@testable import SurveyQuestions

class SurveyCellViewModelTests: XCTestCase {
    
    func testReset() {
        let item = HelperTests.loadListFirt()
        let vm = SurveyCellViewModel(item: item, answered: nil)
        
        let expectation = self.expectation(description: "testReset")
        vm.output.reset = {
            expectation.fulfill()
        }
        vm.input.reset?()
        self.waitForExpectations(timeout: 1)
    }
    
    func testQuestionText() {
        let item = HelperTests.loadListFirt()
        let vm = SurveyCellViewModel(item: item, answered: nil)
        
        let expectation = self.expectation(description: "testQuestionText")
        vm.output.questionText = { text in
            XCTAssertEqual(text, "What is your favourite colour?")
            expectation.fulfill()
        }
        vm.input.ready?()
        self.waitForExpectations(timeout: 1)
    }
    
    func testAnswerPlaceholder() {
        let item = HelperTests.loadListFirt()
        let vm = SurveyCellViewModel(item: item, answered: nil)
        
        let expectation = self.expectation(description: "testAnswerPlaceholder")
        vm.output.answerPlaceholder = { text in
            XCTAssertEqual(text, "Type here for an answer...")
            expectation.fulfill()
        }
        vm.input.ready?()
        self.waitForExpectations(timeout: 1)
    }
    
    func testAnswerText() {
        let item = HelperTests.loadListFirt()
        let vm1 = SurveyCellViewModel(item: item, answered: nil)
        
        let expectation1 = self.expectation(description: "testAnswerText p1")
        vm1.output.answerText = { text in
            XCTAssertEqual(text, nil)
            expectation1.fulfill()
        }
        vm1.input.ready?()
        self.waitForExpectations(timeout: 1)
        
        
        let expectation2 = self.expectation(description: "testAnswerText p2")
        let vm2 = SurveyCellViewModel(item: item, answered: "answer1")
        vm2.output.answerText = { text in
            XCTAssertEqual(text, "answer1")
            expectation2.fulfill()
        }
        vm2.input.ready?()
        self.waitForExpectations(timeout: 1)
    }
    
    func testIsAnswerTextEnabled() {
        let item = HelperTests.loadListFirt()
        let vm1 = SurveyCellViewModel(item: item, answered: nil)
        
        let expectation1 = self.expectation(description: "testIsAnswerTextEnabled p1")
        vm1.output.isAnswerTextEnabled = { enabled in
            XCTAssertEqual(enabled, true)
            expectation1.fulfill()
        }
        vm1.input.ready?()
        self.waitForExpectations(timeout: 1)
        
        
        let expectation2 = self.expectation(description: "testIsAnswerTextEnabled p2")
        let vm2 = SurveyCellViewModel(item: item, answered: "answer1")
        vm2.output.isAnswerTextEnabled = { enabled in
            XCTAssertEqual(enabled, false)
            expectation2.fulfill()
        }
        vm2.input.ready?()
        self.waitForExpectations(timeout: 1)
    }
    
    func testSubmitButtonTitleEnabled() {
        let item = HelperTests.loadListFirt()
        let vm = SurveyCellViewModel(item: item, answered: nil)
        
        let expectation = self.expectation(description: "testSubmitButtonTitleEnabled")
        vm.output.submitButtonTitleEnabled = { text in
            XCTAssertEqual(text, "Submit")
            expectation.fulfill()
        }
        vm.input.ready?()
        self.waitForExpectations(timeout: 1)
    }
    
    func testSubmitButtonTitleDisabled() {
        let item = HelperTests.loadListFirt()
        let vm = SurveyCellViewModel(item: item, answered: nil)
        
        let expectation = self.expectation(description: "testSubmitButtonTitleDisabled")
        vm.output.submitButtonTitleDisabled = { text in
            XCTAssertEqual(text, "Already submitted")
            expectation.fulfill()
        }
        vm.input.ready?()
        self.waitForExpectations(timeout: 1)
    }
    
    func testIsSubmitButtonEnabled() {
        let item = HelperTests.loadListFirt()
        let vm1 = SurveyCellViewModel(item: item, answered: nil)
        
        let expectation1 = self.expectation(description: "testIsSubmitButtonEnabled p1")
        vm1.output.isSubmitButtonEnabled = { enabled in
            XCTAssertEqual(enabled, true)
            expectation1.fulfill()
        }
        vm1.input.ready?()
        self.waitForExpectations(timeout: 1)
        
        
        let expectation2 = self.expectation(description: "testIsSubmitButtonEnabled p2")
        let vm2 = SurveyCellViewModel(item: item, answered: "answer1")
        vm2.output.isSubmitButtonEnabled = { enabled in
            XCTAssertEqual(enabled, false)
            expectation2.fulfill()
        }
        vm2.input.ready?()
        self.waitForExpectations(timeout: 1)
    }
    
    func testSubmit() {
        let item = HelperTests.loadListFirt()
        let vm = SurveyCellViewModel(item: item, answered: nil)
        
        let expectation = self.expectation(description: "testSubmit")
        vm.output.submit = { element in
            XCTAssertEqual(element.item.id, 1)
            XCTAssertEqual(element.item.question, "What is your favourite colour?")
            XCTAssertEqual(element.answer, "Answer1")
            expectation.fulfill()
        }
        vm.input.submit?("Answer1")
        self.waitForExpectations(timeout: 1)
    }
    
    func testRetrySubmit() {
        let item = HelperTests.loadListFirt()
        let vm = SurveyCellViewModel(item: item, answered: nil)
        
        let expectation = self.expectation(description: "testRetrySubmit")
        vm.output.retrySubmit = {
            expectation.fulfill()
        }
        vm.input.retrySubmit?()
        self.waitForExpectations(timeout: 1)
    }
}
