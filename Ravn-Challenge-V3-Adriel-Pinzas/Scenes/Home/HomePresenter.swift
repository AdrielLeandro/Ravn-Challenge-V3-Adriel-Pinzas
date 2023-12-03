//
//  HomePresenter.swift
//  Ravn-Challenge-V3-Adriel-Pinzas
//
//  Created by Adriel Pinzas on 29/11/23.
//

import UIKit
import SpaceXAPI

protocol HomePresenterProtocol {
    func presentSearchResults(content: Home.Content)
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
        
        delegate?.showContent(viewModel: viewModel(from: content.launches))
    }
    
    func presentSavedData(content: Home.Content) {
        delegate?.showContent(viewModel: viewModel(from: content.launches))
    }
    
    func presentSearchResults(content: Home.Content) {
        delegate?.showContent(viewModel: viewModel(from: content.launches))
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
    
    private func viewModel(from launches: [GetLaunchesQuery.Data.Launch]) -> Home.ViewModel {
        return Home.ViewModel(title: "Launches App", items: createViewModelLaunchItem(from: launches))
    }
    
    private func createViewModelLaunchItem(from launches: [GetLaunchesQuery.Data.Launch]) -> [Home.ViewModel.LaunchItem] {
        let items = launches.compactMap({ launch -> Home.ViewModel.LaunchItem in
            let item = Home.ViewModel.LaunchItem(title: launch.mission_name ?? "", date: launch.launch_date_local ?? "")
            return item
        })
        return items
    }
}
