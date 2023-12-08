//
//  MockHomePresenter.swift
//  Ravn-Challenge-V3-Adriel-PinzasTests
//
//  Created by Adriel Pinzas on 7/12/23.
//

import Foundation
@testable import Ravn_Challenge_V3_Adriel_Pinzas

final class MockHomePresenter: HomePresenterProtocol {
    var didCallPresent = false
    var didCallShowAlertError = false
    var didCallShowErrorView = false
    var didCallShowLoading = false
    var didCallShowSearch = false
    var didCallHideSearch = false

    var showLoadingHandler: (() -> Void)?
    
    func present(content: [Launch]?) {
        didCallPresent = true
    }

    func showAlertError(_ error: Error) {
        didCallShowAlertError = true
    }

    func showErrorView(_ error: Error) {
        didCallShowErrorView = true
    }

    func showLoading() {
        didCallShowLoading = true
        showLoadingHandler?()
    }

    func showSearch() {
        didCallShowSearch = true
    }

    func hideSearch() {
        didCallHideSearch = true
    }
}
