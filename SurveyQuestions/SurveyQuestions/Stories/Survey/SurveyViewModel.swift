//  
//  SurveyViewModel.swift
//

import Foundation

final class SurveyViewModel {
    let input = Input()
    let output = Output()
    
    private let api: APIProtocol
    private let bannerDuration: TimeInterval
    
    private var currentItemIndex: Int?
    private var cellViewModelList: [SurveyCellViewModel] = []
    private var submittedItems: [Int: String] = [:]
    private var dismissBannerWorkItem: DispatchWorkItem?
    
    init(api: APIProtocol, bannerDuration: TimeInterval) {
        self.api = api
        self.bannerDuration = bannerDuration
        
        self.input.ready = self.ready
        self.input.nextItem = self.nextItem
        self.input.previousItem = self.previousItem
        self.input.submit = self.submit
        self.input.retrySubmit = self.retrySubmit
    }
}

private extension SurveyViewModel {
    func ready() {
        self.output.previousButtonTitle?("Previous")
        self.output.nextButtonTitle?("Next")
        self.output.isLoading?(false)
        self.output.successBannerText?("Success!")
        self.output.failureBannerText?("Failure!")
        self.output.failureRetryButtonTitle?("Retry")
        self.output.hideAllBanner?()
        self.updateTitle()
        self.updateNavigationButtons()
        self.updateSubmittedCount()
        self.fetchItems()
    }
    
    func nextItem() {
        let newItemIndex = (self.currentItemIndex ?? 0) + 1
        self.currentItemIndex = newItemIndex
        self.updateTitle()
        self.updateNavigationButtons()
        self.output.hideAllBanner?()
        self.output.hideKeyboard?()
        self.output.reloadItems?([IndexPath(item: newItemIndex, section: 0)])
        self.output.moveToItem?(IndexPath(item: newItemIndex, section: 0))
    }
    
    func previousItem() {
        let newItemIndex = (self.currentItemIndex ?? 0) - 1
        self.currentItemIndex = newItemIndex
        self.updateTitle()
        self.updateNavigationButtons()
        self.output.hideAllBanner?()
        self.output.hideKeyboard?()
        self.output.reloadItems?([IndexPath(item: newItemIndex, section: 0)])
        self.output.moveToItem?(IndexPath(item: newItemIndex, section: 0))
    }
    
    func submit(fromCell: (item: QuestionList.Item, answer: String)) {
        self.submit(item: fromCell.item, answer: fromCell.answer)
    }
    
    func retrySubmit() {
        // TODO handle no answer with a user feedback)
        guard let currentItemIndex = self.currentItemIndex else { return }
        
        self.dismissBannerWorkItem?.cancel()
        self.output.hideAllBanner?()
        self.updateNavigationButtons()
        
        self.cellViewModelList[currentItemIndex].input.retrySubmit?()
    }
}

private extension SurveyViewModel {
    func fetchItems() {
        self.output.isLoading?(true)
        _ = self.api.getQuestions() { [weak self] result in
            guard let self = self else { return }
            defer { self.output.isLoading?(false) }
            
            switch result {
            case .success(let itemList):
                let indexPaths = (0..<itemList.count).map { IndexPath(item: $0, section: 0) }
                self.cellViewModelList = self.cellViewModelList(from: itemList)
                self.currentItemIndex = 0
                self.output.addItems?(indexPaths)
            case .failure(let error):
                self.currentItemIndex = nil
                self.output.error?(error.localizedDescription)
            }
            
            self.updateTitle()
            self.updateNavigationButtons()
        }
    }
    
    func submit(item: QuestionList.Item, answer: String) {
        guard let currentItemIndex = self.currentItemIndex else { return }
        
        self.output.isLoading?(true)
        _ = self.api.submitQuestion(questionId: item.id, questionValue: answer) { [weak self] result in
            defer { self?.output.isLoading?(false) }
            
            switch result {
            case .success(_):
                self?.submittedItems[item.id] = answer
                self?.updateSubmittedCount()
                self?.updateCellViewModelList(item: item, answer: answer)
                self?.output.reloadItems?([IndexPath(item: currentItemIndex, section: 0)])
                self?.output.showSuccessBanner?()
                self?.dismissBannerWorkItem = self?.manageBanner()
            case .failure(_):
                self?.output.showFailureBanner?()
                self?.dismissBannerWorkItem = self?.manageBanner()
            }
        }
    }
    
    func manageBanner() -> DispatchWorkItem {
        self.output.isPreviousButtonEnabled?(false)
        self.output.isNextButtonEnabled?(false)
        
        let workItem = DispatchWorkItem { [weak self] in
            self?.output.hideAllBanner?()
            self?.updateNavigationButtons()
            self?.dismissBannerWorkItem = nil
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + self.bannerDuration, execute: workItem)
        return workItem
    }
    
    func updateNavigationButtons() {
        self.output.isPreviousButtonEnabled?((self.currentItemIndex ?? 0) > 0)
        self.output.isNextButtonEnabled?((self.currentItemIndex ?? 0) < (self.itemsCount-1))
    }
    
    func updateTitle() {
        let firstValue = self.currentItemIndex == nil ? 0 : self.currentItemIndex! + 1
        let lastValue = self.cellViewModelList.count
        self.output.title?("Question \(firstValue)/\(lastValue)")
    }
    
    func updateSubmittedCount() {
        self.output.submittedItemCount?("Questions submitted \(self.submittedItems.count)")
    }
    
    func cellViewModelList(from itemList: [QuestionList.Item]) -> [SurveyCellViewModel] {
        return itemList.map{
            let vm = SurveyCellViewModel(item: $0, answered: self.submittedItems[$0.id])
            vm.output.submit = { [weak self] item in
                self?.input.submit?((item: item.item, answer: item.answer))
            }
            return vm
        }
    }
    
    func updateCellViewModelList(item: QuestionList.Item, answer: String) {
        guard let currentItemIndex = self.currentItemIndex else { return }
        self.cellViewModelList[currentItemIndex] = SurveyCellViewModel(item: item, answered: answer)
    }
}

extension SurveyViewModel: SurveyDatasourceProviderProtocol {
    var itemsCount: Int {
        return self.cellViewModelList.count
    }
    
    func itemViewModel(index: Int) -> SurveyCellViewModel {
        return self.cellViewModelList[index]
    }
}

extension SurveyViewModel {
    class Input {
        var ready: VoidClosure?
        var nextItem: VoidClosure?
        var previousItem: VoidClosure?
        var submit: VoidOutputClosure<(item: QuestionList.Item, answer: String)>?
        var retrySubmit: VoidClosure?
    }
    
    class Output {
        var title: VoidOutputClosure<String>?
        var previousButtonTitle: VoidOutputClosure<String>?
        var isPreviousButtonEnabled: VoidOutputClosure<Bool>?
        var nextButtonTitle: VoidOutputClosure<String>?
        var isNextButtonEnabled: VoidOutputClosure<Bool>?
        var submittedItemCount: VoidOutputClosure<String>?
        var isLoading: VoidOutputClosure<Bool>?
        var error: VoidOutputClosure<String>?
        var hideKeyboard: VoidClosure?
        
        var addItems: VoidOutputClosure<[IndexPath]>?
        var reloadItems: VoidOutputClosure<[IndexPath]>?
        var moveToItem: VoidOutputClosure<IndexPath>?
        
        var successBannerText: VoidOutputClosure<String>?
        var showSuccessBanner: VoidClosure?
        var failureBannerText: VoidOutputClosure<String>?
        var failureRetryButtonTitle: VoidOutputClosure<String>?
        var showFailureBanner: VoidClosure?
        var hideAllBanner: VoidClosure?
    }
}
