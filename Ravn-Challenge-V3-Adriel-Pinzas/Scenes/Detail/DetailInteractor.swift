//
//  DetailInteractor.swift
//  Ravn-Challenge-V3-Adriel-Pinzas
//
//  Created by Adriel Pinzas on 7/12/23.
//

import Foundation

protocol DetailInteractorProtocol {
    func viewDidLoad()
}

final class DetailInteractor: DetailInteractorProtocol {

    private let presenter: DetailPresenterProtocol
    private let launch: Launch
    
    
    init(presenter: DetailPresenterProtocol, launch: Launch) {
        self.presenter = presenter
        self.launch = launch
    }
    
    func viewDidLoad() {
        presenter.present(launch: launch)
    }
}
