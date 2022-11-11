//  
//  HomeViewController.swift
//

import Foundation
import UIKit

final class HomeViewController: UIViewController {
    let rootView = HomeView()
    
    private (set) var viewModel: HomeViewModel

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
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

private extension HomeViewController {
    func setupUI() {
        self.navigationController?.navigationBar.isTranslucent = false
        
        self.rootView.surveyButton.addAction { [weak self] in
            self?.viewModel.input.startSurvey?()
        }
    }
    
    func setupBindings() {
        self.viewModel.output.title = Self.bindOnMain { [weak self] title in
            self?.title = title
        }
        
        self.viewModel.output.surveyButtonTitle = Self.bindOnMain { [weak self] title in
            self?.rootView.updateSurveyButton(title: title)
        }
    }
}
