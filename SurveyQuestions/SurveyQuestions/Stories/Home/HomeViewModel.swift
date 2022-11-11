//  
//  HomeViewModel.swift
//

import Foundation

final class HomeViewModel {
    let input = Input()
    let output = Output()
    
    init() {
        self.input.ready = self.ready
        self.input.startSurvey = self.selectedSurvey
    }
}

private extension HomeViewModel {
    func ready() {
        self.output.title?("Welcome")
        self.output.surveyButtonTitle?("Start Survey")
    }
    
    func selectedSurvey() {
        self.output.startSurvey?()
    }
}

extension HomeViewModel {
    class Input {
        var ready: VoidClosure?
        var startSurvey: VoidClosure?
    }
    
    class Output {
        var title: VoidOutputClosure<String>?
        var surveyButtonTitle: VoidOutputClosure<String>?
        var startSurvey: VoidClosure?
    }
}

