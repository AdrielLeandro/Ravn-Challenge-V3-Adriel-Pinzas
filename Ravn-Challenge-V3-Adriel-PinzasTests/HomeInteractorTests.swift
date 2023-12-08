//
//  HomeInteractorTests.swift
//  Ravn-Challenge-V3-Adriel-PinzasTests
//
//  Created by Adriel Pinzas on 7/12/23.
//

import XCTest
@testable import Ravn_Challenge_V3_Adriel_Pinzas

final class HomeInteractorTests: XCTestCase {
    func testViewDidLoadWithSavedLaunches() {
        let mockPresenter = MockHomePresenter()
        let mockRouter = MockHomeRouter()
        let mockHomeService = MockHomeService()
        let mockSearchService = MockSearchService()
        let mockUserDefaultsManager = MockUserDefaultsManager()
        let mockNetworkRechabilityManager = MockNetworkRechabilityManager()

        let homeInteractor = HomeInteractor(
            presenter: mockPresenter,
            router: mockRouter,
            homeService: mockHomeService,
            searchService: mockSearchService,
            userDefaultsManager: mockUserDefaultsManager,
            networkRechabilityManager: mockNetworkRechabilityManager
        )

        let mockLaunches = [Launch(id: "1", missionName: "Mock Launch", launchDate: Date(), detail: "Mock Details")]
        mockUserDefaultsManager.savedData[.launches] = mockLaunches

        homeInteractor.viewDidLoad()

        XCTAssertTrue(mockPresenter.didCallPresent)
        XCTAssertFalse(mockPresenter.didCallShowLoading)
    }

    func testViewDidLoadWithoutSavedLaunches() {
        let mockPresenter = MockHomePresenter()
        let mockRouter = MockHomeRouter()
        let mockHomeService = MockHomeService()
        let mockSearchService = MockSearchService()
        let mockUserDefaultsManager = MockUserDefaultsManager()
        let mockNetworkRechabilityManager = MockNetworkRechabilityManager()

        let homeInteractor = HomeInteractor(
            presenter: mockPresenter,
            router: mockRouter,
            homeService: mockHomeService,
            searchService: mockSearchService,
            userDefaultsManager: mockUserDefaultsManager,
            networkRechabilityManager: mockNetworkRechabilityManager
        )
        
        mockHomeService.shouldSucceed = false
        
        homeInteractor.viewDidLoad()

        XCTAssertTrue(mockPresenter.didCallShowLoading)
        XCTAssertFalse(mockPresenter.didCallPresent)
    }

    func testShowSearchButtonTouched() {
        let mockPresenter = MockHomePresenter()
        let mockRouter = MockHomeRouter()
        let mockHomeService = MockHomeService()
        let mockSearchService = MockSearchService()
        let mockUserDefaultsManager = MockUserDefaultsManager()
        let mockNetworkRechabilityManager = MockNetworkRechabilityManager()

        let homeInteractor = HomeInteractor(
            presenter: mockPresenter,
            router: mockRouter,
            homeService: mockHomeService,
            searchService: mockSearchService,
            userDefaultsManager: mockUserDefaultsManager,
            networkRechabilityManager: mockNetworkRechabilityManager
        )

        homeInteractor.showSearchButtonTouched()
        XCTAssertTrue(mockPresenter.didCallShowSearch)
    }

    func testNetworkStatusDidChangeConnected() {
        let expectation = XCTestExpectation(description: "Fetch launches and show loading")

        let mockPresenter = MockHomePresenter()
        let mockRouter = MockHomeRouter()
        let mockHomeService = MockHomeService()
        let mockSearchService = MockSearchService()
        let mockUserDefaultsManager = MockUserDefaultsManager()
        let mockNetworkRechabilityManager = MockNetworkRechabilityManager()

        let homeInteractor = HomeInteractor(
            presenter: mockPresenter,
            router: mockRouter,
            homeService: mockHomeService,
            searchService: mockSearchService,
            userDefaultsManager: mockUserDefaultsManager,
            networkRechabilityManager: mockNetworkRechabilityManager
        )

        mockPresenter.showLoadingHandler = {
            expectation.fulfill()
        }
        
        mockNetworkRechabilityManager.isConnected = true
        mockHomeService.shouldSucceed = false
        homeInteractor.networkStatusDidChange(connected: true)

        wait(for: [expectation], timeout: 1.0)

        XCTAssertTrue(mockPresenter.didCallShowLoading)
        XCTAssertTrue(mockHomeService.didCallfetchLaunches)
    }

    func testNetworkStatusDidChangeDisconnected() {
        let mockPresenter = MockHomePresenter()
        let mockRouter = MockHomeRouter()
        let mockHomeService = MockHomeService()
        let mockSearchService = MockSearchService()
        let mockUserDefaultsManager = MockUserDefaultsManager()
        let mockNetworkRechabilityManager = MockNetworkRechabilityManager()

        let homeInteractor = HomeInteractor(
            presenter: mockPresenter,
            router: mockRouter,
            homeService: mockHomeService,
            searchService: mockSearchService,
            userDefaultsManager: mockUserDefaultsManager,
            networkRechabilityManager: mockNetworkRechabilityManager
        )

        mockNetworkRechabilityManager.isConnected = false
        homeInteractor.networkStatusDidChange(connected: false)

        XCTAssertFalse(mockPresenter.didCallShowLoading)
        XCTAssertFalse(mockHomeService.didCallfetchLaunches)
    }
}
