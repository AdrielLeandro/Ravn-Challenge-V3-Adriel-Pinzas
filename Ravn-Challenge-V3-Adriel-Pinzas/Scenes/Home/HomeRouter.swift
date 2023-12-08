//
//  HomeRouter.swift
//  Ravn-Challenge-V3-Adriel-Pinzas
//
//  Created by Adriel Pinzas on 29/11/23.
//

import UIKit

protocol HomeRouterProtocol {
    func navigateToDetail(with launch: Launch)
}

final class HomeRouter: HomeRouterProtocol {
    
    private let navigation: UINavigationController
    
    init(navigation: UINavigationController) {
        self.navigation = navigation
    }
    
    func navigateToDetail(with launch: Launch) {
        let scene = Detail.createScene(navigationController: navigation, launch: launch)
        navigation.pushViewController(scene, animated: true)
    }
}
