//
//  HomeInteractor.swift
//  Ravn-Challenge-V3-Adriel-Pinzas
//
//  Created by Adriel Pinzas on 29/11/23.
//

import Foundation

protocol HomeInteractorProtocol {
    func viewDidLoad()
    func showSearchButtonTouched()
    func searchBarCancelButtonTouched()
    func searchTextDidChange(_ searchText: String?)
    func didSelect(identifier: String)
}

class HomeInteractor: HomeInteractorProtocol {
    private let presenter: HomePresenterProtocol
    private let router: HomeRouterProtocol
    private let homeService: HomeServiceProtocol
    private let searchService: SearchServiceProtocol
    private var response: HomeResponse?
    
    init(presenter: HomePresenterProtocol,
         router: HomeRouterProtocol,
         homeService: HomeServiceProtocol,
         searchService: SearchServiceProtocol) {
        self.presenter = presenter
        self.router = router
        self.homeService = homeService
        self.searchService = searchService
    }
    
    func viewDidLoad() {
        if let homeResponseData = UserDefaults.standard.data(forKey: "homeResponse"),
           let homeResponse = try? JSONDecoder().decode(HomeResponse.self, from: homeResponseData) {
            presenter.presentSavedData(content: Home.Content(homeResponse: homeResponse))
        } else {
            presenter.present(content: nil)
        }
        fetchLaunches()
    }
    
    func showSearchButtonTouched() {
        presenter.showSearch()
    }
    
    func searchBarCancelButtonTouched() {
        presenter.hideSearch()
        guard let response else { return }
        presenter.present(content: Home.Content(homeResponse: response))
    }
    
    func searchTextDidChange(_ searchText: String?) {
        guard let response, let searchText else { return }
        let filtered = searchService.filterLaunches(response.launches, using: searchText)
        presenter.presentSearchResults(filtered)
    }
    
    func didSelect(identifier: String) {
        
    }
    
    private func fetchLaunches() {
        homeService.fetchLauches { [weak self] result in
            switch result {
            case .success(let response):
                self?.response = response
                self?.saveInformation()
                self?.presenter.present(content: Home.Content(homeResponse: response))
            case .failure(let error):
                self?.presenter.show(error: error)
            }
        }
    }
    
    private func saveInformation() {
        if let response = response,
           let data = try? JSONEncoder().encode(response) {
            UserDefaults.standard.set(data, forKey: "homeResponse")
        }
    }
}
