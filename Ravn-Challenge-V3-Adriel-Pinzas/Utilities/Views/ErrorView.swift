//
//  ErrorView.swift
//  Ravn-Challenge-V3-Adriel-Pinzas
//
//  Created by Adriel Pinzas on 4/12/23.
//

import Foundation
import UIKit

protocol ErrorProtocol: AnyObject {
    var errorView: ErrorView { get }
    func startError(with message: String?)
    func stopError()
}

extension ErrorProtocol where Self: UIViewController {
    func startError(with message: String?) {
        errorView.configure(errorMessage: message)
        errorView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(errorView)
        
        NSLayoutConstraint.activate([
            errorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            errorView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    func stopError() {
        errorView.removeFromSuperview()
    }
}

final class ErrorView: UIView {
    var onTryAgainDidPressed: (() -> Void)?

    private lazy var emptyImageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "empty-image"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()

    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setUpContainerView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(errorMessage: String?) {
        messageLabel.text = errorMessage
    }

    private func setUpContainerView() {
        addSubview(emptyImageView)
        addSubview(messageLabel)
        
        NSLayoutConstraint.activate([
            emptyImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            emptyImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -30),
            
            messageLabel.topAnchor.constraint(equalTo: emptyImageView.bottomAnchor, constant: 10),
            messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
        ])
    }
    
    @objc private func tryAgain() {
        onTryAgainDidPressed?()
    }
}
