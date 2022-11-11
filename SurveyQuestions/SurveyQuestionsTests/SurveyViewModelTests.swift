//  
//  SurveyViewModelTests.swift
//

import XCTest
@testable import SurveyQuestions

class SurveyViewModelTests: XCTestCase {
    
    func testTitle() {
        let bannerDuration: TimeInterval = 1
        let api = ApiServiceMock()
        let vm = SurveyViewModel(api: api, bannerDuration: bannerDuration)
        
        
        let expectation1 = self.expectation(description: "testTitle p1")
        expectation1.expectedFulfillmentCount = 2
        _ = api._getQuestions = { completion in
            completion(.failure(HelperTests.fakeError))
            return {}
        }
        vm.output.title = { title in
            XCTAssertEqual(title, "Question 0/0")
            expectation1.fulfill()
        }
        vm.input.ready?()
        self.waitForExpectations(timeout: 1)
        
        
        let expectation2 = self.expectation(description: "testTitle p2")
        expectation2.expectedFulfillmentCount = 2
        var count = 0
        _ = api._getQuestions = { completion in
            completion(.success(HelperTests.loadList()))
            return {}
        }
        vm.output.title = { title in
            count += 1
            if count == 1 {
                XCTAssertEqual(title, "Question 0/0")
            } else {
                XCTAssertEqual(title, "Question 1/10")
            }
            expectation2.fulfill()
        }
        vm.input.ready?()
        self.waitForExpectations(timeout: 1)
    }
    
    func testPreviousButtonTitle() {
        let bannerDuration: TimeInterval = 1
        let api = ApiServiceMock()
        _ = api._getQuestions = { completion in
            completion(.failure(HelperTests.fakeError))
            return {}
        }
        let vm = SurveyViewModel(api: api, bannerDuration: bannerDuration)
        
        
        let expectation = self.expectation(description: "testPreviousButtonTitle")
        vm.output.previousButtonTitle = { title in
            XCTAssertEqual(title, "Previous")
            expectation.fulfill()
        }
        vm.input.ready?()
        self.waitForExpectations(timeout: 1)
    }
    
    func testIsPreviousButtonEnabled() {
        let bannerDuration: TimeInterval = 1
        let api = ApiServiceMock()
        let vm = SurveyViewModel(api: api, bannerDuration: bannerDuration)
        
        
        let expectation1 = self.expectation(description: "testIsPreviousButtonEnabled p1")
        expectation1.expectedFulfillmentCount = 2
        _ = api._getQuestions = { completion in
            completion(.failure(HelperTests.fakeError))
            return {}
        }
        vm.output.isPreviousButtonEnabled = { enabled in
            XCTAssertEqual(enabled, false)
            expectation1.fulfill()
        }
        vm.input.ready?()
        self.waitForExpectations(timeout: 1)
        
        
        let expectation2 = self.expectation(description: "testIsPreviousButtonEnabled p2")
        expectation2.expectedFulfillmentCount = 2
        _ = api._getQuestions = { completion in
            completion(.success(HelperTests.loadList()))
            return {}
        }
        vm.output.isPreviousButtonEnabled = { enabled in
            XCTAssertEqual(enabled, false)
            expectation2.fulfill()
        }
        vm.input.ready?()
        self.waitForExpectations(timeout: 1)
    }
    
    func testNextButtonTitle() {
        let bannerDuration: TimeInterval = 1
        let api = ApiServiceMock()
        _ = api._getQuestions = { completion in
            completion(.failure(HelperTests.fakeError))
            return {}
        }
        let vm = SurveyViewModel(api: api, bannerDuration: bannerDuration)
        
        
        let expectation = self.expectation(description: "testNextButtonTitle")
        vm.output.nextButtonTitle = { title in
            XCTAssertEqual(title, "Next")
            expectation.fulfill()
        }
        vm.input.ready?()
        self.waitForExpectations(timeout: 1)
    }
    
    func testIsNextButtonEnabled() {
        let bannerDuration: TimeInterval = 1
        let api = ApiServiceMock()
        let vm = SurveyViewModel(api: api, bannerDuration: bannerDuration)
        
        
        let expectation1 = self.expectation(description: "testIsNextButtonEnabled p1")
        expectation1.expectedFulfillmentCount = 2
        _ = api._getQuestions = { completion in
            completion(.failure(HelperTests.fakeError))
            return {}
        }
        vm.output.isNextButtonEnabled = { enabled in
            XCTAssertEqual(enabled, false)
            expectation1.fulfill()
        }
        vm.input.ready?()
        self.waitForExpectations(timeout: 1)
        
        
        let expectation2 = self.expectation(description: "testIsNextButtonEnabled p2")
        expectation2.expectedFulfillmentCount = 2
        var count = 0
        _ = api._getQuestions = { completion in
            completion(.success(HelperTests.loadList()))
            return {}
        }
        vm.output.isNextButtonEnabled = { enabled in
            count += 1
            if count == 1 {
                XCTAssertEqual(enabled, false)
            } else {
                XCTAssertEqual(enabled, true)
            }
            expectation2.fulfill()
        }
        vm.input.ready?()
        self.waitForExpectations(timeout: 1)
    }
    
    func testSubmittedItemCount() {
        let bannerDuration: TimeInterval = 1
        let api = ApiServiceMock()
        _ = api._getQuestions = { completion in
            completion(.failure(HelperTests.fakeError))
            return {}
        }
        let vm = SurveyViewModel(api: api, bannerDuration: bannerDuration)
        
        
        let expectation = self.expectation(description: "testSubmittedItemCount")
        vm.output.submittedItemCount = { text in
            XCTAssertEqual(text, "Questions submitted 0")
            expectation.fulfill()
        }
        vm.input.ready?()
        self.waitForExpectations(timeout: 1)
    }
    
    func testIsLoading() {
        let bannerDuration: TimeInterval = 1
        let api = ApiServiceMock()
        _ = api._getQuestions = { completion in
            completion(.failure(HelperTests.fakeError))
            return {}
        }
        let vm = SurveyViewModel(api: api, bannerDuration: bannerDuration)
        var count = 0
        
        
        let expectation = self.expectation(description: "testIsLoading")
        expectation.expectedFulfillmentCount = 3
        vm.output.isLoading = { isLoading in
            count += 1
            if count == 1 {
                XCTAssertEqual(isLoading, false)
            } else if count == 2 {
                XCTAssertEqual(isLoading, true)
            } else {
                XCTAssertEqual(isLoading, false)
            }
            expectation.fulfill()
        }
        vm.input.ready?()
        self.waitForExpectations(timeout: 1)
    }
    
    func testError() {
        let bannerDuration: TimeInterval = 1
        let api = ApiServiceMock()
        _ = api._getQuestions = { completion in
            completion(.failure(HelperTests.fakeError))
            return {}
        }
        let vm = SurveyViewModel(api: api, bannerDuration: bannerDuration)
        
        
        let expectation = self.expectation(description: "testError")
        vm.output.error = { message in
            XCTAssertTrue(message.contains("FakeError"))
            expectation.fulfill()
        }
        vm.input.ready?()
        self.waitForExpectations(timeout: 1)
    }
    
    func testHideKeyboard() {
        let bannerDuration: TimeInterval = 1
        let api = ApiServiceMock()
        _ = api._getQuestions = { completion in
            completion(.success(HelperTests.loadList()))
            return {}
        }
        let vm = SurveyViewModel(api: api, bannerDuration: bannerDuration)
        
        
        let expectation1 = self.expectation(description: "testHideKeyboard p1")
        vm.output.addItems = { indexPaths in
            expectation1.fulfill()
        }
        vm.input.ready?()
        self.waitForExpectations(timeout: 1)
        
        
        let expectation2 = self.expectation(description: "testHideKeyboard p2")
        vm.output.hideKeyboard = {
            expectation2.fulfill()
        }
        vm.input.nextItem?()
        self.waitForExpectations(timeout: 1)
    }
    
    func testAddItems() {
        let bannerDuration: TimeInterval = 1
        let items = HelperTests.loadList()
        let api = ApiServiceMock()
        _ = api._getQuestions = { completion in
            completion(.success(items))
            return {}
        }
        let vm = SurveyViewModel(api: api, bannerDuration: bannerDuration)
        
        
        let expectation1 = self.expectation(description: "testAddItems")
        vm.output.addItems = { indexPaths in
            XCTAssertEqual(indexPaths.count, items.count)
            XCTAssertEqual(indexPaths.first!.item, 0)
            XCTAssertEqual(indexPaths.last!.item, 9)
            expectation1.fulfill()
        }
        vm.input.ready?()
        self.waitForExpectations(timeout: 1)
    }
    
    func testReloadItems() {
        let bannerDuration: TimeInterval = 1
        let api = ApiServiceMock()
        _ = api._getQuestions = { completion in
            completion(.success(HelperTests.loadList()))
            return {}
        }
        let vm = SurveyViewModel(api: api, bannerDuration: bannerDuration)
        
        
        let expectation1 = self.expectation(description: "testReloadItems p1")
        vm.output.addItems = { indexPaths in
            expectation1.fulfill()
        }
        vm.input.ready?()
        self.waitForExpectations(timeout: 1)
        
        
        let expectation2 = self.expectation(description: "testReloadItems p2")
        vm.output.reloadItems = { indexPaths in
            XCTAssertEqual(indexPaths.count, 1)
            XCTAssertEqual(indexPaths.first!.item, 1)
            expectation2.fulfill()
        }
        vm.input.nextItem?()
        self.waitForExpectations(timeout: 1)
    }
    
    func testMoveToItem() {
        let bannerDuration: TimeInterval = 1
        let api = ApiServiceMock()
        _ = api._getQuestions = { completion in
            completion(.success(HelperTests.loadList()))
            return {}
        }
        let vm = SurveyViewModel(api: api, bannerDuration: bannerDuration)
        
        
        let expectation1 = self.expectation(description: "testMoveToItem p1")
        vm.output.addItems = { indexPaths in
            expectation1.fulfill()
        }
        vm.input.ready?()
        self.waitForExpectations(timeout: 1)
        
        
        let expectation2 = self.expectation(description: "testMoveToItem p2")
        vm.output.moveToItem = { indexPath in
            XCTAssertEqual(indexPath.item, 1)
            expectation2.fulfill()
        }
        vm.input.nextItem?()
        self.waitForExpectations(timeout: 1)
    }
    
    func testSuccessBannerText() {
        let bannerDuration: TimeInterval = 1
        let api = ApiServiceMock()
        _ = api._getQuestions = { completion in
            completion(.failure(HelperTests.fakeError))
            return {}
        }
        let vm = SurveyViewModel(api: api, bannerDuration: bannerDuration)
        
        
        let expectation = self.expectation(description: "testSuccessBannerText")
        vm.output.successBannerText = { title in
            XCTAssertEqual(title, "Success!")
            expectation.fulfill()
        }
        vm.input.ready?()
        self.waitForExpectations(timeout: 1)
    }
    
    func testShowSuccessBanner() {
        let bannerDuration: TimeInterval = 1
        let api = ApiServiceMock()
        _ = api._getQuestions = { completion in
            completion(.success(HelperTests.loadList()))
            return {}
        }
        api._submitQuestion = {_, _, completion in
            completion(.success(()))
            return {}
        }
        let vm = SurveyViewModel(api: api, bannerDuration: bannerDuration)


        let expectation1 = self.expectation(description: "testShowSuccessBanner p1")
        vm.output.addItems = { indexPaths in
            expectation1.fulfill()
        }
        vm.input.ready?()
        self.waitForExpectations(timeout: 1)


        let expectation2 = self.expectation(description: "testShowSuccessBanner p2")
        vm.output.showSuccessBanner = {
            expectation2.fulfill()
        }
        
        vm.input.submit?(((item: QuestionList.Item(id: 1, question: "Question1"), answer: "Answer1")))
        self.waitForExpectations(timeout: 1)
    }
    
    func testFailureBannerText() {
        let bannerDuration: TimeInterval = 1
        let api = ApiServiceMock()
        _ = api._getQuestions = { completion in
            completion(.failure(HelperTests.fakeError))
            return {}
        }
        let vm = SurveyViewModel(api: api, bannerDuration: bannerDuration)
        
        
        let expectation = self.expectation(description: "testFailureBannerText")
        vm.output.failureBannerText = { title in
            XCTAssertEqual(title, "Failure!")
            expectation.fulfill()
        }
        vm.input.ready?()
        self.waitForExpectations(timeout: 1)
    }
    
    func testFailureRetryButtonTitle() {
        let bannerDuration: TimeInterval = 1
        let api = ApiServiceMock()
        _ = api._getQuestions = { completion in
            completion(.failure(HelperTests.fakeError))
            return {}
        }
        let vm = SurveyViewModel(api: api, bannerDuration: bannerDuration)
        
        
        let expectation = self.expectation(description: "testFailureRetryButtonTitle")
        vm.output.failureRetryButtonTitle = { title in
            XCTAssertEqual(title, "Retry")
            expectation.fulfill()
        }
        vm.input.ready?()
        self.waitForExpectations(timeout: 1)
    }
    
    func testShowFailureBanner() {
        let bannerDuration: TimeInterval = 1
        let api = ApiServiceMock()
        _ = api._getQuestions = { completion in
            completion(.success(HelperTests.loadList()))
            return {}
        }
        api._submitQuestion = {_, _, completion in
            completion(.failure(HelperTests.fakeError))
            return {}
        }
        let vm = SurveyViewModel(api: api, bannerDuration: bannerDuration)


        let expectation1 = self.expectation(description: "testShowFailureBanner p1")
        vm.output.addItems = { indexPaths in
            expectation1.fulfill()
        }
        vm.input.ready?()
        self.waitForExpectations(timeout: 1)


        let expectation2 = self.expectation(description: "testShowFailureBanner p2")
        vm.output.showFailureBanner = {
            expectation2.fulfill()
        }
        
        vm.input.submit?(((item: QuestionList.Item(id: 1, question: "Question1"), answer: "Answer1")))
        self.waitForExpectations(timeout: 1)
    }
    
    func testHideAllBanner() {
        let bannerDuration: TimeInterval = 1
        let api = ApiServiceMock()
        _ = api._getQuestions = { completion in
            completion(.failure(HelperTests.fakeError))
            return {}
        }
        let vm = SurveyViewModel(api: api, bannerDuration: bannerDuration)
        
        
        let expectation = self.expectation(description: "testFailureRetryButtonTitle")
        vm.output.hideAllBanner = {
            expectation.fulfill()
        }
        vm.input.ready?()
        self.waitForExpectations(timeout: 1)
    }
}
