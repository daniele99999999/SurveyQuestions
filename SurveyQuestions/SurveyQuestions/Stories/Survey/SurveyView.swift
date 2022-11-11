//  
//  SurveyView.swift
//

import Foundation
import UIKit

final class SurveyView: UIView {
    private lazy var contentView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Resources.UI.Colors.color000000
        return view
    }()
    
    private lazy var loaderView: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView(style: .medium)
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.backgroundColor = Resources.UI.Colors.color000000.withAlphaComponent(0.25)
        loader.tintColor = Resources.UI.Colors.color000000
        loader.stopAnimating()
        return loader
    }()
    
    private lazy var counterLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.numberOfLines = 1
        view.textAlignment = .center
        view.font = Resources.UI.Fonts.systemRegular(size: 14)
        view.textColor = Resources.UI.Colors.colorFFFFFF
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.estimatedItemSize = .zero
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Resources.UI.Colors.colorCBCBCB
        view.registerCell(className: SurveyCell.self)
        view.contentInset = .zero
        view.isPagingEnabled = true
        view.isScrollEnabled = false
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    lazy var successView: SuccessView = {
        let view = SuccessView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    lazy var failureView: FailureView = {
        let view = FailureView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()

    init() {
        super.init(frame: .zero)
        self.setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        self.backgroundColor = .clear
        
        self.addSubview(self.contentView)
        NSLayoutConstraint.activate([
            self.contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.contentView.topAnchor.constraint(equalTo: self.topAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        self.contentView.addSubview(self.counterLabel)
        NSLayoutConstraint.activate([
            self.counterLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.counterLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.counterLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.counterLabel.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        self.contentView.addSubview(self.collectionView)
        NSLayoutConstraint.activate([
            self.collectionView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.collectionView.topAnchor.constraint(equalTo: self.counterLabel.bottomAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
        
        self.contentView.addSubview(self.successView)
        NSLayoutConstraint.activate([
            self.successView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.successView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.successView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.successView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
        
        self.contentView.addSubview(self.failureView)
        NSLayoutConstraint.activate([
            self.failureView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.failureView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.failureView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.failureView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
        
        self.contentView.addSubview(self.loaderView)
        NSLayoutConstraint.activate([
            self.loaderView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.loaderView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.loaderView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.loaderView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
    }
}

extension SurveyView {
    var itemSize: CGSize {
        return self.collectionView.bounds.size
    }
    
    func startLoader() {
        self.loaderView.startAnimating()
        self.loaderView.isHidden = false
    }
    
    func stopLoader() {
        self.loaderView.stopAnimating()
        self.loaderView.isHidden = true
    }
    
    func updateCounterLabel(text: String?) {
        self.counterLabel.text = text
    }
    
    func setCollectionView(delegate: UICollectionViewDelegateFlowLayout, dataSource: UICollectionViewDataSource) {
        self.collectionView.delegate = delegate
        self.collectionView.dataSource = dataSource
    }

    func reloadItems(indexPaths: [IndexPath]) {
        self.collectionView.reloadItems(at: indexPaths)
    }
    
    func addItems(indexPaths: [IndexPath]) {
        self.collectionView.performBatchUpdates {
            self.collectionView.insertItems(at: indexPaths)
        }
    }
    
    func scrollToItem(indexPath: IndexPath) {
        self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
    }
}

extension SurveyView {
    final class SuccessView: UIView {
        private lazy var contentView: UIView = {
            let view = UIView(frame: .zero)
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = Resources.UI.Colors.color1BCB93
            return view
        }()
        
        lazy var textLabel: UILabel = {
            let view = UILabel(frame: .zero)
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .clear
            view.numberOfLines = 1
            view.textAlignment = .left
            view.font = Resources.UI.Fonts.systemRegular(size: 16)
            view.textColor = Resources.UI.Colors.color000000
            return view
        }()
        
        init() {
            super.init(frame: .zero)
            self.setupUI()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func setupUI() {
            self.backgroundColor = Resources.UI.Colors.color000000.withAlphaComponent(0.25)
            
            self.addSubview(self.contentView)
            NSLayoutConstraint.activate([
                self.contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                self.contentView.topAnchor.constraint(equalTo: self.topAnchor),
                self.contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                self.contentView.heightAnchor.constraint(equalToConstant: 100)
            ])
            
            self.contentView.addSubview(self.textLabel)
            NSLayoutConstraint.activate([
                self.textLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
                self.textLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
                self.textLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0),
                self.textLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.5)
            ])
        }
    }
}

extension SurveyView {
    final class FailureView: UIView {
        private lazy var contentView: UIView = {
            let view = UIView(frame: .zero)
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = Resources.UI.Colors.colorFF6B53
            return view
        }()
        
        lazy var textLabel: UILabel = {
            let view = UILabel(frame: .zero)
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .clear
            view.numberOfLines = 1
            view.textAlignment = .left
            view.font = Resources.UI.Fonts.systemRegular(size: 16)
            view.textColor = Resources.UI.Colors.color000000
            return view
        }()
        
        lazy var retryButton: UIButton = {
            let view = UIButton(type: .system)
            view.backgroundColor = Resources.UI.Colors.colorFFFFFF
            view.translatesAutoresizingMaskIntoConstraints = false
            view.titleLabel?.font = Resources.UI.Fonts.systemRegular(size: 20)
            view.setTitle(nil, for: .normal)
            view.tintColor = Resources.UI.Colors.color000000
            view.layer.cornerRadius = 8
            view.layer.masksToBounds = true
            return view
        }()
        
        init() {
            super.init(frame: .zero)
            self.setupUI()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func setupUI() {
            self.backgroundColor = Resources.UI.Colors.color000000.withAlphaComponent(0.25)
            
            self.addSubview(self.contentView)
            NSLayoutConstraint.activate([
                self.contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                self.contentView.topAnchor.constraint(equalTo: self.topAnchor),
                self.contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                self.contentView.heightAnchor.constraint(equalToConstant: 100)
            ])
            
            self.contentView.addSubview(self.textLabel)
            NSLayoutConstraint.activate([
                self.textLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
                self.textLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
                self.textLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0),
                self.textLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.5)
            ])
            
            self.contentView.addSubview(self.retryButton)
            NSLayoutConstraint.activate([
                self.retryButton.leadingAnchor.constraint(equalTo: self.textLabel.trailingAnchor, constant: 0),
                self.retryButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
                self.retryButton.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
                self.retryButton.heightAnchor.constraint(equalToConstant: 48)
            ])
        }
    }
}

extension SurveyView {
    func updateSuccessBanner(text: String) {
        self.successView.textLabel.text = text
    }
    
    func updateFailureBanner(text: String) {
        self.failureView.textLabel.text = text
    }
    
    func updateFailureRetry(title: String) {
        self.failureView.retryButton.setTitle(title, for: .normal)
    }
    
    func showSuccessBannerView() {
        self.successView.isHidden = false
        self.failureView.isHidden = true
    }
    
    func showFailureBannerView() {
        self.successView.isHidden = true
        self.failureView.isHidden = false
    }
    
    func hideAllBannerView() {
        self.successView.isHidden = true
        self.failureView.isHidden = true
    }
}
