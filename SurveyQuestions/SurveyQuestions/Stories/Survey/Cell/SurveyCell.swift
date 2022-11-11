//  
//  SurveyCell.swift
//

import Foundation
import UIKit

final class SurveyCell: UICollectionViewCell {
    private lazy var containerView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Resources.UI.Colors.colorCBCBCB
        return view
    }()
    
    private lazy var questionLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.numberOfLines = 1
        view.textAlignment = .left
        view.font = Resources.UI.Fonts.systemRegular(size: 14)
        view.textColor = Resources.UI.Colors.color000000
        return view
    }()
    
    private lazy var answerTextField: UITextField = {
        let view = UITextField(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.font = Resources.UI.Fonts.systemRegular(size: 14)
        view.textColor = Resources.UI.Colors.color000000
        return view
    }()
    
    private lazy var submitButton: UIButton = {
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
    
    private var viewModel: SurveyCellViewModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(viewModel: SurveyCellViewModel) {
        self.viewModel = viewModel
        self.setupBindings()
        self.viewModel?.input.ready?()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.viewModel?.input.reset?()
    }
}

private extension SurveyCell {
    func setupUI() {
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        
        self.contentView.addSubview(self.containerView)
        NSLayoutConstraint.activate([
            self.containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
        
        self.containerView.addSubview(self.questionLabel)
        NSLayoutConstraint.activate([
            self.questionLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 16),
            self.questionLabel.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 32),
            self.questionLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -16),
            self.questionLabel.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        self.containerView.addSubview(self.answerTextField)
        NSLayoutConstraint.activate([
            self.answerTextField.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 16),
            self.answerTextField.topAnchor.constraint(equalTo: self.questionLabel.bottomAnchor, constant: 32),
            self.answerTextField.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -16),
            self.answerTextField.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        self.containerView.addSubview(self.submitButton)
        NSLayoutConstraint.activate([
            self.submitButton.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 16),
            self.submitButton.topAnchor.constraint(equalTo: self.answerTextField.bottomAnchor, constant: 32),
            self.submitButton.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -16),
            self.submitButton.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        self.submitButton.addAction { [weak self] in
            self?.viewModel?.input.submit?(self?.answerTextField.text)
        }
    }
    
    func setupBindings() {
        self.viewModel?.output.reset = Self.bindOnMain { [weak self] in
            self?.questionLabel.text = nil
            self?.answerTextField.placeholder = nil
            self?.answerTextField.text = nil
            self?.submitButton.isEnabled = false
            self?.submitButton.setTitle(nil, for: .normal)
            self?.submitButton.setTitle(nil, for: .disabled)
            
            self?.setNeedsLayout()
            self?.setNeedsDisplay()
        }
        
        self.viewModel?.output.questionText = Self.bindOnMain { [weak self] text in
            self?.questionLabel.text = text
            
            self?.setNeedsLayout()
            self?.setNeedsDisplay()
        }
        
        self.viewModel?.output.answerPlaceholder = Self.bindOnMain { [weak self] text in
            self?.answerTextField.placeholder = text
            
            self?.setNeedsLayout()
            self?.setNeedsDisplay()
        }
        
        self.viewModel?.output.answerText = Self.bindOnMain { [weak self] text in
            self?.answerTextField.text = text
            
            self?.setNeedsLayout()
            self?.setNeedsDisplay()
        }
        
        self.viewModel?.output.isAnswerTextEnabled = Self.bindOnMain { [weak self] enabled in
            self?.answerTextField.isEnabled = enabled
            
            self?.setNeedsLayout()
            self?.setNeedsDisplay()
        }
        
        self.viewModel?.output.submitButtonTitleEnabled = Self.bindOnMain { [weak self] text in
            self?.submitButton.setTitle(text, for: .normal)
            
            self?.setNeedsLayout()
            self?.setNeedsDisplay()
        }
        
        self.viewModel?.output.submitButtonTitleDisabled = Self.bindOnMain { [weak self] text in
            self?.submitButton.setTitle(text, for: .disabled)
            
            self?.setNeedsLayout()
            self?.setNeedsDisplay()
        }
        
        self.viewModel?.output.isSubmitButtonEnabled = Self.bindOnMain { [weak self] enabled in
            self?.submitButton.isEnabled = enabled
            
            self?.setNeedsLayout()
            self?.setNeedsDisplay()
        }
        
        self.viewModel?.output.retrySubmit = Self.bindOnMain { [weak self] in
            self?.viewModel?.input.submit?(self?.answerTextField.text)
        }
    }
}
