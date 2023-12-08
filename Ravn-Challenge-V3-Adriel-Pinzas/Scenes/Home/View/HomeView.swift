//
//  HomeView.swift
//  Ravn-Challenge-V3-Adriel-Pinzas
//
//  Created by Adriel Pinzas on 29/11/23.
//

import UIKit


protocol HomeViewProtocol {
    func showKeyboard(with height: CGFloat)
    func hideKeyboard()
    func render(viewModel: Home.ViewModel)
}

final class HomeView: UIView {
    
    private lazy var tableView: UITableView = {
        let launchesTableView = UITableView()
        launchesTableView.translatesAutoresizingMaskIntoConstraints = false
        launchesTableView.separatorStyle = .none
        launchesTableView.dataSource = self
        launchesTableView.delegate = self
        launchesTableView.sectionHeaderTopPadding = 0
        return launchesTableView
    }()
    private var launches: [Home.ViewModel.LaunchItem] = []
    private var onTap: ((IndexPath) -> Void)?

    init(onTap: @escaping (IndexPath) -> Void) {
        super.init(frame: .zero)
        self.onTap = onTap
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTableView() {
        tableView.register(HomeLaunchTableViewCell.self, forCellReuseIdentifier: String(describing: HomeLaunchTableViewCell.self))
        addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension HomeView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return launches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HomeLaunchTableViewCell.self), for: indexPath) as? HomeLaunchTableViewCell {
            cell.setup(from: launches[indexPath.row])
            return cell
        }
        
        return UITableViewCell()
    }
}

extension HomeView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onTap?(indexPath)
    }
}

extension HomeView: HomeViewProtocol {
    func showKeyboard(with height: CGFloat) {
        tableView.setBottomInset(to: height)
    }
    
    func hideKeyboard() {
        tableView.setBottomInset(to: .zero)
    }
    
    func render(viewModel: Home.ViewModel) {
        launches = viewModel.items
        tableView.reloadData()
    }

}
