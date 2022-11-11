//  
//  SurveyDatasourceProviderProtocol.swift
//

import Foundation

protocol SurveyDatasourceProviderProtocol {
    var itemsCount: Int { get }
    func itemViewModel(index: Int) -> SurveyCellViewModel
}
