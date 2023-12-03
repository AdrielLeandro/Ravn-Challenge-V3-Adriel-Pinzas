//
//  HomeRouter.swift
//  Ravn-Challenge-V3-Adriel-Pinzas
//
//  Created by Adriel Pinzas on 29/11/23.
//

import UIKit

protocol HomeRouterProtocol {
    
}

final class HomeRouter: HomeRouterProtocol {
    private let navigation: UINavigationController
    
    init(navigation: UINavigationController) {
        self.navigation = navigation
    }
    
}
