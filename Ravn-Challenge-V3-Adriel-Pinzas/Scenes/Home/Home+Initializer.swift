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
        let homeService = HomeService(manager: ServiceManager())
        let searchService = SearchService()
        let presenter = HomePresenter()
        let router = HomeRouter(navigation: navigation)
        let interactor = HomeInteractor(presenter: presenter, router: router, homeService: homeService, searchService: searchService)
        let viewController = HomeViewController(interactor: interactor)
        presenter.delegate = viewController
        navigation.setViewControllers([viewController], animated: false)
        return navigation
    }
}
