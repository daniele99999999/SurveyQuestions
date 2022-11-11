//  
//  SurveyViewController.swift
//

import Foundation
import UIKit

final class SurveyViewController: UIViewController {
    let rootView = SurveyView()
    
    private lazy var previousItemButton: UIBarButtonItem = {
        let item = UIBarButtonItem()
        item.tintColor = Resources.UI.Colors.color000000
        item.title = nil
        item.image = nil
        return item
    }()
    
    private lazy var nextItemButton: UIBarButtonItem = {
        let item = UIBarButtonItem()
        item.tintColor = Resources.UI.Colors.color000000
        item.title = nil
        item.image = nil
        return item
    }()
    
    private (set) var viewModel: SurveyViewModel
    private (set) var dataSource: SurveyDatasource

    init(viewModel: SurveyViewModel) {
        self.viewModel = viewModel
        self.dataSource = SurveyDatasource(provider: viewModel)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = self.rootView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        self.setupBindings()
        
        self.viewModel.input.ready?()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.showBackArrowOnly()
    }
}

private extension SurveyViewController {
    func setupUI() {
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.rightBarButtonItems = [
            self.nextItemButton,
            self.previousItemButton
        ]
        
        self.previousItemButton.addAction { [weak self] in
            self?.viewModel.input.previousItem?()
        }
        
        self.nextItemButton.addAction { [weak self] in
            self?.viewModel.input.nextItem?()
        }
        
        self.rootView.failureView.retryButton.addAction { [weak self] in
            self?.viewModel.input.retrySubmit?()
        }
        
        self.rootView.setCollectionView(delegate: self, dataSource: self.dataSource)
    }
    
    func setupBindings() {
        self.viewModel.output.title = Self.bindOnMain { [weak self] title in
            self?.title = title
        }
        
        self.viewModel.output.previousButtonTitle = Self.bindOnMain { [weak self] title in
            self?.previousItemButton.title = title
        }
        
        self.viewModel.output.isPreviousButtonEnabled = Self.bindOnMain { [weak self] isEnabled in
            self?.previousItemButton.isEnabled = isEnabled
        }
        
        self.viewModel.output.nextButtonTitle = Self.bindOnMain { [weak self] title in
            self?.nextItemButton.title = title
        }
        
        self.viewModel.output.isNextButtonEnabled = Self.bindOnMain { [weak self] isEnabled in
            self?.nextItemButton.isEnabled = isEnabled
        }
        
        self.viewModel.output.submittedItemCount = Self.bindOnMain { [weak self] text in
            self?.rootView.updateCounterLabel(text: text)
        }
        
        self.viewModel.output.isLoading = Self.bindOnMain { [weak self] isLoading in
            if isLoading {
                self?.rootView.startLoader()
            } else {
                self?.rootView.stopLoader()
            }
        }

        self.viewModel.output.error = Self.bindOnMain { error in
            // TODO handle error on screen
            print("Unhandled error: \(error)")
        }
        
        self.viewModel.output.addItems = Self.bindOnMain { [weak self] indexPaths in
            self?.rootView.addItems(indexPaths: indexPaths)
        }
        
        self.viewModel.output.reloadItems = Self.bindOnMain { [weak self] indexPaths in
            self?.rootView.reloadItems(indexPaths: indexPaths)
        }
        
        self.viewModel.output.moveToItem = Self.bindOnMain { [weak self] indexPath in
            self?.rootView.scrollToItem(indexPath: indexPath)
        }
        
        self.viewModel.output.hideKeyboard = Self.bindOnMain { [weak self] in
            self?.rootView.endEditing(true)
        }
        
        self.viewModel.output.successBannerText = Self.bindOnMain { [weak self] text in
            self?.rootView.updateSuccessBanner(text: text)
        }
        
        self.viewModel.output.showSuccessBanner = Self.bindOnMain { [weak self] in
            self?.rootView.showSuccessBannerView()
        }
        
        self.viewModel.output.failureBannerText = Self.bindOnMain { [weak self] text in
            self?.rootView.updateFailureBanner(text: text)
        }
        
        self.viewModel.output.failureRetryButtonTitle = Self.bindOnMain { [weak self] title in
            self?.rootView.updateFailureRetry(title: title)
        }
        
        self.viewModel.output.showFailureBanner = Self.bindOnMain { [weak self] in
            self?.rootView.showFailureBannerView()
        }
        
        self.viewModel.output.hideAllBanner = Self.bindOnMain { [weak self] in
            self?.rootView.hideAllBannerView()
        }
    }
}

extension SurveyViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.rootView.itemSize
    }
}
