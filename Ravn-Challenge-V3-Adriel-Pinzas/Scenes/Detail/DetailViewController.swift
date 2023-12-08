//
//  DetailViewController.swift
//  Ravn-Challenge-V3-Adriel-Pinzas
//
//  Created by Adriel Pinzas on 7/12/23.
//

import UIKit

final class DetailViewController: UIViewController {
    
    private let interactor: DetailInteractorProtocol
    private let detailView = DetailView()

    init(interactor: DetailInteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        setUpNavigationBar()
        view.backgroundColor = .white
    }
    
    private func setUpNavigationBar() {
        let appearance = UINavigationBarAppearance()
        let backButton = UIImage(named: "backIcon")
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = UIColor(named: "goldColor")
        appearance.shadowColor = nil
        appearance.setBackIndicatorImage(backButton, transitionMaskImage: backButton)
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        interactor.viewDidLoad()
    }
    
    private func setUpView() {
        detailView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(detailView)
        
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            detailView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
}

extension DetailViewController: DetailPresenterDelegate {
    
    func showContent(viewModel: Detail.DetailViewModel) {
        title = viewModel.title
        detailView.setup(with: viewModel)
    }
}
