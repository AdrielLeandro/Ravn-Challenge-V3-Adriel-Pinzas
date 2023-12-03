//
//  HomePresenter.swift
//  Ravn-Challenge-V3-Adriel-Pinzas
//
//  Created by Adriel Pinzas on 29/11/23.
//

import UIKit

protocol HomePresenterProtocol {
    func presentSearchResults(_ launches: [Launch])
    func present(content: Home.Content?)
    func presentSavedData(content: Home.Content)
    func show(error: Error)
    func showSearch()
    func hideSearch()
}

protocol HomePresenterDelegate: UIViewController {
    func showLoading()
    func showEmptyView()
    func showError(_ error: Error)
    func showContent(viewModel: Home.ViewModel)
    func showHideSearchBar(status: Bool)
}


final class HomePresenter: HomePresenterProtocol {
    weak var delegate: HomePresenterDelegate?

    func present(content: Home.Content?) {
        guard let content else {
            delegate?.showLoading()
            return
        }
        
        delegate?.showContent(viewModel: viewModel(from: content.homeResponse))
    }
    
    func presentSavedData(content: Home.Content) {
        delegate?.showContent(viewModel: viewModel(from: content.homeResponse))
    }
    
    func presentSearchResults(_ launches: [Launch]) {
        delegate?.showContent(viewModel: Home.ViewModel(title: "Launches App", items: createViewModelLaunchItem(from: launches)))
    }
    
    func show(error: Error) {
        delegate?.showError(error)
    }
    
    func showSearch() {
        delegate?.showHideSearchBar(status: true)
    }
    
    func hideSearch() {
        delegate?.showHideSearchBar(status: false)
    }
    
    private func viewModel(from response: HomeResponse) -> Home.ViewModel {
        return Home.ViewModel(title: "Launches App", items: createViewModelLaunchItem(from: response.launches))
    }
    
    private func createViewModelLaunchItem(from launches: [Launch]) -> [Home.ViewModel.LaunchItem] {
        let items = launches.compactMap({ launch -> Home.ViewModel.LaunchItem in
            let item = Home.ViewModel.LaunchItem(title: launch.name ?? "", date: launch.date ?? "")
            return item
        })
        return items
    }
}
