//
//  HomeViewController.swift
//  Ravn-Challenge-V3-Adriel-Pinzas
//
//  Created by Adriel Pinzas on 29/11/23.
//

import UIKit

typealias InitialProtocols = LoadingProtocol


class HomeViewController: UIViewController, InitialProtocols {
    private enum Constant {

    }
    private let interactor: HomeInteractorProtocol
    
    private lazy var homeNavigationTitleView: HomeNavigationTitleView = {
        let homeNavigationTitleView = HomeNavigationTitleView(title: "Test App".localized)
        homeNavigationTitleView.delegate = self
        return homeNavigationTitleView
    }()
    
    private lazy var homeView: HomeView = {
        let view = HomeView { [weak self] indentifier in
            self?.interactor.didSelect(identifier: indentifier)
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
     var loadingView = LoadingView()
    
    init(interactor: HomeInteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        navigationItem.titleView = homeNavigationTitleView
        view.backgroundColor = .white
        setUpNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNotification()
        interactor.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNotification()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setUpNavigationBar() {
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.title = " "
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = .white
        appearance.shadowColor = nil
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        
    }
    
    private func setupNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardNotification(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardNotification(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
        
    @objc private func keyboardNotification(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardBeginSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
              let duration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double),
            let curve = (notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt) else { return }
       
        UIView.animate(withDuration: duration, delay: 0.0, options: UIView.AnimationOptions(rawValue: curve)) {
            if notification.name == UIResponder.keyboardWillShowNotification {
                self.homeView.showKeyboard(with: keyboardBeginSize.height)
            } else if notification.name == UIResponder.keyboardWillHideNotification {
                self.homeView.hideKeyboard()
            }
        }
    }
    
    private func setupView() {
        view.addSubview(homeView)
        NSLayoutConstraint.activate([
            homeView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            homeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            homeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            homeView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension HomeViewController: HomePresenterDelegate {
    func showLoading() {
        startLoading()
    }
    
    func showContent(viewModel: Home.ViewModel) {
        stopLoading()
        homeView.render(viewModel: viewModel)
    }
    
    func showHideSearchBar(status: Bool) {
        homeNavigationTitleView.showSearchBar = status
    }
    
    func showEmptyView() {

    }
    
    func showError(_ error: Error) {
        print(error)
    }
}

extension HomeViewController: HomeNavigationTitleViewDelegateProtocol {
    func showSearchButtonTouched() {
        interactor.showSearchButtonTouched()
    }
    
    func searchBarCancelButtonTouched() {
        interactor.searchBarCancelButtonTouched()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        interactor.searchTextDidChange(searchText)
    }
}
