//
//  HomePresenter.swift
//  Ravn-Challenge-V3-Adriel-Pinzas
//
//  Created by Adriel Pinzas on 29/11/23.
//

import UIKit

protocol HomePresenterProtocol {
    func present(content: [Launch]?)
    func showAlertError(_ error: Error)
    func showErrorView(_ error: Error)
    func showLoading()
    func showSearch()
    func hideSearch()
}

protocol HomePresenterDelegate: UIViewController {
    func showLoading()
    func showEmptyView()
    func showAlertError(_ error: Error)
    func showErrorView(_ error: Error)
    func showContent(viewModel: Home.ViewModel)
    func showHideSearchBar(status: Bool)
}


final class HomePresenter: HomePresenterProtocol {
    weak var delegate: HomePresenterDelegate?

    func present(content: [Launch]?) {
        if let content = content, !content.isEmpty {
            delegate?.showContent(viewModel: viewModel(from: content))
        } else {
            delegate?.showEmptyView()
        }
    }
    
    func showLoading() {
        delegate?.showLoading()
    }

    func showAlertError(_ error: Error) {
        delegate?.showAlertError(error)
    }
    
    func showErrorView(_ error: Error) {
        delegate?.showErrorView(error)
    }
    
    func showSearch() {
        delegate?.showHideSearchBar(status: true)
    }
    
    func hideSearch() {
        delegate?.showHideSearchBar(status: false)
    }
    
    private func viewModel(from launches: [Launch]) -> Home.ViewModel {
        return Home.ViewModel(title: "view.title".localized, items: createViewModelLaunchItem(from: launches))
    }
    
    private func createViewModelLaunchItem(from launches: [Launch]) -> [Home.ViewModel.LaunchItem] {
        let items = launches.compactMap({ launch -> Home.ViewModel.LaunchItem in
            let item = Home.ViewModel.LaunchItem(title: launch.missionName,
                                                 date: launch.launchDate)
            return item
        })
        return items
    }
}
