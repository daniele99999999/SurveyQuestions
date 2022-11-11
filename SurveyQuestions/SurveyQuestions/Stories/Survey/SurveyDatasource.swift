//  
//  SurveyDatasource.swift
//

import Foundation
import UIKit

final class SurveyDatasource: NSObject {
    private let provider: SurveyDatasourceProviderProtocol
    
    init(provider: SurveyDatasourceProviderProtocol) {
        self.provider = provider
    }
}

extension SurveyDatasource: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.provider.itemsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(className: SurveyCell.self, indexPath: indexPath)
        let cellViewModel = self.provider.itemViewModel(index: indexPath.row)
        cell.set(viewModel: cellViewModel)
        return cell
    }
}
