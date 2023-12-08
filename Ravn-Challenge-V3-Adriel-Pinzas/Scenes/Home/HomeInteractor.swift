//
//  HomeInteractor.swift
//  Ravn-Challenge-V3-Adriel-Pinzas
//
//  Created by Adriel Pinzas on 29/11/23.
//

import Foundation
import Network

protocol HomeInteractorProtocol {
    func viewDidLoad()
    func showSearchButtonTouched()
    func searchBarCancelButtonTouched()
    func searchTextDidChange(_ searchText: String?)
    func didSelect(indexPath: IndexPath)
}

final class HomeInteractor: HomeInteractorProtocol {
    private let presenter: HomePresenterProtocol
    private let router: HomeRouterProtocol
    private let homeService: HomeServiceProtocol
    private let searchService: SearchServiceProtocol
    private let userDefaultsManager: UserDefaultsManagerProtocol
    private let networkRechabilityManager: NetworkRechabilityManagerProtocol
    private var launches: [Launch]?
    
    init(presenter: HomePresenterProtocol,
         router: HomeRouterProtocol,
         homeService: HomeServiceProtocol,
         searchService: SearchServiceProtocol,
         userDefaultsManager: UserDefaultsManagerProtocol,
         networkRechabilityManager: NetworkRechabilityManagerProtocol) {
        self.presenter = presenter
        self.router = router
        self.homeService = homeService
        self.searchService = searchService
        self.userDefaultsManager = userDefaultsManager
        self.networkRechabilityManager = networkRechabilityManager
    }
    
    func viewDidLoad() {
        if let launches: [Launch] = userDefaultsManager.get(key: .launches) {
            self.launches = launches
            presenter.present(content: launches)
        } else {
            presenter.showLoading()
            fetchLaunches()
        }
    }
    
    func showSearchButtonTouched() {
        presenter.showSearch()
    }
    
    func searchBarCancelButtonTouched() {
        presenter.hideSearch()
        guard let launches else { return }
        presenter.present(content: launches)
    }
    
    func searchTextDidChange(_ searchText: String?) {
        guard let launches, let searchText else { return }
        let filtered = searchService.filterLaunches(launches, using: searchText)
        presenter.present(content: filtered)
    }
    
    func didSelect(indexPath: IndexPath) {
        if let launch = launches?[indexPath.row] {
            router.navigateToDetail(with: launch)
        }
    }
    
    private func fetchLaunches() {
        homeService.fetchLaunches { [weak self] result in
            switch result {
            case .success(let launches):
                self?.launches = launches
                self?.saveInformation()
                self?.presenter.present(content: launches)
            case .failure(let error):
                if let self = self, self.getSavedLaunches().isEmpty {
                    self.presenter.showErrorView(error)
                } else {
                    self?.presenter.showAlertError(error)
                }
            }
        }
    }
    
    private func saveInformation() {
        if let launches = launches {
            userDefaultsManager.save(data: launches, key: .launches)
        }
    }
    
    private func getSavedLaunches() -> [Launch] {
        if let launches: [Launch] = self.userDefaultsManager.get(key: .launches) {
            return launches
        } else {
            return []
        }
    }
}

extension HomeInteractor: NetworkRechabilityManagerDelegate {
    func networkStatusDidChange(connected: Bool) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if connected {
                self.fetchLaunches()
                if self.getSavedLaunches().isEmpty {
                    self.presenter.showLoading()
                }
            } 
        }
    }
}
