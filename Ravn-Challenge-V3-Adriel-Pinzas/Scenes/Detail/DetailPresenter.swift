//
//  DetailPresenter.swift
//  Ravn-Challenge-V3-Adriel-Pinzas
//
//  Created by Adriel Pinzas on 7/12/23.
//

import UIKit

protocol DetailPresenterProtocol {
    func present(launch: Launch)
}

protocol DetailPresenterDelegate: UIViewController {
    func showContent(viewModel: Detail.DetailViewModel)
}

final class DetailPresenter: DetailPresenterProtocol {
    
    weak var delegate: DetailPresenterDelegate?
    
    func present(launch: Launch) {
        let missionName = launch.missionName
        let launchDate = "detail.date".localized.localizedFormat(launch.launchDate?.toString() ?? "date.error".localized)
        let launchDetail = launch.detail.isEmpty ? "not.description".localized :  launch.detail
        
        delegate?.showContent(viewModel: Detail.DetailViewModel(title: "Detail".localized,
                                                                missionName: missionName,
                                                                launchDate: launchDate,
                                                                launchDetail: launchDetail))
    }
}
