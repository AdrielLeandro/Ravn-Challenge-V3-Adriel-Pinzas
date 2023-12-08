//
//  MockHomeRouter.swift
//  Ravn-Challenge-V3-Adriel-PinzasTests
//
//  Created by Adriel Pinzas on 7/12/23.
//

import Foundation
@testable import Ravn_Challenge_V3_Adriel_Pinzas

final class MockHomeRouter: HomeRouterProtocol {
    var didCallNavigateToDetail = false
    var launchedDetail: Launch?

    func navigateToDetail(with launch: Launch) {
        didCallNavigateToDetail = true
        launchedDetail = launch
    }
}
