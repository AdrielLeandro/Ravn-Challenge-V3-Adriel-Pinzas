//
//  Home+Initializer.swift
//  Ravn-Challenge-V3-Adriel-Pinzas
//
//  Created by Adriel Pinzas on 30/11/23.
//

import UIKit

extension Home {
    static func createScene() -> UIViewController {
        let navigation = UINavigationController()
        let homeService = HomeService()
        let searchService = SearchService()
        let presenter = HomePresenter()
        let networkRechability = NetworkRechabilityManager()
        let router = HomeRouter(navigation: navigation)
        let interactor = HomeInteractor(presenter: presenter, router: router, homeService: homeService, searchService: searchService, userDefaultsManager: UserDefaultManager(), networkRechabilityManager: networkRechability)
        networkRechability.delegate = interactor
        let viewController = HomeViewController(interactor: interactor)
        presenter.delegate = viewController
        navigation.setViewControllers([viewController], animated: false)
        return navigation
    }
}
