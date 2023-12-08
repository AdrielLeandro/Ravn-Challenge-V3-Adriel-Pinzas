//
//  EmptyView.swift
//  Ravn-Challenge-V3-Adriel-Pinzas
//
//  Created by Adriel Pinzas on 3/12/23.
//

import UIKit

protocol EmptyProtocol: AnyObject {
    var emptyView: EmptyView { get }
    func startEmptyView()
    func stopEmptyView()
}

extension EmptyProtocol where Self: UIViewController {
    func startEmptyView() {
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emptyView)
        
        NSLayoutConstraint.activate([
            emptyView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            emptyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emptyView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }

    func stopEmptyView() {
        emptyView.removeFromSuperview()
    }
}

final class EmptyView: UIView {
    lazy var emptyImageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "emptyImage"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()

    var messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16)
        label.text = "emptyView.message".localized
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


    private func setUpContainerView() {
        addSubview(emptyImageView)
        addSubview(messageLabel)
        NSLayoutConstraint.activate([
            emptyImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            emptyImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -30),
            emptyImageView.heightAnchor.constraint(equalToConstant: 100),
            emptyImageView.widthAnchor.constraint(equalToConstant: 100),

            messageLabel.topAnchor.constraint(equalTo: emptyImageView.bottomAnchor, constant: 10),
            messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
