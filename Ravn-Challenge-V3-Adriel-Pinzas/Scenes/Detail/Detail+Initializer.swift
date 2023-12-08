//
//  Detail+Initializer.swift
//  Ravn-Challenge-V3-Adriel-Pinzas
//
//  Created by Adriel Pinzas on 7/12/23.
//

import UIKit

extension Detail {
    static func createScene(navigationController: UINavigationController, launch: Launch) -> UIViewController {
        let detailPresenter = DetailPresenter()
        let detailInteractor = DetailInteractor(presenter: detailPresenter, launch: launch)
        let detailViewController = DetailViewController(interactor: detailInteractor)
        detailPresenter.delegate = detailViewController
        return detailViewController
    }
}
