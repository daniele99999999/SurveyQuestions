//  
//  HomeView.swift
//

import Foundation
import UIKit

final class HomeView: UIView {
    private lazy var contentView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Resources.UI.Colors.colorCBCBCB
        return view
    }()
    
    lazy var surveyButton: UIButton = {
        let view = UIButton(type: .system)
        view.backgroundColor = Resources.UI.Colors.colorFFFFFF
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel?.font = Resources.UI.Fonts.systemRegular(size: 20)
        view.setTitle(nil, for: .normal)
        view.setTitleColor(Resources.UI.Colors.color000000, for: .normal)
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
        self.backgroundColor = .clear
        
        self.addSubview(self.contentView)
        NSLayoutConstraint.activate([
            self.contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.contentView.topAnchor.constraint(equalTo: self.topAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        self.contentView.addSubview(self.surveyButton)
        NSLayoutConstraint.activate([
            self.surveyButton.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.surveyButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            self.surveyButton.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.surveyButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
}

extension HomeView {
    func updateSurveyButton(title: String) {
        self.surveyButton.setTitle(title, for: .normal)
    }
}


