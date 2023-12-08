//
//  SearchServiceTests.swift
//  Ravn-Challenge-V3-Adriel-PinzasTests
//
//  Created by Adriel Pinzas on 7/12/23.
//

import XCTest
@testable import Ravn_Challenge_V3_Adriel_Pinzas

final class SearchServiceTests: XCTestCase {
    
    func testFilterLaunchesEmptySearchText() {
        let searchService = SearchService()
        let launches = [
            Launch(id: "1", missionName: "Apollo 11", launchDate: Date(), detail: "First Moon Landing"),
            Launch(id: "2", missionName: "SpaceX Falcon 9", launchDate: Date(), detail: "Commercial Satellite Launch"),
        ]
        
        let result = searchService.filterLaunches(launches, using: "")
        
        XCTAssertEqual(result, launches, "Filtering with empty search text should return all launches")
    }
    
    func testFilterLaunchesMatchingSearchText() {
        let searchService = SearchService()
        let launches = [
            Launch(id: "1", missionName: "Apollo 11", launchDate: Date(), detail: "First Moon Landing"),
            Launch(id: "2", missionName: "SpaceX Falcon 9", launchDate: Date(), detail: "Commercial Satellite Launch"),
        ]
        let searchText = "Apollo"
        
        let result = searchService.filterLaunches(launches, using: searchText)
        
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.missionName, "Apollo 11")
    }
    
    func testFilterLaunchesNoMatchingSearchText() {
        
        let searchService = SearchService()
        let launches = [
            Launch(id: "1", missionName: "Apollo 11", launchDate: Date(), detail: "First Moon Landing"),
            Launch(id: "2", missionName: "SpaceX Falcon 9", launchDate: Date(), detail: "Commercial Satellite Launch"),
        ]
        
        let searchText = "Titan"
        
        let result = searchService.filterLaunches(launches, using: searchText)
        
        XCTAssertTrue(result.isEmpty, "Filtering with non-matching search text should return an empty array")
    }
}
