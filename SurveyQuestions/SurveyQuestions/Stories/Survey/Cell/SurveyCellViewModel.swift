//  
//  SurveyCellViewModel.swift
//

import Foundation

final class SurveyCellViewModel {
    let input = Input()
    let output = Output()
    
    private let item: QuestionList.Item
    private let answered: String?
    
    init(item: QuestionList.Item, answered: String?) {
        self.item = item
        self.answered = answered
        
        self.input.ready = self.ready
        self.input.reset = self.reset
        self.input.submit = self.submit(answer:)
        self.input.retrySubmit = self.retrySubmit
    }
}

private extension SurveyCellViewModel {
    func ready() {
        self.output.questionText?(self.item.question)
        self.output.answerPlaceholder?("Type here for an answer...")
        self.output.answerText?(self.answered)
        self.output.isAnswerTextEnabled?(self.answered == nil)
        self.output.submitButtonTitleEnabled?("Submit")
        self.output.submitButtonTitleDisabled?("Already submitted")
        self.output.isSubmitButtonEnabled?(self.answered == nil)
    }
    
    func reset() {
        self.output.reset?()
    }
    
    func submit(answer: String?) {
        // TODO handle no answer with a user feedback
        guard let answer = answer else { return }
        if answer.isEmpty { return }
        
        self.output.submit?((item: self.item, answer: answer))
    }
    
    func retrySubmit() {
        self.output.retrySubmit?()
    }
}

extension SurveyCellViewModel {
    class Input {
        var ready: VoidClosure?
        var reset: VoidClosure?
        var submit: VoidOutputClosure<String?>?
        var retrySubmit: VoidClosure?
    }
    
    class Output {
        var reset: VoidClosure?
        var questionText: VoidOutputClosure<String>?
        var answerPlaceholder: VoidOutputClosure<String>?
        var answerText: VoidOutputClosure<String?>?
        var isAnswerTextEnabled: VoidOutputClosure<Bool>?
        var submitButtonTitleEnabled: VoidOutputClosure<String>?
        var submitButtonTitleDisabled: VoidOutputClosure<String>?
        var isSubmitButtonEnabled: VoidOutputClosure<Bool>?
        var submit: VoidOutputClosure<(item: QuestionList.Item, answer: String)>?
        var retrySubmit: VoidClosure?
    }
}
