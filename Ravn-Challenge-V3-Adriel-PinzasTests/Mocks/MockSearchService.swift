//
//  MockSearchService.swift
//  Ravn-Challenge-V3-Adriel-PinzasTests
//
//  Created by Adriel Pinzas on 7/12/23.
//

import Foundation
@testable import Ravn_Challenge_V3_Adriel_Pinzas

final class MockSearchService: SearchServiceProtocol {
    var filteredLaunches: [Launch] = []

    func filterLaunches(_ launches: [Launch], using searchText: String) -> [Launch] {
        // For simplicity, the mock implementation filters launches based on whether the name contains the search text.
        filteredLaunches = launches.filter { $0.missionName.lowercased().contains(searchText.lowercased()) }
        return filteredLaunches
    }
}
