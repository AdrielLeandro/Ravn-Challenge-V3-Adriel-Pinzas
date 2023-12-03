//
//  HomePresenter.swift
//  Ravn-Challenge-V3-Adriel-Pinzas
//
//  Created by Adriel Pinzas on 29/11/23.
//

import UIKit

protocol HomePresenterProtocol {
    func present(content: [Launch]?)
    func presentSearchResults(content: [Launch])
    func presentSavedData(content: [Launch])
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

    func present(content: [Launch]?) {
        guard let content else {
            delegate?.showLoading()
            return
        }
        
        delegate?.showContent(viewModel: viewModel(from: content))
    }
    
    func presentSavedData(content: [Launch]) {
        delegate?.showContent(viewModel: viewModel(from: content))
    }
    
    func presentSearchResults(content: [Launch]) {
        delegate?.showContent(viewModel: viewModel(from: content))
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
    
    private func viewModel(from launches: [Launch]) -> Home.ViewModel {
        return Home.ViewModel(title: "Launches App", items: createViewModelLaunchItem(from: launches))
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
