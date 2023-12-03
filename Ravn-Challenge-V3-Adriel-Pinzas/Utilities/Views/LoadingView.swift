//
//  LoadingView.swift
//  Ravn-Challenge-V3-Adriel-Pinzas
//
//  Created by Adriel Pinzas on 2/12/23.
//

import UIKit

protocol LoadingProtocol: AnyObject {
    var loadingView: LoadingView { get }
    func startLoading()
    func stopLoading()
}

extension LoadingProtocol where Self: UIViewController {
    func startLoading() {
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loadingView)
        NSLayoutConstraint.activate([
            loadingView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        loadingView.loader.startAnimating()
    }

    func stopLoading() {
        loadingView.loader.stopAnimating()
        loadingView.removeFromSuperview()
    }
}

class LoadingView: UIView {
    lazy var loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView()
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.style = .large
        return loader
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = UIColor.white
        self.clipsToBounds = true
        self.layer.cornerRadius = 5
        setupActivityControl()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Error - Container Loader")
    }

    fileprivate func setupActivityControl() {
        addSubview(loader)
        NSLayoutConstraint.activate([
            loader.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
